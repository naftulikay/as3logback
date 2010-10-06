package ch.qos.logback.classic.format {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NumericParameterFormatterTestCase {
		
		private var reference:NumericParameterFormatter;
		
		[Before]
		public function setup():void {
			this.reference = new NumericParameterFormatter();
		}
		
		[Test]
		public function testFormat():void {
			Assert.assertEquals("Failed to format numbered parameters properly.",
				"1 + 1 + 1 equals 3 {2}", this.reference.format("{0} + {0} + {0} equals {1} {2}",
					[1, 3]));
		}
	}
}
