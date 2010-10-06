package ch.qos.logback.core.layout {
	
	import ch.qos.logback.core.LoggerEntry;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultLayout implements AbstractLayout {
		
		public function apply(value:LoggerEntry) : String {
			return value.time.toDateString() + " [" + value.level.name + "] " + value.loggerName + " - " + value.formattedMessage;
		}
	}
}
