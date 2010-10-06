package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface LoggerEntryFactory {
		
		function create(loggerName:String, time:Date, level:Level, rawMessage:String, 
				parameters:Vector.<Object>, formattedMessage:String):LoggerEntry;
	}
}
