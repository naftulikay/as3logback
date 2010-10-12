package ch.qos.logback.classic {
	import ch.qos.logback.classic.entry.DefaultLoggerEntryFactory;
	import ch.qos.logback.classic.format.DefaultMessageFormatter;
	import ch.qos.logback.core.AbstractLogger;
	import ch.qos.logback.core.Level;
	import ch.qos.logback.core.Logger;
 	import ch.qos.logback.core.LoggerEntryFactory;
	import ch.qos.logback.core.MessageFormatter;

	import org.slf4fp.Logger;
	
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultLogger extends AbstractLogger {
		
		public function DefaultLogger(name:String = null, messageFormatter:MessageFormatter = null,
				parent:ch.qos.logback.core.Logger = null, level:Level = null, additive:Boolean = false,
				loggerEntryFactory:LoggerEntryFactory = null) {
			super(name, messageFormatter, parent, level, additive, loggerEntryFactory);
			
			if (this.messageFormatter == null) 
				this.messageFormatter = new DefaultMessageFormatter();
				
			if (this.loggerEntryFactory == null) 
				this.loggerEntryFactory = new DefaultLoggerEntryFactory();
		}
		
		override public function trace(message:String, args:*):org.slf4fp.Logger {
			if (isTraceEnabled) 
				append(Level.TRACE, message, args);
			
			return this;
		}

		override public function debug(message:String, args:*):org.slf4fp.Logger {
			if (isDebugEnabled)
				append(Level.DEBUG, message, args);
			
			return this;
		}

		override public function info(message:String, args:*):org.slf4fp.Logger {
			if (isInfoEnabled)
				append(Level.INFO, message, args);
			
			return this;
		}

		override public function warn(message:String, args:*):org.slf4fp.Logger {
			if (isWarnEnabled)
				append(Level.WARN, message, args);
			
			return this;
		}

		override public function error(message:String, args:*):org.slf4fp.Logger {
			if (isErrorEnabled)
				append(Level.ERROR, message, args);
			
			return this;
		}
		
		public function append(level:Level, message:String, arguments:Array):ch.qos.logback.core.Logger {
			var now:Date = new Date();
			
			for (var i:uint = 0; i < this.appenders.size(); i++) {
//				append to each registered appender.
				this.appenders.get(i).append(this.loggerEntryFactory
					.create(this.name, now, level, message, arguments, 
						this.messageFormatter.format(message, arguments)));	
			}
			
			return this;
		}
	}
}
