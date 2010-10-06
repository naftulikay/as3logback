package ch.qos.logback.classic.format {
	import ch.qos.logback.core.MessageFormatter;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SimpleParameterFormatter implements MessageFormatter {
		
		public function format(message:String, arguments:Array) : String {
			var result:String = message;
			
			if (arguments != null && arguments.length > 0) {
//				replace simple '{}' parameters, untyped, in order.
				var current:uint = 0;
				while (result.indexOf("{}") != -1 && current < arguments.length) {
					result = result.replace("{}", arguments[current]);
					current++;
				}
			}
			
			return result;
		}
	}
}
