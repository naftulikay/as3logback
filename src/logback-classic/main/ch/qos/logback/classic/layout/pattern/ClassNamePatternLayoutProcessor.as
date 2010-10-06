package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ClassNamePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:class|C)(?:\\{(.*)\\})?");
		
		override public function test(pattern:String):Boolean { 
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			return null;
		}
	}
}
