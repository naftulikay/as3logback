package ch.qos.logback.core {
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractAppender extends EventDispatcher implements Appender {
		
		private var _name:String;
		
		public function AbstractAppender(name:String = null) {
			this.name = name;
		}
		
		public function append(value:LoggerEntry) : Appender {
			throw new IllegalOperationError("Subclasses should override this method!");
		}
		
		public function getName() : String {
			return _name;
		}

		public function setName(value:String) : Appender {
			this.name = value;
			return this;
		}
		
		[Bindable]
		public function get name() : String {
			return _name;
		}

		public function set name(value:String) : void {
			this._name = value;
		}
	}
}
