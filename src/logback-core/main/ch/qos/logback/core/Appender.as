package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface Appender {
		
		function append(value:LoggerEntry):Appender;
		
		function getName():String;
		
		function setName(value:String):Appender;
		
		function getThreshold():Level;
		
		function setThreshold(value:Level):Appender;
		
		function get name():String;
		function set name(value:String):void;
		
		function get threshold():Level;
		function set threshold(value:Level):void;
	}
}
