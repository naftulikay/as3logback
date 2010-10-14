package ch.qos.logback.classic.pattern {
	
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FormattingConverter extends AbstractConverter {
		
		private var expression:RegExp = /%((?:\-?[0-9]+)?\.?(?:\-?[0-9]+)?)?\((.+?)(?<!\\)\)/;
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			var groups:Object = this.expression.exec(pattern);
			var alignment:String = groups[1];
			var value:String = groups[2];
			
			if (entry == null)
				entry = null; // fight FDT warnings!
			
			return align(value, alignment);
		}
	}
}
