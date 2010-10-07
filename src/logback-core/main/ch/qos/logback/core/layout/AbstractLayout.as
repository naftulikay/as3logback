package ch.qos.logback.core.layout {
	import ch.qos.logback.core.Layout;
	import ch.qos.logback.core.LoggerEntry;

	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractLayout extends EventDispatcher implements Layout {
		
		private var _name:String;
		
		public function AbstractLayout(name:String = null) {
			this.name = name;
		}
		
		public function apply(value:LoggerEntry) : String {
			throw new IllegalOperationError("Subclasses must override this method!");
		}

		public function getName() : String {
			return _name;
		}

		public function setName(value:String) : Layout {
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
