package ch.qos.logback.classic.layout.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FormattingPatternLayoutProcessorTestCase {
		
		private var reference:FormattingPatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new FormattingPatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		public function testApply():void {
			Assert.fail("Not yet implemented.");
		}
	}
}
