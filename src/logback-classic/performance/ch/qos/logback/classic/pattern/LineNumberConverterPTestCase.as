package ch.qos.logback.classic.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LineNumberConverterPTestCase {
		
		private var converter:LineNumberConverter = new LineNumberConverter();
		
		public function testApply():void {
			converter.apply("%line", null);
		}
		
		public function testApplyWithAlign():void {
			converter.apply("%100line", null);
		}
	}
}
