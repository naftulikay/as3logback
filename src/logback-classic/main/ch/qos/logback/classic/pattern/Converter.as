package ch.qos.logback.classic.pattern {
	import ch.qos.logback.core.LoggerEntry;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface Converter {
		
		function test(pattern:String):Boolean;
		
		function apply(pattern:String, entry:LoggerEntry):String;
	}
}
