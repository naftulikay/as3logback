package ch.qos.logback.classic.format {
	import ch.qos.logback.core.MessageFormatter;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class NumericParameterFormatter implements MessageFormatter {
		
		private var numericParameterExpression:RegExp = new RegExp("\\{([0-9]+)\\}", "g");
		
		public function format(message:String, arguments:Array) : String {			
			var result:String = message.concat();
			
			if (arguments != null && arguments.length > 0) {
				if (numericParameterExpression.test(result)) {
//					replace numerically
					var matchGroup:Object = numericParameterExpression.exec(result);
					
					while (matchGroup != null) {
						var index:int = int(matchGroup[1]);
						
						if (arguments[index] != undefined) {
							while (result.indexOf(matchGroup[0]) != -1)
								result = result.replace("{" + index + "}", arguments[index]);
						}
						
						matchGroup = numericParameterExpression.exec(result);
					}
				}
			}
			
			return result;
		}
	}
}
