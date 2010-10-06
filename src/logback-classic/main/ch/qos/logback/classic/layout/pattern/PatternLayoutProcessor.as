package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface PatternLayoutProcessor {
		
		function test(pattern:String):Boolean;
		
		function apply(pattern:String, entry:LoggerEntry):String;
	}
}
