package org.slf4fp.impl {
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class StaticLoggerBinder {
//		FIXME wire me together. 
		
		private static var SINGLETON:StaticLoggerBinder = new StaticLoggerBinder();
		
		public function getSingleton():StaticLoggerBinder {
			return SINGLETON;
		}
	}
}
