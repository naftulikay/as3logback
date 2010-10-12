package ch.qos.logback.classic.format {
	import ch.qos.logback.core.MessageFormatter;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NumericParameterFormatter implements MessageFormatter {
		
		private var numericParameterMatcher:RegExp = new RegExp("(\\{[0-9]+\\})");
		
		private var numericParameterExpression:RegExp = new RegExp("\\{([0-9]+)\\}");
		
		public function format(message:String, arguments:Array) : String {						
			var result:Array = message.split(numericParameterMatcher);
			
			for (var i:uint = 0; i < result.length; i++) {
				var current:String = result[i];
				
				if (numericParameterExpression.test(current)) {
					var arg:int = int(numericParameterExpression.exec(current)[1]);
					if (arguments[arg] != undefined)
						result[i] = arguments[arg];
				}
			}
			
			return result.join("");
		}
	}
}
