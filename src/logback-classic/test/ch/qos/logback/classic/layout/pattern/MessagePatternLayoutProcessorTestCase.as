package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class MessagePatternLayoutProcessorTestCase {
		
		private var reference:MessagePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new MessagePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%message", "%msg", "%m", "%20m", "%20.20m"];
			
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject an unrelated pattern.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to return formatted message.",
				"Hello World!", this.reference.apply("%m", 
					new DefaultLoggerEntry(null, null, null, null, null, 
						"Hello World!")));
			
			Assert.assertEquals("Failed to return formatted message aligned.",
				"   Hello World!", this.reference.apply("%15m", 
					new DefaultLoggerEntry(null, null, null, null, null,
						"Hello World!")));
		}
	}
}
