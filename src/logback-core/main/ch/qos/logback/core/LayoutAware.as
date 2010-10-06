package ch.qos.logback.core {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public interface LayoutAware {
		
		function getLayout():Layout;
		
		function setLayout(value:Layout):LayoutAware;
		
		function get layout():Layout;
		function set layout(value:Layout):void;
	}
}
