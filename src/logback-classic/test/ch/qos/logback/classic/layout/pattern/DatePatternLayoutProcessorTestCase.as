package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;

	import org.flexunit.Assert;
	
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DatePatternLayoutProcessorTestCase {
		
		private var reference:DatePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new DatePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%d", "%date", "%20d", "%20.20d", "%20.20date{MM dd yyyy}"];
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to accept '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject '%farfignugen'.",
				this.reference.test("%farfignugen"));
		}
		
		[Test]
		public function testApply():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to format to ISO8601.",
				"1970-01-01 00:00:00,000", this.reference.apply("%date", 
					new DefaultLoggerEntry(null, date)));
			
			Assert.assertEquals("Failed to format to specified format.",
				"01-01-1970 00:00 AM", this.reference.apply("%date{MM-dd-yyyy HH:mm a}",
					new DefaultLoggerEntry(null, date)));
					
			Assert.assertEquals("Failed to format and align.",
				"   01-01-1970", this.reference.apply("%13date{MM-dd-yyyy}",
					new DefaultLoggerEntry(null, date)));
		}
	}
}
