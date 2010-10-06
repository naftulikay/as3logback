package ch.qos.logback.core {
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class Level implements IExternalizable {
		
		public static const ALL:Level = new Level("ALL", 0);
		
		public static const TRACE:Level = new Level("TRACE", 1);
		
		public static const DEBUG:Level = new Level("DEBUG", 2);
		
		public static const INFO:Level = new Level("INFO", 3);
		
		public static const WARN:Level = new Level("WARN", 4);
		
		public static const ERROR:Level = new Level("ERROR", 5);
		
		public static const OFF:Level = new Level("OFF", uint.MAX_VALUE);
		
		public static function getLevels():Vector.<Level> {
			return new Vector.<Level>(ALL, TRACE, DEBUG, INFO, WARN, ERROR, OFF);
		}
		
		public static function get levels():Vector.<Level> { return getLevels(); }
		
		public static function exists(value:Level):Boolean {
			for each (var level:Level in levels) {
				if (level.equals(value)) {
					return true;
				}
			}
			
			return false;
		}
		
		private var _name:String;
		
		private var _index:uint = 0;
		
		public function Level(name:String = null, index:uint = 0) {
			this._name = name;
			this._index = index;
		}
		
		public function readExternal(value:IDataInput):void {
			this._name = value.readUTF();
			this._index = value.readUnsignedInt();
		}
		
		public function writeExternal(value:IDataOutput):void {
			value.writeUTF(this._name);
			value.writeUnsignedInt(this._index);
		}
		
		public function get index():uint {
			return this._index;
		}
		
		public function getIndex():uint {
			return this._index;
		}
		
		public function get name():String {
			return this._name;
		}
		
		public function getName():String {
			return this._name;
		}
		
		public function equals(value:Level):Boolean {
			if (value == null)
				return false;
			
			return this.index == value.index;
		}
		
		public function ge(value:Level):Boolean {
			if (value == null)
				return false;
			
			return this.index >= value.index;
		}
		
		public function gt(value:Level):Boolean {
			if (value == null)
				return false;
				
			return this.index > value.index;
		}
		
		public function le(value:Level):Boolean {
			if (value == null)
				return false;
				
			return this.index <= value.index;
		}
		
		public function lt(value:Level):Boolean {
			if (value == null)
				return false;
			
			return this.index < value.index;
		}
	}
}
