package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface LoggerContextConfigurator {
		
		function configure(value:LoggerContext, objectMap:Object, propertyMap:Object,
				loggers:Vector.<ch.qos.logback.core.Logger>):LoggerContextConfigurator;
	}
}
