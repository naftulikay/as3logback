package ch.qos.logback.classic.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractConverterTestCase {
		
		private var reference:AbstractConverter;
		
		[Before]
		public function setup():void {
			this.reference = new AbstractConverter();
		}
		
		[Test]
		public function testAlign():void {
			Assert.assertEquals("Failed to left-pad properly.",
				"     value", this.reference.align("value", "10"));
				
			Assert.assertEquals("Failed to right-pad properly.",
				"value     ", this.reference.align("value", "-10"));
		}
		
		[Test]
		public function testPad():void {
			Assert.assertEquals("Failed to left-pad properly.",
				"     value", this.reference.pad("value", 10));
			
			Assert.assertEquals("Failed to right-pad properly.",
				"value     ", this.reference.pad("value", -10));
				
			Assert.assertEquals("Failed to skip padding when string size is equal.",
				"telephones", this.reference.pad("telephones", 10));
				
			Assert.assertEquals("Failed to skip padding when string size is equal with a negative padding.",
				"telephones", this.reference.pad("telephones", -10));
		}
	}
}
