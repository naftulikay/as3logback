package ch.qos.logback.core {
	import flash.errors.IllegalOperationError;
	import flash.events.EventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractLoggerContext extends EventDispatcher implements LoggerContext {
		
		private var objects:Object = {};
		
		private var properties:Object = {};
		
		private var createdTime:Date;
		
		public function AbstractLoggerContext() {
			this.createdTime = new Date();
		}
		
		public function configure(value:LoggerContextConfigurator):LoggerContext {
			throw new IllegalOperationError("Subclasses must override this method!");
		}
		
		public function getObject(name:String) : * {
			return objects[name];
		}

		public function putObject(name:String, value:Object) : LoggerContext {
			objects[name] = value;
			return this;
		}
		
		public function hasObject(name:String):Boolean {
			return this.objects[name] != undefined;
		}

		public function getProperty(key:String) : String {
			return properties[key];
		}

		public function setProperty(key:String, value:Object) : LoggerContext {
			properties[key] = value;
			return this;
		}
		
		public function hasProperty(key:String):Boolean {
			return this.properties[key] != undefined;
		}

		public function getCreationTime() : Date {
			return createdTime;
		}
	}
}
