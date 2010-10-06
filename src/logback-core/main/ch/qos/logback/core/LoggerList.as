package ch.qos.logback.core {
	import flash.events.EventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class LoggerList extends EventDispatcher {
		
		private var _list:Vector.<Logger>;
		
		public function LoggerList(...args) {
			this._list = new Vector.<Logger>();
			for each (var item:* in args) {
				this._list.push(item);
			}
		}
		
		public function get(index:int):Logger {
			return _list[index];
		}
		
		public function set(index:int, value:Logger):LoggerList {
			_list[index] = value;
			return this;
		}
		
		public function add(value:Logger):LoggerList {
			_list.push(value);
			return this;
		}
		
		public function remove(value:Logger):Logger {
			for each (var logger:Logger in _list) {
				if (value == logger) {
					_list.splice(_list.indexOf(value), 1);
					return logger;
				}
			}
			
			return null;
		}
		
		public function removeByName(name:String):Logger {
			for each (var logger:Logger in _list) {
				if (logger.name == name) {
					_list.splice(_list.indexOf(logger), 1);
					return logger;
				}
			}
			
			return null;
		}
		
		public function get length():int { return _list.length; }
		
		public function size():int { return length; }
		
		public function toArray():Array {
			var result:Array = [];
			for each (var logger:Logger in _list) {
				result.push(logger);
			}
			
			return result;
		}
		
		public function toVector():Vector.<Logger> {
			return _list.concat();
		}
	}
}
