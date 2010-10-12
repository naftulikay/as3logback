package ch.qos.logback.classic.layout.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ClassNamePatternLayoutProcessorTestCase {
		
		private var reference:ClassNamePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new ClassNamePatternLayoutProcessor();
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
				"ch.qos.logback.classic.layout.pattern.ClassNamePatternLayoutProcessorTestCase",
				this.reference.apply("%class", null));
				
			Assert.assertEquals("Failed to return the calling class trimmed to 0 characters.",
				"ClassNamePatternLayoutProcessorTestCase", this.reference.apply("%class{0}", null));
				
			Assert.assertEquals("Failed to return the calling class trimmed to 10 characters.",
				"c.q.l.c.l.p.ClassNamePatternLayoutProcessorTestCase", 
				this.reference.apply("%class{10}", null));
				
			Assert.assertEquals("Failed to return the calling class trimmed to 10 characters and aligned.",
				"     c.q.l.c.l.p.ClassNamePatternLayoutProcessorTestCase",
				this.reference.apply("%56class{10}", null));
		}
	}
}
