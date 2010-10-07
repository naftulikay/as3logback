package ch.qos.logback.core {
	import org.slf4fp.Logger;

	import flash.events.IEventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface Logger extends org.slf4fp.Logger, IEventDispatcher {
		
//		logger entry factory
		function get loggerEntryFactory():LoggerEntryFactory;
		
		function getLoggerEntryFactory():LoggerEntryFactory;
		
		function setLoggerEntryFactory(value:LoggerEntryFactory):ch.qos.logback.core.Logger;
		
//		message formatter
		function get messageFormatter():MessageFormatter;
		
		function getMessageFormatter():MessageFormatter;
		
		function setMessageFormatter(value:MessageFormatter):ch.qos.logback.core.Logger;
		
//		appenders
		function get appenders():AppenderList;
		
		function getAppenders():AppenderList;
		
//		children
		function get children():LoggerList;
		
		function getChildren():LoggerList;
		
//		additive
		function get additive():Boolean;
		
		function isAdditive():Boolean;
		
		function setAdditive(value:Boolean):ch.qos.logback.core.Logger;
		
//		level
		function get level():Level;
		
		function getLevel():Level;
		
		function setLevel(value:Level):ch.qos.logback.core.Logger;
	}
}
