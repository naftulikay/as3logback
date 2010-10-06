package ch.qos.logback.classic.format {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SimpleParameterFormatterTestCase {
		
		private var reference:SimpleParameterFormatter;
		
		[Before]
		public function setup():void {
			this.reference = new SimpleParameterFormatter();
		}
		
		[Test]
		public function testFormat():void {
			Assert.assertEquals("Failed to replace simple parameters in range.",
				"1 isn't 2 isn't 3", this.reference.format("{} isn't {} isn't {}", 
				[1,2,3]));
				
			Assert.assertEquals("Failed to replace simple parameters in range and " +
				"leave those out of range alone.", "1 isn't 2 isn't 3 isn't {}",
				this.reference.format("{} isn't {} isn't {} isn't {}", [1,2,3]));
		}
	}
}
