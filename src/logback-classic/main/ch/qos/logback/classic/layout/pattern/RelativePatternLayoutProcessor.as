package ch.qos.logback.classic.layout.pattern {
	import flash.utils.getTimer;
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class RelativePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = /%((?:\-?[0-9]+)?\.?(?:\-?[0-9]+))?(?:r|relative)/;
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry):String {
			if (!test(pattern))
				return null;
				
			if (entry == null)
				entry = null; // fight FDT warnings!
				
			var result:String = getTimer().toString();
			var alignment:String = expression.exec(pattern)[1];
			
			return align(result, alignment);
		}
	}
}
