package ch.qos.logback.classic {
	import ch.qos.logback.core.AbstractLoggerContext;

	import org.slf4fp.ILoggerFactory;
	import org.slf4fp.Logger;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultLoggerContext extends AbstractLoggerContext implements ILoggerFactory {
		
		public function DefaultLoggerContext() {
			super();
		}
		
		public function hasLogger(name:String):Boolean {
			return false;
		}

		public function getLogger(name:String) : Logger {
			return null;
		}

		public function getLoggers() : Vector.<Logger> {
			return null;
		}

		public function setLoggers(value:Vector.<Logger>) : void {
			
		}
	}
}
