package ch.qos.logback.classic.pattern {
	
	
	import flash.utils.getQualifiedClassName;
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ClassNameConverter extends AbstractConverter {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:class|C)(?:\\{(.*)\\})?");
		
		private var loggerNameProcessor:LoggerNameConverter = 
				new LoggerNameConverter();
				
		private var callerNameProcessor:CallerNameConverter = 
				new CallerNameConverter();
		
		override public function test(pattern:String):Boolean { 
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
			
			var matchGroup:Object = this.expression.exec(pattern);
			
			var align:String = matchGroup[1];
			
			var length:int = int(matchGroup[2]);
			
			if (matchGroup[2] == "" || matchGroup[2] == null)
				length = int.MAX_VALUE;
//			get the calling class definition
			var caller:* = callerNameProcessor.getDefinition(
				callerNameProcessor.apply("%caller", entry));
//			get the qualified class name. 
			var result:String = getQualifiedClassName(caller).replace("::",".");
//			trim the class name
			result = loggerNameProcessor.shrink(result, length);
//			align the result
			result = this.align(result, align);
			
			return result;
		}
	}
}
