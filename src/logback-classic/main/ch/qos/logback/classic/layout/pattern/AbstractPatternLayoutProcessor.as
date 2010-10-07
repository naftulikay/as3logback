package ch.qos.logback.classic.layout.pattern {
	import flash.errors.IllegalOperationError;
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractPatternLayoutProcessor implements PatternLayoutProcessor {
		
		private var parameterExpression:RegExp = new RegExp("(\\-?[0-9]+)");
		
		public function test(pattern:String) : Boolean {
			throw unimplement();
		}

		public function apply(pattern:String, entry:LoggerEntry) : String {
			throw unimplement();
		}
		
		public function align(value:String, parameters:String):String {
			if (parameters && parameterExpression.test(parameters)) {
				var groups:Object = this.parameterExpression.exec(parameters);
				var param:Number = new Number(groups[1]);
				
				var result:Array = [];
				for each (var line:String in value.split("\n")) {
					result.push(pad(line, param));
				}
				
				value = result.join("\n");
			}

			return value;
		}
		
		public function pad(value:String, amount:int):String {
			var prefix:Boolean = true;
			
			if (amount < 0)
				prefix = false;
				
			var absoluteValue:int = Math.abs(amount);
			absoluteValue -= value.length;
			
			for (var i:int = 0; i < absoluteValue; i++) {
				value = prefix ? " " + value : value + " ";
			}
			
			return value;
		}
		
		private function unimplement():Error {
			return new IllegalOperationError("Subclasses must override this!");
		}
	}
}
