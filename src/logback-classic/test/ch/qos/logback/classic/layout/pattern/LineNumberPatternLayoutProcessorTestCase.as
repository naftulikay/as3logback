package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.AbstractAppender;
	import ch.qos.logback.core.AbstractLogger;
	import ch.qos.logback.core.Logger;
	import ch.qos.logback.core.layout.AbstractLayout;

	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LineNumberPatternLayoutProcessorTestCase {
		
		private var reference:LineNumberPatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new LineNumberPatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%line", "%L", "%20line", "%20.20line"];
			
			for each (var test:String in tests) 
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));
					
			Assert.assertFalse("Failed to reject an unrelated pattern.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
//			be very careful with these guys, they're volatile. 
//			if their line numbers change, they fail.
			Assert.assertEquals("Failed to return the calling line number.",
				"37", this.reference.apply("%line", null));
				
			Assert.assertEquals("Failed to return the calling line number aligned.",
				"   40", this.reference.apply("%5line", null));
		}
		
		[Test]
		public function testGetDefinition():void {
			Assert.assertEquals("Failed to return an appropriate class definition.",
				Logger, this.reference.getDefinition("ch.qos.logback.core.Logger"));
				
			Assert.assertNull("Failed to return null when unable to find an appropriate class definition.",
				this.reference.getDefinition("There Is No Way This Class Exists"));
		}
		
		[Test]
		public function testIsLogbackObject():void {
			Assert.assertTrue("Failed to return 'true' for AbstractLogger.",
				this.reference.isLogbackObject(AbstractLogger));
				
			Assert.assertTrue("Failed to return 'true' for AbstractAppender.",
				this.reference.isLogbackObject(AbstractAppender));
				
			Assert.assertTrue("Failed to return 'true' for AbstractLayout.",
				this.reference.isLogbackObject(AbstractLayout));
				
			Assert.assertTrue("Failed to return 'true' for AbstractPatternLayoutProcessor.",
				this.reference.isLogbackObject(AbstractPatternLayoutProcessor));
				
			Assert.assertFalse("Failed to return 'false' for a non-logback-object.",
				this.reference.isLogbackObject(LineNumberPatternLayoutProcessorTestCase));
		}
	}
}
