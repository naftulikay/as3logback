package ch.qos.logback.classic.entry {
	import ch.qos.logback.core.Level;
	import ch.qos.logback.core.LoggerEntry;
	import ch.qos.logback.core.LoggerEntryFactory;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultLoggerEntryFactory implements LoggerEntryFactory {
		
		public function create(loggerName:String, time:Date, level:Level, rawMessage:String, 
				parameters:Vector.<Object>, formattedMessage:String) : LoggerEntry {
			return new DefaultLoggerEntry(loggerName, time, level, rawMessage, parameters,
					formattedMessage);
		}
	}
}
