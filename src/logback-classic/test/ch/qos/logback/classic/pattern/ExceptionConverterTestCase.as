package ch.qos.logback.classic.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ExceptionConverterTestCase {
		
		private var reference:ExceptionConverter;
		
		[Before]
		public function setup():void {
			this.reference = new ExceptionConverter();
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%exception", "%ex", "%throwable", "%error",
				"%err", "%er", "%e", "%20exception", "%20.20exception", 
				"%20.20exception{23}", "%20.20exception{short}", 
				"%20.20exception{full}"];
				
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject '%unrelated'.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
//			test for simple return null if no exceptions found
			Assert.assertEquals("Failed to return an empty string if no errors are present " +
				"in the parameters.", "", this.reference.apply("%e", 
					new DefaultLoggerEntry(null, null, null, null, new Vector.<Object>())));
					
			var error1:Error = new MockError("It's the end of the world as we know it...");
			var error2:Error = new MockError("...and I feel fine.");
			
			var v1:Vector.<Object> = new Vector.<Object>();
			v1.push(error1);
			
			var v2:Vector.<Object> = new Vector.<Object>();
			v2.push(error1, error2);
			
//			test against entire stacktrace with no parameter
			Assert.assertEquals("Failed to return the entire stacktrace when no parameter is given.",
				error1.getStackTrace(), this.reference.apply("%e", new DefaultLoggerEntry(null, 
					null, null, null, v1)));
			
//			test against entire stacktrace with 'full' parameter
			Assert.assertEquals("Failed to return the entire stacktrace when 'full' is given.",
				error1.getStackTrace(), this.reference.apply("%e{full}",
					new DefaultLoggerEntry(null, null, null, null, v1)));
			
//			test against limited stacktrace with 'short' parameter
			Assert.assertEquals("Failed to return two-line stacktrace when 'short' is given.",
				error1.getStackTrace().split(new RegExp("\n")).slice(0, 2).join("\n"), 
				this.reference.apply("%e{short}", new DefaultLoggerEntry(null, null, null, null,
					v1)));
					
//			test against limited stacktrace with numerical parameter
			Assert.assertEquals("Failed to return three-line stacktrace when '2' is given.",
				error1.getStackTrace().split(new RegExp("\n")).slice(0, 3).join("\n"), 
				this.reference.apply("%e{2}", new DefaultLoggerEntry(null, null, null, null, 
					v1)));
			
//			test against multiple errors concatenated, untrimmed
			Assert.assertEquals("Failed to concatenate two errors with no parameter is given.",
				error1.getStackTrace() + "\n" + error2.getStackTrace(), 
				this.reference.apply("%e", new DefaultLoggerEntry(null, null, null, null, v2)));
					
//			test against multiple errors concatenated using 'full' parameter
			Assert.assertEquals("Failed to concatenate two errors when 'full' is given.",
				error1.getStackTrace() + "\n" + error2.getStackTrace(), 
				this.reference.apply("%e{full}", new DefaultLoggerEntry(null, null, null, null, v2)));
			
//			test against multiple errors being trimmed using 'short' parameter.
			Assert.assertEquals("Failed to concatenate two errors to the result, trimming as 'short'.",
				error1.getStackTrace().split(new RegExp("\n")).slice(0, 2).join("\n") + "\n" + 
					error2.getStackTrace().split(new RegExp("\n")).slice(0, 2).join("\n"), 
				this.reference.apply("%e{short}", new DefaultLoggerEntry(null, null, null, null, 
					v2)));
					
//			test against multiple errors being trimmed using numerical parameter
			Assert.assertEquals("Failed to concatenate two errors when numerical parameter is given.",
				error1.getStackTrace().split(new RegExp("\n")).slice(0, 3).join("\n") + "\n" +
					error2.getStackTrace().split(new RegExp("\n")).slice(0, 3).join("\n"), 
				this.reference.apply("%e{2}", new DefaultLoggerEntry(null, null, null, null, v2)));
		}
	}
}

class MockError extends Error {
	
	public function MockError(message:String) {
		super(message);
	}
	
	override public function getStackTrace():String {
		return "Error: " + message + "\n" +
			"	at com.something.other::Hello/apply()\n" +
			"	at com.something.other::Hello/applyA()\n" + 
			"	at com.something.other::Hello/applyB()\n" +
			"	at com.something.other::Hello/applyC()";
	}
}
