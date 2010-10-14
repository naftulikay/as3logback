package ch.qos.logback.classic.pattern {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ClassNameConverterPTestCase {
		
		public function testApply():void {
			var converter:ClassNameConverter = new ClassNameConverter();
			converter.apply("%class", null);
		}
		
		public function testApplyWithAlign():void {
			var converter:ClassNameConverter = new ClassNameConverter();
			converter.apply("%100class", null);
		}
		
		public function testApplyShrunk():void {
			var converter:ClassNameConverter = new ClassNameConverter();
			converter.apply("%class{1}", null);
		}
		
		public function testApplyShrunkWithAlign():void {
			var converter:ClassNameConverter = new ClassNameConverter();
			converter.apply("%100class{1}", null);
		}
	}
}
