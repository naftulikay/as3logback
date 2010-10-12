package ch.qos.logback.classic.layout.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class PatternLayoutTestCase {
		
		private var reference:PatternLayout;
		
		[Before]
		public function setup():void {
			this.reference = new PatternLayout();
		}
		
		[Test]
		[Ignore]
		public function testSomething():void {
			
		}
	}
}
