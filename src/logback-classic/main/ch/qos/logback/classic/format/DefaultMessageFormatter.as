package ch.qos.logback.classic.format {
	import ch.qos.logback.core.MessageFormatter;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultMessageFormatter implements MessageFormatter {
		
		private var simpleParameterFormatter:MessageFormatter = new SimpleParameterFormatter();
		
		private var numericParameterFormatter:MessageFormatter = new NumericParameterFormatter();
		
		public function format(message:String, arguments:Array) : String {
			var result:String = message;
			
//			format simple parameters. ('{}' sequences)
			result = this.simpleParameterFormatter.format(result, arguments);
			
//			format numbered parameters. ('{0}', '{24}', etc.)
			result = this.numericParameterFormatter.format(result, arguments);
			
			return result;
		}
	}
}
