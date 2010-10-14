package ch.qos.logback.classic.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ExceptionConverterPTestCase {
		
		private var entry:DefaultLoggerEntry;
		
		private var converter:ExceptionConverter = new ExceptionConverter();
		
		public function ExceptionConverterPTestCase() {
			this.entry = new DefaultLoggerEntry();
			var params:Vector.<Object> = new Vector.<Object>();
			params.push(new Error("A new error!"));
			this.entry.parameters = params;
		}
		
		public function testApply():void {
			converter.apply("%error", entry);
		}
		
		public function testApplyShort():void {
			converter.apply("%error{short}", entry);
		}
		
		public function testApplyWithAlign():void {
			converter.apply("%100error", entry);
		}
		
		public function testApplyShortWithAlign():void {
			converter.apply("%100error{short}", entry);
		}
	}
}
