package ch.qos.logback.core {
	import flash.events.EventDispatcher;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AppenderList extends EventDispatcher {
		
		private var _list:Vector.<Appender>;
		
		public function AppenderList(...items) {
			this._list = new Vector.<Appender>();
			for each (var item:* in items) {
				this._list.push(item);
			}
		}
		
		public function add(value:Appender):AppenderList {
			this._list.push(value);
			return this;
		}
		
		public function remove(value:Appender):Appender {
			if (this._list.indexOf(value) != -1) {
				this._list.splice(this._list.indexOf(value), 1);
				return value;
			} else {
				return null;
			}
		}
		
		public function removeByName(name:String):Appender {
			for each (var appender:Appender in _list) {
				if (appender.name == name) {
					this._list.splice(this._list.indexOf(appender), 1);
					return appender;
				}
			}
		}
		
		public function clear():AppenderList {
			this._list = new Vector.<Appender>();
			return this;
		}
		
		public function get(index:Number):Appender {
			return this._list[index];
		}
		
		public function get length():Number { return this._list.length; }
		
		public function size():Number { return length; }
		
		public function toArray():Array { 
			var result:Array = [];
			for each (var appender:Appender in _list) {
				result.push(appender);
			}
			
			return result;
		}
		
		public function toVector():Vector.<Appender> {
			return _list.concat();
		}
	}
}
