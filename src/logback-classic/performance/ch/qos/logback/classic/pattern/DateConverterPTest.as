package ch.qos.logback.classic.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DateConverterPTest {
		
		private var entry:DefaultLoggerEntry = new DefaultLoggerEntry(null, new Date());
		
		public function testApply():void {
			var converter:DateConverter = new DateConverter();
			converter.apply("%d{yyyy-MM-dd HH:mm:ss,SSS}", entry);
		}
		
		public function testApplyWithAlign():void {
			var converter:DateConverter = new DateConverter();
			converter.apply("%100d{yyyy-MM-dd HH:mm:ss,SSS}", entry);
		}
	}
}
