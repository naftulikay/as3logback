package ch.qos.logback.classic.utilities {
	import flash.events.EventDispatcher;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SimpleDateFormat extends EventDispatcher {
//		FIXME This implementation is ridiculous and slow. Find. A. Better. Way.
// 		Like, here's an idea:
//
//			Split the string into an array of word-characters and non-word-characters:
//				['yyyy', '-', 'MM', '-', 'dd']
//
//			Loop through the array, testing each item for whether it's a word or non-word:
//				for each (var item:String in items) {
//					if (new RegExp("\\w").test(item)) {
//						...
//					}
//				}
//			
//			If it's a word, run a replace with an incrementing index, to prevent backwards messups.
		
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
		
		public static const AM:String = "AM";
		
		public static const PM:String = "PM";
		
		internal static const yearExpression:RegExp = new RegExp("(y{4}|y{2})");
		
		internal static const monthExpression:RegExp = new RegExp("(M{1,4})");
		
		internal static const dayOfMonthExpression:RegExp = new RegExp("(d{1,2})");
		
		internal static const dayOfWeekExpression:RegExp = new RegExp("(E{1,4})");
		
		internal static const ampmExpression:RegExp = new RegExp("(a{1,2})");

		internal static const hourOfDayExpression0:RegExp = new RegExp("(H{1,2})"); // 0-23 
		
		internal static const hourOfDayExpression1:RegExp = new RegExp("(k{1,2})"); // 1-24
		
		internal static const hourOfDayExpression2:RegExp = new RegExp("(K{1,2})"); // 0-11, ampm 
		
		internal static const hourOfDayExpression3:RegExp = new RegExp("(h{1,2})"); // 1-12, ampm
		
		internal static const minuteOfHourExpression:RegExp = new RegExp("(m{1,2})");
		
		internal static const secondOfMinuteExpression:RegExp = new RegExp("(s{1,2})");
		
		internal static const millisecondExpression:RegExp = new RegExp("(S{1,3})");
		
		internal static const checks:Array = [yearExpression, monthExpression, dayOfMonthExpression, dayOfWeekExpression, 
			ampmExpression, hourOfDayExpression0, hourOfDayExpression1, hourOfDayExpression2, hourOfDayExpression3,
			minuteOfHourExpression, secondOfMinuteExpression, millisecondExpression
		];
		
		internal static const splitter:RegExp = new RegExp("(\\W+|\\w)");
		
		internal static const wordCheck:RegExp = new RegExp("\\w");
		
		private var _pattern:String;
		
		public function SimpleDateFormat(pattern:String = null) {
			this.pattern = pattern;
		}
		
		public function applyPattern(pattern:String):void {
			this.pattern = pattern;
		}
		
		public function format(date:Date):String {
//			FIXME Please, please, please make me easier to understand!
			var result:String = this.pattern;
//			split the pattern into letter groups and non-word characters.
			var chunks:Array = result.split(splitter);
			
//			for every chunk in the string
			for (var i:uint = 0; i < chunks.length; i++) {
				var chunk:String = chunks[i];
//				if chunk is empty or doesn't have any word characters, skip a loop
				if (chunk == "" || !wordCheck.test(chunk))
					continue;
				
				var entry:String = "";
				
//				while chunk still has stuff left in it
				while (chunk.length > 0) {
					var found:Boolean;
					
//					run each test on the chunk
					for each (var check:RegExp in checks) {
						if (check.test(chunk)) {
//							notify that we found something
							found = true;
//							get the matches of the regexp
							var matchGroup:Object = check.exec(chunk);
//							get the beginning of the first match
							var begin:int = chunk.search(check);
//							get the end of the first match. 
							var end:int = begin + String(matchGroup[1]).length;
							
							if (begin > 0)
								entry += chunk.substring(0, begin -1);
								
							entry += this.apply(matchGroup[1], check, date);
							
							chunk = chunk.substr(end + 1);
						}
					}
					
					if (!found) {
						entry += chunk;
						chunk = "";
					}
				}
				
				chunks[i] = entry;
			}
			
			result = chunks.join("");
						
			return result;
		}
		
		internal function apply(input:String, value:RegExp, date:Date):String {
			var result:String = input;
			
			while (value.test(result)) {
				var matchGroups:Object = value.exec(result);
				
				switch (value) {
					case yearExpression:
						result = result.replace(value, getYear(date, String(matchGroups[1]).length));
						break;
						
					case monthExpression:
						result = result.replace(value, getMonth(date, String(matchGroups[1]).length));
						break;
						
					case dayOfMonthExpression:
						result = result.replace(value, getDayOfMonth(date, String(matchGroups[1]).length));
						break;
						
					case dayOfWeekExpression:
						result = result.replace(value, getDayOfWeek(date, String(matchGroups[1]).length));
						break;
						
					case ampmExpression:
						result = result.replace(value, getAMPM(date));
						break;
						
					case hourOfDayExpression0:
						result = result.replace(value, getHourOfDay0(date, String(matchGroups[1]).length));
						break;
						
					case hourOfDayExpression1:
						result = result.replace(value, getHourOfDay1(date, String(matchGroups[1]).length));
						break;
						
					case hourOfDayExpression2:
						result = result.replace(value, getHourOfDay2(date, String(matchGroups[1]).length));
						break;
						
					case hourOfDayExpression3:
						result = result.replace(value, getHourOfDay3(date, String(matchGroups[1]).length));
						break;
						
					case minuteOfHourExpression:
						result = result.replace(value, getMinuteOfHour(date, String(matchGroups[1]).length));
						break;
						
					case secondOfMinuteExpression:
						result = result.replace(value, getSecondOfMinute(date, String(matchGroups[1]).length));
						break;
					
					case millisecondExpression:
						result = result.replace(value, getMillisecond(date, String(matchGroups[1]).length));
						break;
				}
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
