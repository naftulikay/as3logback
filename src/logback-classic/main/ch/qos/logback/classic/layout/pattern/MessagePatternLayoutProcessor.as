package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class MessagePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:message|msg|m)(?:\\{(.*)\\})?");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
			
			var matchGroup:Object = expression.exec(pattern);
			var alignment:String = matchGroup[1];
			
			return align(entry.formattedMessage, alignment);
		}
	}
}
