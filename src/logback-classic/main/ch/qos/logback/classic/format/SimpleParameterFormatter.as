package ch.qos.logback.classic.format {
	import ch.qos.logback.core.MessageFormatter;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SimpleParameterFormatter implements MessageFormatter {
		
		private var expression:RegExp = /(\{\})/;
		
		public function format(message:String, arguments:Array) : String {
			if (arguments != null && arguments.length > 0) {
				var result:Array = message.split(expression);
				var currentArgument:int = 0;
				for (var i:uint = 0; i < result.length; i++) {
					if (expression.test(result[i])) {
						result[i] = arguments[currentArgument];
						currentArgument++;
						if (currentArgument >= arguments.length)
							break;
					}
				}
				
				return result.join("");
			}
			
			return message;
		}
	}
}
