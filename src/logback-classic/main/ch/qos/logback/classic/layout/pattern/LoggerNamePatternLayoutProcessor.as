package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LoggerNamePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:logger|lo|c)(?:\\{(.*)\\})?");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			var result:String = entry.loggerName;
			
			var matchGroup:Object = expression.exec(pattern);
			
//			shrink-a-dink it.
			if (matchGroup[2] != null && matchGroup[2] != undefined &&
					matchGroup[2] != "") 
				result = this.shrink(result, matchGroup[2]);	
			
//			align it.
			result = this.align(result, matchGroup[1]);
			
			return result;
		}
		
		public function shrink(value:String, maxChars:Number):String {
//			if there's no need to shrink, just return the value straight up.
			if (value.length < maxChars)
				return value;
			
			var parts:Array = value.split(".");
			
			var result:String = "";
			
			var calculatedLength:int = value.length;
			
			if (value.length > maxChars) {
//				if the logger name is longer than the max characters allowed, shrink it
				for each (var part:String in parts) {
					var index:int = parts.indexOf(part);
					
					if (calculatedLength > maxChars) {
//						if the calculated size of the result is greater than the max characters allowed				
						if (index != parts.length - 1) {
//							we're not at the end yet, so we'll trim if need be, appending a period
							result += part.charAt(0) + ".";
							calculatedLength -= (part.length - 1);
						} else {
//							we're at the end, so append it as is
							result += part;
						}
					} else {
//						if the calculated size of the result is less than or equal to the max characters allowed
						if (index != parts.length - 1) {
//							we're not at the end, so insert the part and a postfixed period
							result += part + ".";
						} else {
//							we're at the end, so just append the part
							result += part;
						}
					}
				}
			}
			
			return result;
		}
	}
}
