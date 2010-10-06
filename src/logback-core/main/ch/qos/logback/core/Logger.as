package ch.qos.logback.core {
	import org.slf4fp.Logger;

	import flash.events.IEventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface Logger extends Logger, IEventDispatcher {
		
//		logger entry factory
		function get loggerEntryFactory():LoggerEntryFactory;
		
		function getLoggerEntryFactory():LoggerEntryFactory;
		
		function setLoggerEntryFactory(value:LoggerEntryFactory):Logger;
		
//		message formatter
		function get messageFormatter():MessageFormatter;
		
		function getMessageFormatter():MessageFormatter;
		
		function setMessageFormatter(value:MessageFormatter):Logger;
		
//		appenders
		function get appenders():AppenderList;
		
		function getAppenders():AppenderList;
		
//		children
		function get children():LoggerList;
		
		function getChildren():LoggerList;
		
//		additive
		function get additive():Boolean;
		
		function isAdditive():Boolean;
		
		function setAdditive(value:Boolean):Logger;
		
//		level
		function get level():Level;
		
		function getLevel():Level;
		
		function setLevel(value:Level):Logger;
	}
}
