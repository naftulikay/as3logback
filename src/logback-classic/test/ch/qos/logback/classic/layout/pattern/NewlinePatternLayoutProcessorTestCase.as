package ch.qos.logback.classic.layout.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NewlinePatternLayoutProcessorTestCase {
		
		private var reference:NewlinePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new NewlinePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			Assert.assertTrue("Failed to accept '%n'.",
				this.reference.test("%n"));
				
			Assert.assertFalse("Failed to reject '%farfignugen'.",
				this.reference.test("%farfignugen"));
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to return a newline.",
				"\n", this.reference.apply("%n", null));
		}
	}
}
