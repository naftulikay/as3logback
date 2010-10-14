package ch.qos.logback.classic.pattern {
	
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LevelNameConverter extends AbstractConverter {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:level|le|p)(?:\\{(.*)\\})?");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			if (!test(pattern))
				return null;
				
			var matchGroups:Object = expression.exec(pattern);
			var alignment:String = matchGroups[1];
			var capitalization:String = matchGroups[2];
			
			var result:String = entry.level.name;
			
//			capitalize it if necessary
			if (capitalization == null || capitalization == "" || capitalization.toUpperCase() == "UPPER")
				result = result.toUpperCase();
			else if (capitalization.toUpperCase() == "LOWER")
				result = result.toLowerCase();
			else if (capitalization.toUpperCase() == "FIRST")
				result = result.charAt(0).toUpperCase() + result.substr(1).toLowerCase();
			
//			align it
			result = this.align(result, alignment);
			
			return result;
		}
	}
}
