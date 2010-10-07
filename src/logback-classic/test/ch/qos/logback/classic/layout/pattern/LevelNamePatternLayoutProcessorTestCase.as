package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	import ch.qos.logback.core.Level;

	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LevelNamePatternLayoutProcessorTestCase {
		
		private var reference:LevelNamePatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new LevelNamePatternLayoutProcessor();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%level", "%le", "%p", "%20level", "%20.-20level{upper}"];
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to accept '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject '%farfignugen'.",
				this.reference.test("%farfignugen"));
		}
		
		[Test]
		public function testApply():void {
			var level:Level = Level.DEBUG;
			
			Assert.assertEquals("Failed to capitalize the level name by default.",
				"DEBUG", this.reference.apply("%level",
					new DefaultLoggerEntry(null, null, level)));
					
			Assert.assertEquals("Failed to capitalize the level name for 'upper' parameter.",
				"DEBUG", this.reference.apply("%level{upper}",
					new DefaultLoggerEntry(null, null, level)));
					
			Assert.assertEquals("Failed to uncapitalize the level name for 'lower' parameter.",
				"debug", this.reference.apply("%level{lower}",
					new DefaultLoggerEntry(null, null, level)));
					
			Assert.assertEquals("Failed to capitalize only the first letter of the level name for the 'first' parameter.",
				"Debug", this.reference.apply("%level{first}",
					new DefaultLoggerEntry(null, null, level)));
					
			Assert.assertEquals("Failed to left-pad align the level name.",
				"     DEBUG", this.reference.apply("%10level", 
					new DefaultLoggerEntry(null, null, level)));
					
			Assert.assertEquals("Failed to right-pad align the level name.",
				"DEBUG     ", this.reference.apply("%-10level",
					new DefaultLoggerEntry(null, null, level)));
		}
	}
}
