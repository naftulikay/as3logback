package ch.qos.logback.classic.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FormattingConverterPTestCase {
		
		private var converter:FormattingConverter = new FormattingConverter();
		
		public function testApply():void {
			converter.apply("%100(A brand new world is amazing!)", null);
		}
	}
}
