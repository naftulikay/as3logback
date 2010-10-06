package ch.qos.logback.core {
	import org.slf4fp.Logger;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface ContextConfigurator {
		
		function configure(value:Context, objectMap:Object, propertyMap:Object,
				loggers:Vector.<Logger>):ContextConfigurator;
	}
}
