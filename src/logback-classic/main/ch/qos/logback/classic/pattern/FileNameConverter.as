package ch.qos.logback.classic.pattern {
	
	import ch.qos.logback.core.Appender;
	import ch.qos.logback.core.Layout;
	import ch.qos.logback.core.Logger;
	import ch.qos.logback.core.LoggerEntry;

	import flash.system.Capabilities;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FileNameConverter extends AbstractConverter {
//		TODO Add parameter support for 'full' and 'short' ("/home/rfkrocktk/Project/TK/src/Application.as" vs "Application.as")
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:file|F)(?:\\{(.*)\\})?");
		
		private var classNameExpression:RegExp = new RegExp("at (.*?)/");
		
		private var fileNameExpression:RegExp = new RegExp("at .*?\\[(.*?):(\\d+)\\]", "m");
		
		private var newlineExpression:RegExp = new RegExp("\n");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
				
			var stacktrace:String = new Error().getStackTrace();
			
//			if the Flash Player isn't a debug edition or the SWF itself isn't 
//			compiled with debug=true, just return a blank string.
			if (!Capabilities.isDebugger || !fileNameExpression.test(stacktrace))
				return "";
			
			var matchGroup:Object = expression.exec(pattern);
			var alignment:String = matchGroup[1];
			var parameters:String = matchGroup[2];
			
			if (parameters == null)
				parameters = null; // avoid FDT warnings!
				
		 	if (entry == null)
		 		entry = null; // avoid FDT warnings!
				
			var result:String = "";
			var lines:Array = stacktrace.split(newlineExpression);
			
			for each (var line:String in lines) {
				if (fileNameExpression.test(line)) {
//					we have a match, now we have to test to make sure it isn't a logback type
					var lineMatch:Object = classNameExpression.exec(line);
					var definitionName:String = lineMatch[1];
					var definition:* = getDefinition(definitionName);
//					if it isn't a logback object, append it
					if (!isLogbackObject(definition)) {
						result = fileNameExpression.exec(line)[1];
						break;
					}
				} else {
					continue;
				}
			}
			
			return this.align(result, alignment);
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
				if (interfaceType == Logger || interfaceType == Appender || interfaceType == Layout ||
						interfaceType == Converter)
					return true;
			}
			
			return false;
		}
	}
}
