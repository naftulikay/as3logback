package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NewlinePatternLayoutProcessor implements PatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%n");
		
		public function test(pattern:String) : Boolean {
			return expression.test(pattern);
		}

		public function apply(pattern:String, entry:LoggerEntry) : String {
			if (test(pattern)) {
				return "\n";
			} else {
				return pattern;
			}
		}
	}
}
