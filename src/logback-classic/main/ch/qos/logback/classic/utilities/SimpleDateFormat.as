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
		
		internal static const yearExpression:RegExp = new RegExp("(?<!\\{)(y{4}|y{2})(?!\\})");
		
		internal static const yearTokenExpression:RegExp = new RegExp("\\{(y{4}|y{2})\\}");
		
		internal static const monthExpression:RegExp = new RegExp("(?<!\\{)(M{1,4})(?!\\})");
		
		internal static const monthTokenExpression:RegExp = new RegExp("\\{(M{1,4})\\}");
		
		internal static const dayOfMonthExpression:RegExp = new RegExp("(?<!\\{)(d{1,2})(?!\\})");
				internal static const dayOfMonthTokenExpression:RegExp = new RegExp("\\{(d{1,2})\\}");
		
		internal static const dayOfWeekExpression:RegExp = new RegExp("(?<!\\{)(E{1,4})(?!\\})");
				internal static const dayOfWeekTokenExpression:RegExp = new RegExp("\\{(E{1,4})\\}");
		
		internal static const ampmExpression:RegExp = new RegExp("(?<!\\{)(a{1,2})(?!\})");
				internal static const ampmTokenExpression:RegExp = new RegExp("\\{(a{1,2})\\}");
		
		internal static const hourOfDayExpression0:RegExp = new RegExp("(?<!\\{)(H{1,2})(?!\})"); // 0-23 
				internal static const hourOfDayTokenExpression0:RegExp = new RegExp("\\{(H{1,2})\\}"); // 0-23 
		
		internal static const hourOfDayExpression1:RegExp = new RegExp("(?<!\\{)(k{1,2})(?!\})"); // 1-24
				internal static const hourOfDayTokenExpression1:RegExp = new RegExp("\\{(k{1,2})\\}"); // 1-24
		
		internal static const hourOfDayExpression2:RegExp = new RegExp("(?<!\\{)(K{1,2})(?!\})"); // 0-11, ampm 		
		internal static const hourOfDayTokenExpression2:RegExp = new RegExp("\\{(K{1,2})\\}"); // 0-11, ampm 
		
		internal static const hourOfDayExpression3:RegExp = new RegExp("(?<!\\{)(h{1,2})(?!\})"); // 1-12, ampm
				internal static const hourOfDayTokenExpression3:RegExp = new RegExp("\\{(h{1,2})\\}"); // 1-12, ampm
		
		internal static const minuteOfHourExpression:RegExp = new RegExp("(?<!\\{)(m{1,2})(?!\})");
				internal static const minuteOfHourTokenExpression:RegExp = new RegExp("\\{(m{1,2})\\}");
		
		internal static const secondOfMinuteExpression:RegExp = new RegExp("(?<!\\{)(s{1,2})(?!\})");		
		internal static const secondOfMinuteTokenExpression:RegExp = new RegExp("\\{(s{1,2})\\}");
		
		internal static const millisecondExpression:RegExp = new RegExp("(?<!\\{)(S{1,3})(?!\})");
				internal static const millisecondTokenExpression:RegExp = new RegExp("\\{(S{1,3})\\}");
		
		private var _pattern:String;
		
		public function SimpleDateFormat(pattern:String = null) {
			this.pattern = pattern;
		}
		
		public function applyPattern(pattern:String):void {
			this.pattern = pattern;
		}
		
		public function format(date:Date):String {
			var result:String = this.pattern;
			
//			result = this.tokenize(result);
			
			result = this.apply(result, yearExpression, date); // years
			result = this.apply(result, monthExpression, date); // months
			result = this.apply(result, dayOfMonthExpression, date); // date
			result = this.apply(result, dayOfWeekExpression, date); // day of week
			result = this.apply(result, ampmExpression, date); // am/pm
			result = this.apply(result, hourOfDayExpression0, date); // hour of day (0-23)
			result = this.apply(result, hourOfDayExpression1, date); // hour of day (1-24)
			result = this.apply(result, hourOfDayExpression2, date); // hour of day (0-11)
			result = this.apply(result, hourOfDayExpression3, date); // hour of day (1-12)
			result = this.apply(result, minuteOfHourExpression, date); // minute of hour
			result = this.apply(result, secondOfMinuteExpression, date); // second of minute
			result = this.apply(result, millisecondExpression, date); // milliseconds
			
			return result;
		}
		
		internal function tokenize(input:String):String {
			var result:String = input;
			var searchers:Array = [yearExpression, monthExpression, dayOfMonthExpression, dayOfWeekExpression,
				ampmExpression, hourOfDayExpression0, hourOfDayExpression1, hourOfDayExpression2, 
				hourOfDayExpression3, minuteOfHourExpression, secondOfMinuteExpression, millisecondExpression];
			
			for each (var searcher:RegExp in searchers) {
				while (searcher.test(result)) {
					var matchGroups:Object = searcher.exec(result);
					
					switch (searcher) {
						case yearExpression:
							result = result.replace(yearExpression, "{" + matchGroups[1] + "}");
							break;
						
						case monthExpression:
							result = result.replace(monthExpression, "{" + matchGroups[1] + "}");
							break;
							
						case dayOfMonthExpression:
							result = result.replace(dayOfMonthExpression, "{" + matchGroups[1] + "}");
							break;
							
						case dayOfWeekExpression:
							result = result.replace(dayOfWeekExpression, "{" + matchGroups[1] + "}");
							break;
							
						case ampmExpression:
							result = result.replace(ampmExpression, "{a}");
							break;
							
						case hourOfDayExpression0:
							result = result.replace(hourOfDayExpression0, "{" + matchGroups[1] + "}");
							break;
							
						case hourOfDayExpression1:
							result = result.replace(hourOfDayExpression1, "{" + matchGroups[1] + "}");
							break;
							
						case hourOfDayExpression2:
							result = result.replace(hourOfDayExpression2, "{" + matchGroups[1] + "}");
							break;
							
						case hourOfDayExpression3:
							result = result.replace(hourOfDayExpression3, "{" + matchGroups[1] + "}");
							break;
							
						case minuteOfHourExpression:
							result = result.replace(minuteOfHourExpression, "{" + matchGroups[1] + "}");
							break;
							
						case secondOfMinuteExpression:
							result = result.replace(secondOfMinuteExpression, "{" + matchGroups[1] + "}");
							break;
						
						case millisecondExpression:
							result = result.replace(millisecondExpression, "{" + matchGroups[1] + "}");
							break;
					}
				}
			}
			
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
