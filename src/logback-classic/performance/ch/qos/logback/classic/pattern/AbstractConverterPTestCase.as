package ch.qos.logback.classic.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractConverterPTestCase {
		
		private var converter:AbstractConverter = new AbstractConverter();
		
		public function testAlignLeft():void {
			converter.align("TENLETTERS", "5");
		}
		
		public function testAlignRight():void {
			converter.align("TENLETTERS", "-5");
		}
	}
}
