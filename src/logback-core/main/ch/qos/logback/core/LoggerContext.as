package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface LoggerContext {
		
		function getObject(name:String):*;
		
		function putObject(name:String, value:Object):LoggerContext;
		
		function hasObject(name:String):Boolean;
		
		function getProperty(key:String):String;
		
		function setProperty(key:String, value:Object):LoggerContext;
		
		function hasProperty(key:String):Boolean;
		
		function getCreationTime():Date;
		
		function configure(value:LoggerContextConfigurator):LoggerContext;
	}
}
