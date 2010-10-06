package ch.qos.logback.core {
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractContext extends EventDispatcher implements Context {
		
		private var objects:Object = {};
		
		private var properties:Object = {};
		
		private var createdTime:Date;
		
		public function AbstractContext() {
			this.createdTime = new Date();
		}
		
		public function configure(value:ContextConfigurator):Context {
			throw new IllegalOperationError("Subclasses must override this method!");
		}
		
		public function getObject(name:String) : * {
			return objects[name];
		}

		public function putObject(name:String, value:Object) : Context {
			objects[name] = value;
			return this;
		}

		public function getProperty(key:String) : String {
			return properties[key];
		}

		public function setProperty(key:String, value:Object) : Context {
			properties[key] = value;
			return this;
		}

		public function getCreationTime() : Date {
			return createdTime;
		}
	}
}
