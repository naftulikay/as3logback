package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface Layout {
		
		function apply(value:LoggerEntry):String;
		
		function getName():String;
		
		function setName(value:String):Layout;
		
		function get name():String;
		function set name(value:String):void;
	}
}
