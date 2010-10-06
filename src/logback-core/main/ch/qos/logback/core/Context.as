package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface Context {
		
		function getObject(name:String):*;
		
		function putObject(name:String, value:Object):Context;
		
		function getProperty(key:String):String;
		
		function setProperty(key:String, value:Object):Context;
		
		function getCreationTime():Date;
		
		function configure(value:ContextConfigurator):Context;
	}
}
