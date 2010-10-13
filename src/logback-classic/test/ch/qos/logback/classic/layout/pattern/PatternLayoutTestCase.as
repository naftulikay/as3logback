package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.utilities.SimpleDateFormat;
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	import ch.qos.logback.core.Level;

	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class PatternLayoutTestCase {
		
		private var reference:PatternLayout;
		
		[Before]
		public function setup():void {
			this.reference = new PatternLayout();
		}
		
		[Test]
		public function testApply():void {
			var now:Date = new Date();
			
//			format is "%d [%p] %c - %m %e %n"
			Assert.assertEquals("Failed to properly format according to the pattern.",
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss,SSS").format(now) + " [DEBUG] com.tkassembled.fabulous.Fabulous - Hey Guys, Hey!  \n",
				this.reference.apply(new DefaultLoggerEntry(
					"com.tkassembled.fabulous.Fabulous", 
					now, Level.DEBUG, "Hey Guys, Hey!",
					new Vector.<Object>(), "Hey Guys, Hey!")));
		}
	}
}
