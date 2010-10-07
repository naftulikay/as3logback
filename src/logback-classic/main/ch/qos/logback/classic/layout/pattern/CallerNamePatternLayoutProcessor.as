package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.Layout;
	import ch.qos.logback.core.Appender;
	import ch.qos.logback.core.Logger;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class CallerNamePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
//		FIXME output from apply() should be formatted, so that 'com.tkassembled::Classy/call()' looks like 'com.tkassembled.Classy.call()'
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?caller(?:\\{(.*)\\})?");
		
		private var lineExpression:RegExp = new RegExp("at (?:global/)?((?:\\w+\\.?)+)?(?:::)?(?:(\\w+)?(?:/?)(\\w+)?)?(.*)");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern) && (entry == null || entry != null)) // this really doesn't do anything, just prevents FDT warnings.
				return null;
			
//			first, generate the stacktrace.
			var stacktrace:String = null;
			try {
				throw new Error();
			} catch (e:Error) {
				stacktrace = e.getStackTrace();
			}
			
			var result:Array = [];
			var lines:Array = stacktrace.split(new RegExp("\\n"));
			var matchGroup:Object = this.expression.exec(pattern);
			var maxLines:int = int(matchGroup[2]);
			
			if (maxLines == 0)
				maxLines = 1;
			
			for (var i:uint = 0; i < lines.length; i++) {
				var line:String = lines[i];
				
				if (lineExpression.test(line)) {
					var lineOutput:String = "Caller+" + result.length + line;
					var definition:* = getDefinition(line);
					if (definition is Function) {
//						if it's a function, let it on through.
						result.push(lineOutput);
					} else if (definition is Class) {
//						if it's a class, make sure it's not a logback class.
						if (!isLogbackObject(definition))
							result.push(lineOutput);
					}
				}
				
				if (result.length == maxLines)
					break;
			}
			
//			finally, align 'em.
			return this.align(result.join("\n"), matchGroup[1]);
		}
	
		public function getDefinition(value:String):* {
			var matchGroup:Object = this.lineExpression.exec(value);
			var qualifiedName:String = matchGroup[1];
			
			if (matchGroup[2])
				qualifiedName += "." + matchGroup[2];
				
			try {
				return getDefinitionByName(qualifiedName);
			} catch (e:Error) {
				return null;
			}
		}
		
		public function isLogbackObject(definition:Class):Boolean {
			var description:XML = describeType(definition);
			
			for each (var interfase:XML in description.descendants("implementsInterface")) {
				var interfaceType:Class = Class(getDefinitionByName(interfase.attribute("type").toString()));
				if (interfaceType == Logger || interfaceType == Appender || 
						interfaceType == Layout || interfaceType == PatternLayoutProcessor)
					return true;
			}
			
			return false;
		}
	}
}
