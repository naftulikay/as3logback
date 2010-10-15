package ch.qos.logback.classic.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	import ch.qos.logback.core.Level;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LevelNameConverterPTestCase {
		
		private var entry:DefaultLoggerEntry = new DefaultLoggerEntry(null, null, 
				Level.DEBUG);
				
		private var converter:LevelNameConverter = new LevelNameConverter();
		
		public function testApply():void {
			converter.apply("%level", entry);
		}
		
		public function testApplyWithAlign():void {
			converter.apply("%100level", entry);
		}
		
		public function testApplyUppercase():void {
			converter.apply("%level{upper}", entry);
		}
		
		public function testApplyUppercaseWithAlign():void {
			converter.apply("%100level{upper}", entry);
		}
		
		public function testApplyLowercase():void {
			converter.apply("%level{lower}", entry);
		}
		
		public function testApplyLowercaseWithAlign():void {
			converter.apply("%100level{lower}", entry);
		}
		
		public function testApplyFirst():void {
			converter.apply("%level{first}", entry);
		}
		
		public function testApplyFirstWithAlign():void {
			converter.apply("%100level{first}", entry);
		}
	}
}
