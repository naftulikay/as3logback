package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;

	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LoggerNamePatternLayoutProcessorTestCase {
		
		private var reference:LoggerNamePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new LoggerNamePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to trim string to 10.",
				"c.t.f.Fabulous", this.reference.apply("%logger{10}", 
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
					
			Assert.assertEquals("Failed to trim string to 25.",
				"c.t.fabulous.Fabulous", this.reference.apply("%logger{25}",
					new DefaultLoggerEntry("com.tkassembled.fabulous.Fabulous")));
		}
		
		[Test]
		public function testShrink():void {
			Assert.fail("Not yet implemented.");
		}
	}
}
