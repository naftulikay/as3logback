package ch.qos.logback.classic.utilities {
	import flash.events.EventDispatcher;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SimpleDateFormat extends EventDispatcher {
		
		internal static const DAYS_OF_WEEK_ABBREVIATED:Array = [
			"Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"
		];
		
		internal static const DAYS_OF_WEEK_FULL:Array = [
			"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
			"Saturday"
		];
		
		internal static const MONTH_NAMES_ABBREVIATED:Array = [
			"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct",
			"Nov", "Dec"
		];
		
		internal static const MONTH_NAMES_FULL:Array = [
			"January", "February", "March", "April", "May", "June", "July",
			"August", "September", "October", "November", "December"
		];
		
		internal static const AM:String = "AM";
		
		internal static const PM:String = "PM";
		
		internal static const DATE_FORMAT_ENTRIES:RegExp = new RegExp("(y{4}|y{2}|M{1,4}|d{1,2}|E{1,4}|a{1,2}|H{1,2}|k{1,2}|K{1,2}|h{1,2}|m{1,2}|s{1,2}|S{1,3})");
		
		private var _pattern:String;
		
		public function SimpleDateFormat(pattern:String = null) {
			this.pattern = pattern;
		}
		
		public function applyPattern(pattern:String):void {
			this.pattern = pattern;
		}
		
		public function format(date:Date):String {
			var chunks:Array = pattern.concat().split(SimpleDateFormat.DATE_FORMAT_ENTRIES);
			
			for (var i:uint = 0; i < chunks.length; i++) {
				var chunk:String = chunks[i];
				
				if (chunk == "" || !DATE_FORMAT_ENTRIES.test(chunk))
					continue;
					
				var replacement:String = "";
				
				switch (chunk.charAt(0)) {
					case "y": // years
						replacement = getYear(date, chunk.length);
						break;
						
					case "M": // months
						replacement = getMonth(date, chunk.length);
						break;
						
					case "d": // date
						replacement = getDayOfMonth(date, chunk.length); 
						break;
						
					case "E": // day
						replacement = getDayOfWeek(date, chunk.length);
						break;
						
					case "a": // am|pm
						replacement = getAMPM(date);
						break;
						
					case "H": // hour (0-23)
						replacement = getHourOfDay0(date, chunk.length);
						break;
						
					case "k": // hour (1-24)
						replacement = getHourOfDay1(date, chunk.length);
						break;
						
					case "K": // hour (0-11)
						replacement = getHourOfDay2(date, chunk.length);
						break;
						
					case "h": // hour (1-12)
						replacement = getHourOfDay3(date, chunk.length);
						break;
						
					case "m": // minute
						replacement = getMinuteOfHour(date, chunk.length);
						break;
						
					case "s": // second
						replacement = getSecondOfMinute(date, chunk.length);
						break;
						
					case "S": // millisecond
						replacement = getMillisecond(date, chunk.length);
						break;
				}
				
				chunks[i] = replacement;
			}
			
			return chunks.join("");
		}
		
		public function parse(value:String):Date {
//			TODO Add parsing for literal string values such as month names and day names.
			if (value == null || value.length == 0 || 
					!pattern || pattern.length == 0) {
				return null;	
			}
			
			var result:Date = new Date(0, 0, 0, 0, 0, 0, 0);
			var cursor:int = 0;
			var chunks:Array = pattern.concat().split(DATE_FORMAT_ENTRIES);
			
			for (var i:int = 0; i < chunks.length; i++) {
				var chunk:String = chunks[i];
				switch (chunk.charAt(0)) {
					case "y":
						if (chunk.length == 2)
							result.fullYear = new Number("19" + value.substr(cursor, chunk.length));
						else
							result.fullYear = new Number(value.substr(cursor, chunk.length));
						break;
					
					case "M":
						result.month = new Number(value.substr(cursor, chunk.length)) - 1;
						break;
					
					case "d":
						result.date = new Number(value.substr(cursor, chunk.length));
						break;
						
					case "H":
						result.hours = new Number(value.substr(cursor, chunk.length));
						break;
						
					case "m":
						result.minutes = new Number(value.substr(cursor, chunk.length));
						break;
						
					case "s":
						result.seconds = new Number(value.substr(cursor, chunk.length));
						break;
						
					case "S":
						result.milliseconds = new Number(value.substr(cursor, chunk.length));
						break;
				}
				
				cursor += chunk.length;
			}
			
			
			return result;
		}
		
		internal function getYear(value:Date, size:int):String {
			var result:String = value.fullYear.toString();
			
			if (result.length < size) {
				result = zeroPad(value.fullYear, size);
			}
			
			if (result.length > size) {
				result = result.substr(result.length - size);
			}
			
			return result;
		}
		
		internal function getMonth(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.month + 1).toString();
				
			if (size == 2)
				result = zeroPad(value.month + 1, 2);
				
			if (size == 3)
				result = MONTH_NAMES_ABBREVIATED[value.month];
				
			if (size == 4)
				result = MONTH_NAMES_FULL[value.month];
			
			return result;
		}
		
		internal function getDayOfMonth(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = value.date.toString();
			
			if (size == 2)
				result = zeroPad(value.date, 2);
			
			return result;
		}
		
		internal function getDayOfWeek(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.day + 1).toString();
				
			if (size == 2)
				result = zeroPad(value.day + 1, 2);
				
			if (size == 3)
				result = DAYS_OF_WEEK_ABBREVIATED[value.day];
				
			if (size == 4)
				result = DAYS_OF_WEEK_FULL[value.day];
			
			return result;
		}
		
		internal function getAMPM(value:Date):String {
			return value.hours < 12 ? AM : PM;
		}
		
		internal function getHourOfDay0(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = value.hours.toString();
				
			if (size == 2)
				result = zeroPad(value.hours, 2);
			
			return result;
		}
		
		internal function getHourOfDay1(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.hours + 1).toString();
				
			if (size == 2)
				result = zeroPad(value.hours + 1, 2);
			
			return result;
		}
		
		internal function getHourOfDay2(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.hours > 11 ? value.hours - 12 : value.hours).toString();
			
			if (size == 2)
				result = zeroPad(value.hours > 11 ? value.hours - 12 : value.hours, 2);
			
			return result;
		}
		
		internal function getHourOfDay3(value:Date, size:int):String {
			var result:String = null;
			
			if (value.hours == 0 || value.hours == 12) {
				result = "12";
			} else {
				if (size == 1) 
					result = int(value.hours > 12 ? value.hours - 12 : value.hours).toString();
				
				if (size == 2)
					result = zeroPad(value.hours > 12 ? value.hours - 12 : value.hours, 2);
			}
			
			return result;
		}
		
		internal function getMinuteOfHour(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.minutes).toString();
			
			if (size == 2)
				result = zeroPad(value.minutes, 2);
			
			return result;
		}
		
		internal function getSecondOfMinute(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.seconds).toString();
				
			if (size == 2)
				result = zeroPad(value.seconds, 2);
			
			return result;
		}
		
		internal function getMillisecond(value:Date, size:int):String {
			var result:String = null;
			
			if (size == 1)
				result = int(value.milliseconds).toString();
				
			if (size == 2)
				result = zeroPad(value.milliseconds, 2);
			
			if (size == 3)
				result = zeroPad(value.milliseconds, 3);
			
			return result;
		}
		
		internal function zeroPad(value:Number, minimumDigits:Number):String {
			var result:String = value.toString();
			while (result.length < minimumDigits) {
				result = "0" + result;
			}
			
			return result;
		}
		
		internal function getDigits(value:Number):int {
			var currentPower:uint = 1;
			
			while (value >= Math.pow(10, currentPower)) {
				currentPower++;
			}
			
			return currentPower;
		}
		
		[Bindable]
		public function get pattern():String { return _pattern; }
		public function set pattern(value:String):void { _pattern = value; }
		
		public function getPattern():String { return _pattern; }
		
		public function setPattern(value:String):SimpleDateFormat { 
			this.pattern = value; 
			return this; 
		}
	}
}
