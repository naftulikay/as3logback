package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface LoggerEntry {
		
		function get loggerName():String;
		
		function get time():Date;
		
		function get level():Level;
		
		function get rawMessage():String;
		
		function get parameters():Vector.<Object>;
		
		function get formattedMessage():String;
	}
}
