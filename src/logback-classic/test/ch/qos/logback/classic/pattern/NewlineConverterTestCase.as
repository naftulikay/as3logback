package ch.qos.logback.classic.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NewlineConverterTestCase {
		
		private var reference:NewlineConverter;
		
		[Before]
		public function setup():void {
			this.reference = new NewlineConverter();
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
