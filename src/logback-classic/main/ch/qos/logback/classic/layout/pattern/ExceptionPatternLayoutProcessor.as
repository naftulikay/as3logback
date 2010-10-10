package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ExceptionPatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:exception|ex|throwable|error|err|er|e)(?:\\{(.*)\\})?");
		
		private var newlineExpression:RegExp = new RegExp("\\n");
		
		private var positiveIntegerExpression:RegExp = new RegExp("^[0-9]+$");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
			
//			get the parameters to the pattern
			var matchGroup:Object = this.expression.exec(pattern);
			var alignment:String = matchGroup[1];
			var length:String = matchGroup[2];
			
			var intLength:int = int.MAX_VALUE;
			
//			determine true length of the exception output
			if (length != null && length.toLowerCase() == "short")
				intLength = 1;
			else if (length != null && positiveIntegerExpression.test(length)) 
				intLength = int(length);
			
			var result:String = null;
			
			for each (var argument:Object in entry.parameters) {
				if (argument is Error) {
					if (intLength == int.MAX_VALUE) {
//						if there's no limit to the result, just dump it.
						if (result == null)
							result = Error(argument).getStackTrace();
						else 
							result += "\n" + Error(argument).getStackTrace();
					} else {
//						if there IS a limit, then we break into an array, and join what's required.
						var lines:String = Error(argument).getStackTrace().split(this.newlineExpression)
							.slice(0, intLength + 1).join("\n");
						
						if (result == null)
							result = lines;
						else 
							result += "\n" + lines;
					}
				}
			}
			
//			if there were no exceptions in the parameters, simply return an empty string.
			if (result == null)
				return "";
			
			return this.align(result, alignment);
		}
	}
}
