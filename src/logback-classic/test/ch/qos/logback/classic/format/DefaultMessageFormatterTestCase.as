package ch.qos.logback.classic.format {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultMessageFormatterTestCase {
		
		private var reference:DefaultMessageFormatter;
		
		[Before]
		public function setup():void {
			this.reference = new DefaultMessageFormatter();
		}
		
		[Test]
		[Ignore("Not yet implemented.")]
		public function testFormat():void {
			
		}
	}
}
