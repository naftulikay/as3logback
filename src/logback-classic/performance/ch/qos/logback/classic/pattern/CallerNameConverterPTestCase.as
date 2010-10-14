package ch.qos.logback.classic.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class CallerNameConverterPTestCase {
		
		private var converter:CallerNameConverter = new CallerNameConverter();
		
		public function testApply():void {
			converter.apply("%caller", null);
		}
		
		public function testApplyWithAlign():void {
			converter.apply("%100caller", null);
		}
		
		public function testApplyFull():void {
			converter.apply("%caller{100}", null);
		}
		
		public function testApplyFullWithAlign():void {
			converter.apply("%100caller{100}", null);
		}
	}
}
