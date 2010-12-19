package ch.qos.logback.classic.utilities {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SimpleDateFormatTestCase {
		
		private var reference:SimpleDateFormat;
		
		[Before]
		public function setup():void {
			this.reference = new SimpleDateFormat("yy-MM-dd HH:mm:ss,SSS");
		}
		
		[Test]
		public function test$constructor():void {
			this.reference = new SimpleDateFormat("MM-dd-yy");
			
			Assert.assertEquals("Failed to set date pattern from constructor.",
				"MM-dd-yy", this.reference.pattern);
		}
		
		[Test]
		public function test$pattern():void {
			this.reference.pattern = "abc";
			
			Assert.assertEquals("Failed to set pattern using implicit setter/implicit getter.",
				'abc', this.reference.pattern);
				
			Assert.assertEquals("Failed to set pattern using implicit setter/explicit getter.",
				'abc', this.reference.getPattern());
				
			this.reference.setPattern("ghi");
			
			Assert.assertEquals("Failed to set pattern using explicit setter/implicit getter.",
				"ghi", this.reference.pattern);
				
			Assert.assertEquals("Faield to set pattern using explicit setter/explicit getter.",
				"ghi", this.reference.getPattern());
				
			this.reference.applyPattern("def");
			
			Assert.assertEquals("Failed to set pattern using 'applyPattern'/implicit getter.",
				"def", this.reference.pattern);
				
			Assert.assertEquals("Failed to set pattern using 'applyPattern'/explicit getter.",
				"def", this.reference.getPattern());
		}
		
		[Test]
		public function testFormat():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			var expected:String = "1970 70 1 01 Jan January 1 01 5 05 Thurs Thursday AM 0 00 1 01 0 00 12 12 0 00 0 00 0 00 000";
			
			this.reference.setPattern("yyyy yy M MM MMM MMMM d dd E EE EEE EEEE a H HH k kk K KK h hh m mm s ss S SS SSS");
			
			Assert.assertEquals("Failed to evaluate pattern.",
				expected, this.reference.format(date));
		}
		
		[Test]
		public function testParse():void {
//			test for returning null values on useless data
			Assert.assertNull("Failed to return null on a null value string.",
					this.reference.parse(null));
					
			Assert.assertNull("Failed to return null on a zero-length string.",
					this.reference.parse(""));
			
			Assert.assertNull("Failed to return null when pattern is null.",
					this.reference.setPattern(null).parse("12345"));
					
			Assert.assertNull("Failed to return null when pattern is zero-length.",
					this.reference.setPattern("").parse("12345"));
				
//			test for not returning null on appropriate data
			Assert.assertNotNull("Failed to return a non-null value on appropriate info.",
					this.reference.setPattern("MM").parse("12"));
					
//			test for associated use cases.
			Assert.assertEquals("Failed to return proper date for time value.",
					new Date(0, 0, 0, 12, 30, 30, 500).time, 
					this.reference.setPattern("HH:mm:ss,SSS").parse("12:30:30,500").time);
					
			Assert.assertEquals("Failed to return proper date for date value.",
					new Date(2010, 11, 1, 0, 0, 0 ,0).time, 
					this.reference.setPattern("MM/dd/yyyy").parse("12/01/2010").time);
					
			Assert.assertEquals("Failed to return proper date and time for datetime value.",
					new Date(2010, 11, 1, 12, 30, 30, 500).time,
					this.reference.setPattern("MM/dd/yyyy HH:mm:ss,SSS").parse("12/01/2010 12:30:30,500").time);
		}
		
		[Test]
		public function testGetYear():void {
			var date:Date = new Date();
			var old:Date = new Date(300, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to trim year to two digits.", 
				date.fullYear.toString().substr(2), 
				this.reference.getYear(date, 2));
				
			Assert.assertEquals("Failed to return four digit year.", 
				date.fullYear.toString(),
				this.reference.getYear(date, 4));
				
			Assert.assertEquals("Failed to pad year smaller than 4 digits.",
				"0300", this.reference.getYear(old, 4));
		}
		
		[Test]
		public function testGetMonth():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit month.",
				"1", this.reference.getMonth(date, 1));
				
			Assert.assertEquals("Failed to return two-digit padded month.",
				"01", this.reference.getMonth(date, 2));
				
			Assert.assertEquals("Failed to return abbreviated month name.",
				"Jan", this.reference.getMonth(date, 3));
				
			Assert.assertEquals("Failed to return month name.",
				"January", this.reference.getMonth(date, 4));
		}
		
		[Test]
		public function testGetDayOfMonth():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit date.",
				"1", this.reference.getDayOfMonth(date, 1));
				
			Assert.assertEquals("Failed to return two-digit padded date.",
				"01", this.reference.getDayOfMonth(date, 2));
		}
		
		[Test]
		public function testGetDayOfWeek():void {
//			thursday is the first day of the week in 1970, day 5
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit day of week.",
				"5", this.reference.getDayOfWeek(date, 1));
			
			Assert.assertEquals("Failed to return two-digit padded day of week.",
				"05", this.reference.getDayOfWeek(date, 2));
				
			Assert.assertEquals("Failed to return abbreviated name of day.",
				"Thurs", this.reference.getDayOfWeek(date, 3));
				
			Assert.assertEquals("Failed to return name of day.",
				"Thursday", this.reference.getDayOfWeek(date, 4));
		}
		
		[Test]
		public function testGetAMPM():void {
			var midnight:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			var morning:Date = 	new Date(1970, 0, 1, 6, 0, 0, 0);
			var eleven:Date = 	new Date(1970, 0, 1, 11, 0, 0, 0);
			var noon:Date = 	new Date(1970, 0, 1, 12, 0, 0, 0);
			var one:Date =		new Date(1970, 0, 1, 13, 0, 0, 0);
			var evening:Date = 	new Date(1970, 0, 1, 18, 0, 0, 0);
			
			Assert.assertEquals("Failed to return AM for midnight.",
				SimpleDateFormat.AM, this.reference.getAMPM(midnight));
				
			Assert.assertEquals("Failed to return AM for morning.",
				SimpleDateFormat.AM, this.reference.getAMPM(morning));
				
			Assert.assertEquals("Failed to return AM for eleven AM.",
				SimpleDateFormat.AM, this.reference.getAMPM(eleven));
				
			Assert.assertEquals("Failed to return PM for noon.",
				SimpleDateFormat.PM, this.reference.getAMPM(noon));
				
			Assert.assertEquals("Failed to return PM for one PM.",
				SimpleDateFormat.PM, this.reference.getAMPM(one));
				
			Assert.assertEquals("Failed to return PM for evening.",
				SimpleDateFormat.PM, this.reference.getAMPM(evening));
		}
		
		[Test]
		public function testGetHourOfDay0():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit hour.",
				"0", this.reference.getHourOfDay0(date, 1));
				
			Assert.assertEquals("Failed to return two-digit padded hour.",
				"00", this.reference.getHourOfDay0(date, 2));
		}
		
		[Test]
		public function testGetHourOfDay1():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit hour.",
				"1", this.reference.getHourOfDay1(date, 1));
				
			Assert.assertEquals("Failed to return two-digit padded hour.",
				"01", this.reference.getHourOfDay1(date, 2));
		}
		
		[Test]
		public function testGetHourOfDay2():void {
			var midnight:Date = new Date(1970, 0, 1, 0, 0, 0 ,0);
			var noon:Date = new Date(1970, 0, 0, 12, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit hour.",
				"0", this.reference.getHourOfDay2(midnight, 1));
				
			Assert.assertEquals("Failed to return two-digit padded hour.",
				"00", this.reference.getHourOfDay2(midnight, 2));
				
			Assert.assertEquals("Failed to wrap value to zero with a single-digit.",
				"0", this.reference.getHourOfDay2(noon, 1));
				
			Assert.assertEquals("Failed to wrap value to zero with a two-digit.",
				"00", this.reference.getHourOfDay2(noon, 2));
		}
		
		[Test]
		public function testGetHourOfDay3():void {
			var midnight:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			var sixAM:Date = new Date(1970, 0, 1, 6, 0, 0, 0);
			var noon:Date = new Date(1970, 0, 0, 12, 0, 0, 0);
			var sixPM:Date = new Date(1970, 0, 1, 18, 0, 0, 0);
			
			Assert.assertEquals("Failed to return '12' for midnight.",
				"12", this.reference.getHourOfDay3(midnight, 2));
				
			Assert.assertEquals("Failed to return '12' for noon.",
				"12", this.reference.getHourOfDay3(noon, 2));
				
			Assert.assertEquals("Failed to return single-digit hour.",
				"6", this.reference.getHourOfDay3(sixAM, 1));
				
			Assert.assertEquals("Failed to return two-digit padded hour.",
				"06", this.reference.getHourOfDay3(sixAM, 2));
				
			Assert.assertEquals("Failed to wrap 18:00 (6pm) to 6.",
				"06", this.reference.getHourOfDay3(sixPM, 2));
		}
		
		[Test]
		public function testGetMinuteOfHour():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit minutes.",
				"0", this.reference.getMinuteOfHour(date, 1));
			
			Assert.assertEquals("Failed to return two-digit padded minutes.",
				"00", this.reference.getMinuteOfHour(date, 2));
		}
		
		[Test]
		public function testGetSecondOfMinute():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit seconds.",
				"0", this.reference.getSecondOfMinute(date, 1));
				
			Assert.assertEquals("Failed to return two-digit padded seconds.",
				"00", this.reference.getSecondOfMinute(date, 2));
		}
		
		[Test]
		public function testGetMillisecond():void {
			var date:Date = new Date(1970, 0, 1, 0, 0, 0, 0);
			
			Assert.assertEquals("Failed to return single-digit milliseconds.",
				"0", this.reference.getMillisecond(date, 1));
				
			Assert.assertEquals("Failed to return two-digit padded milliseconds.",
				"00", this.reference.getMillisecond(date, 2));
				
			Assert.assertEquals("Failed to return three-digit padded milliseconds.",
				"000", this.reference.getMillisecond(date, 3));
		}
		
		[Test]
		public function testZeroPad():void {
			Assert.assertEquals("Failed to zero-pad '1' to '001'.",
				"001", this.reference.zeroPad(1, 3));
				
			Assert.assertEquals("Failed to leave '1' as is when padding to 1 digit wide.",
				"1", this.reference.zeroPad(1, 1));
		}
		
		[Test]
		public function testGetDigits():void {
			Assert.assertEquals("Failed to get number of digits for '1,000,000'.",
				7, this.reference.getDigits(1000000));
				
			Assert.assertEquals("Faield to get number of digits for '1'.",
				1, this.reference.getDigits(1));
		}
	}
}
