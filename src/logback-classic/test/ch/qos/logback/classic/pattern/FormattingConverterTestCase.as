package ch.qos.logback.classic.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FormattingConverterTestCase {
		
		private var reference:FormattingConverter;
		
		[Before]
		public function setup():void {
			this.reference = new FormattingConverter();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%(%a %b %c)", "%20(%a abcdefg)", "%20.20(%d hello)"];
			
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject unrelated value.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to ignore alignment when no parameters given.",
				"Hello World!", this.reference.apply("%(Hello World!)", null));
				
			Assert.assertEquals("Failed to align value.",
				"   Hello World!", this.reference.apply("%15(Hello World!)", null));
		}
	}
}
