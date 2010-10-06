package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.utilities.SimpleDateFormat;
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DatePatternLayoutProcessor extends AbstractPatternLayoutProcessor {
		
		private var expression:RegExp = new RegExp("%((?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:date|d)(?:\\{(.*)\\})?");
		
		override public function test(pattern:String):Boolean {
			return expression.test(pattern);
		}
		
		override public function apply(pattern:String, entry:LoggerEntry) : String {
			var result:String = pattern;
			
			var matchGroups:Object = this.expression.exec(pattern);
			var paddingParameters:String = matchGroups[1];
			var datePattern:String = matchGroups[2];
			
//			first, evaluate the date
			if (datePattern == null || datePattern == "" || datePattern == "ISO8601") 
				result = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss,SSS").format(entry.time);
			else 
				result = new SimpleDateFormat(datePattern).format(entry.time);
				
//			then, align it
			result = this.align(result, paddingParameters);
			
			return result;
		}
	}
}
