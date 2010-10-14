package ch.qos.logback.classic.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ClassNameConverterTestCase {
		
		private var reference:ClassNameConverter;
		
		[Before]
		public function setup():void {
			this.reference = new ClassNameConverter();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%C", "%class", "%20class", "%20.20class", "%20.20class{20}"];
			
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));
			}
		}
		
		[Test]
		public function testApply():void {
			Assert.assertEquals("Failed to return the calling class.",
				"ch.qos.logback.classic.pattern.ClassNameConverterTestCase",
				this.reference.apply("%class", null));
				
			Assert.assertEquals("Failed to return the calling class trimmed to 0 characters.",
				"ClassNameConverterTestCase", this.reference.apply("%class{0}", null));
			
//			for: ch.qos.logback.classic.pattern.ClassNameConverterTestCase	
			Assert.assertEquals("Failed to return the calling class trimmed to 10 characters.",
				"c.q.l.c.p.ClassNameConverterTestCase", 
				this.reference.apply("%class{10}", null));
			
			Assert.assertEquals("Failed to return the calling class trimmed to 10 characters and aligned.",
				"     c.q.l.c.p.ClassNameConverterTestCase",
				this.reference.apply("%41class{10}", null));
		}
	}
}
