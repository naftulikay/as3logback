package ch.qos.logback.classic.pattern {
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NewlineConverter implements Converter {
		
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
