package ch.qos.logback.classic.layout.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class RelativePatternLayoutProcessorTestCase {
		
		private var reference:RelativePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new RelativePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%r", "%relative", "%20relative", "%20.20relative"];
			
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to accept '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject an unrelated value.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
			var test:RegExp = /[0-9]+/;
			
			Assert.assertTrue("Failed to return the relative time since player start.",
				test.test(this.reference.apply("%relative", null)));
				
			Assert.assertTrue("Failed to align the relative time since player start.",
				test.test(this.reference.apply("%10relative", null)));
		}
	}
}
