package ch.qos.logback.classic {
	import ch.qos.logback.core.LoggerContext;

	import org.slf4fp.ILoggerFactory;
	import org.slf4fp.Logger;

	import flash.events.EventDispatcher;

	/**
	 * @author rfkrocktk
	 */
	public class LogbackClassicLoggerFactory extends EventDispatcher implements ILoggerFactory {
		
		private var _context:LoggerContext;
		
		public function LogbackClassicLoggerFactory() {
			this.context = new DefaultLoggerContext();
		}

		public function getLogger(name : String) : Logger {
			
			
			return null;
		}
		
		[Bindable]
		public function get context():LoggerContext { 
			return _context;
		}
		
		public function set context(value:LoggerContext):void {
			this._context = value;
		}
	}
}
