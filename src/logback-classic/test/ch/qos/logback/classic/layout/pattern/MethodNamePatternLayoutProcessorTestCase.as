package ch.qos.logback.classic.layout.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class MethodNamePatternLayoutProcessorTestCase {
		
		private var reference:MethodNamePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new MethodNamePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%method", "%M", "%20M", "%20.20M"];
			
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.", 
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject an unrelated pattern.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to return the calling method name.",
				"testApply", this.reference.apply("%method", null));
				
			Assert.assertEquals("Failed to return the aligned calling method name.",
				" testApply", this.reference.apply("%10method", null));
		}
	}
}
