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
			var parts:Array = value.split(".");
			
			var result:String = "";
			
			var calculatedLength:int = value.length;
			
			if (value.length > maxChars) {
				
				for each (var part:String in parts) {
					if (calculatedLength > maxChars) {
						var index:int = parts.indexOf(part);
						
						if (index != parts.length - 1) {
//							we're not at the end yet, so we'll trim if need be.
							result += part.charAt(0) + ".";
							calculatedLength -= (part.length - 1);
						} else {
//							we're at the end, so append it as is.
							result += part;
						}
					} else {
						break;
					}
				}
			}
			
			return result;
		}
	}
}
