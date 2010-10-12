package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.Appender;
	import ch.qos.logback.core.Layout;
	import ch.qos.logback.core.Logger;
	import ch.qos.logback.core.LoggerEntry;

	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class MethodNamePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:method|M)(?:\\{(.*)\\})?");
		
		private var classNameExpression:RegExp = new RegExp("at (.*?)/(.*?)\\(\\)");
		
		private var newlineExpression:RegExp = new RegExp("\\n");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
				
			if (entry == null)
				entry = null; // fight FDT warnings!
				
			var stacktrace:String = null;
			try {
				throw new Error();
			} catch (e:Error) {
				stacktrace = e.getStackTrace();
			}
			
			var matchGroup:Object = expression.exec(pattern);
			var alignment:String = matchGroup[1];
			
			var result:String = "";
			var lines:Array = stacktrace.split(newlineExpression);
			
			for each (var line:String in lines) {
				if (classNameExpression.test(line)) {
					var lineMatches:Object = classNameExpression.exec(line);
					var className:String = lineMatches[1];
					var methodName:String = lineMatches[2];
										
					if (!isLogbackObject(getDefinition(className))) {
						result = methodName;
						break;
					}
				} else {
					continue;
				}
			}
			
			return align(result, alignment);
		}
		
		public function getDefinition(name:String):* {
			try {
				return getDefinitionByName(name);
			} catch (e:Error) {
				return null;
			}
		}
		
		public function isLogbackObject(definition:*):Boolean {
			var description:XML = describeType(definition);
			for each (var interfase:XML in description.descendants("implementsInterface")) {
				var interfaceType:Class = getDefinition(interfase.attribute("type").toString());
				if (interfaceType == Logger || interfaceType == Appender ||
						interfaceType == Layout || interfaceType == PatternLayoutProcessor)
					return true;	
			}
			
			return false;
		}
	}
}
