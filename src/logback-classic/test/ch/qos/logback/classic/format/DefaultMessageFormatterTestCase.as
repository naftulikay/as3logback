package ch.qos.logback.classic.format {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultMessageFormatterTestCase {
		
		private var reference:DefaultMessageFormatter;
		
		[Before]
		public function setup():void {
			this.reference = new DefaultMessageFormatter();
		}
		
		[Test]
		public function testFormat():void {
			Assert.assertEquals("Failed to properly format the message with simple parameters.",
				"a, b, and {}", this.reference.format("{}, {}, and {}", ["a","b"]));
			
			Assert.assertEquals("Failed to properly format the message with numeric parameters.",
				"a, b, and {2}", this.reference.format("{0}, {1}, and {2}", ["a", "b"]));
			
			Assert.assertEquals("Failed to properly format the message.",
				"1 + 1 + 3 = 5", this.reference.format("{} + {0} + {} = {2}", [1, 3, 5]));
		}
	}
}
