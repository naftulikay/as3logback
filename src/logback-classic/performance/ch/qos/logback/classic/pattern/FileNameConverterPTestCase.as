package ch.qos.logback.classic.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FileNameConverterPTestCase {

		private var converter:FileNameConverter = new FileNameConverter();
		
		public function testApply():void {
			converter.apply("%file", null);
		}
		
		public function testApplyWithAlign():void {
			converter.apply("%100file", null);
		}
	}
}
