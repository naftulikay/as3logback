package ch.qos.logback.classic.entry {
	import ch.qos.logback.core.Level;
	import ch.qos.logback.core.LoggerEntry;

	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class DefaultLoggerEntry extends EventDispatcher implements LoggerEntry, IExternalizable {
		
		private var _loggerName:String;
		
		private var _time:Date;
		
		private var _level:Level;
		
		private var _rawMessage:String;
		
		private var _parameters:Vector.<Object>;
		
		private var _formattedMessage:String;
		
		public function DefaultLoggerEntry(loggerName:String = null, time:Date = null,
				level:Level = null, rawMessage:String = null, parameters:Vector.<Object> = null,
				formattedMessage:String = null) {
			this.loggerName = loggerName;
			this.time = time;
			this.level = level;
			this.rawMessage = rawMessage;
			this.parameters = parameters;
			this.formattedMessage = formattedMessage;		
		}
		
		public function readExternal(value:IDataInput):void {
			this.loggerName = value.readUTF();
			this.time = Date(value.readObject());
			this.level = Level(value.readObject());
			this.rawMessage = value.readUTF();
			this.parameters = Vector.<Object>(value.readObject());
			this.formattedMessage = value.readUTF();
		}
		
		public function writeExternal(value:IDataOutput):void {
			value.writeUTF(loggerName);
			value.writeObject(time);
			value.writeObject(level);
			value.writeUTF(rawMessage);
			value.writeObject(parameters);
			value.writeUTF(formattedMessage);
		}
		
		[Bindable]
		public function get loggerName() : String { return _loggerName; }
		public function set loggerName(value:String):void { _loggerName = value; }
			
		[Bindable]
		public function get time() : Date { return _time; }
		public function set time(value:Date):void { _time = value; }
		
		[Bindable]
		public function get level() : Level { return _level; }
		public function set level(value:Level):void { _level = value; }
		
		[Bindable]
		public function get rawMessage() : String { return _rawMessage; }
		public function set rawMessage(value:String):void { _rawMessage = value; }
		
		[Bindable]
		public function get parameters() : Vector.<Object> { return _parameters; }
		public function set parameters(value:Vector.<Object>):void { _parameters = value; }
		
		[Bindable]
		public function get formattedMessage() : String { return _formattedMessage; }
		public function set formattedMessage(value:String):void { _formattedMessage = value; }
	}
}
