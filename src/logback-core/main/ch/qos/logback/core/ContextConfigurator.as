package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface ContextConfigurator {
		
		function configure(value:Context, objectMap:Object, propertyMap:Object,
				loggers:Vector.<ch.qos.logback.core.Logger>):ContextConfigurator;
	}
}
