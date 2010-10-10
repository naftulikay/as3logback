package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.classic.entry.DefaultLoggerEntry;
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class ExceptionPatternLayoutProcessorTestCase {
		
		private var reference:ExceptionPatternLayoutProcessor;
		
		[Before]
		public function setup():void {
			this.reference = new ExceptionPatternLayoutProcessor();
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
					
			var error1:Error = new Error("It's the end of the world as we know it...");
			var error2:Error = new Error("...and I feel fine.");
			
			var v1:Vector.<Object> = new Vector.<Object>();
			v1.push(error1);
			
			var v2:Vector.<Object> = new Vector.<Object>();
			v2.push(error1, error2);
			
//			FIXME This doesn't always work. Sometimes, the stacktrace length below will vary by 1 number, possibly due to the way FlexUnit runs:
			/* Failed to return the entire stacktrace when no parameter is given. - expected:<21>; but was:<22>;
			 *	at org.flexunit::Assert$/failWithUserMessage()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\Assert.as:306]
			 *	at org.flexunit::Assert$/failNotEquals()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\Assert.as:100]
			 *	at org.flexunit::Assert$/assertEquals()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\Assert.as:89]
			 *	at ch.qos.logback.classic.layout.pattern::ExceptionPatternLayoutProcessorTestCase/testApply()[/home/rfkrocktk/Documents/Helios/logback/src/logback-classic/test/ch/qos/logback/classic/layout/pattern/ExceptionPatternLayoutProcessorTestCase.as:51]
			 *	at Function/http://adobe.com/AS3/2006/builtin::apply()
			 *	at flex.lang.reflect::Method/apply()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\flex\lang\reflect\Method.as:244]
			 *	at org.flexunit.runners.model::FrameworkMethod/invokeExplosively()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\runners\model\FrameworkMethod.as:201]
			 *	at org.flexunit.internals.runners.statements::InvokeMethod/evaluate()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\InvokeMethod.as:72]
			 *	at org.flexunit.internals.runners.statements::RunBeforesInline/handleSequenceExecuteComplete()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\RunBeforesInline.as:85]
			 *	at org.flexunit.token::AsyncTestToken/sendResult()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\token\AsyncTestToken.as:107]
			 *	at org.flexunit.internals.runners.statements::AsyncStatementBase/sendComplete()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\AsyncStatementBase.as:76]
			 *	at org.flexunit.internals.runners.statements::StatementSequencer/sendComplete()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\StatementSequencer.as:172]
			 *	at org.flexunit.internals.runners.statements::StatementSequencer/handleChildExecuteComplete()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\StatementSequencer.as:145]
			 *	at org.flexunit.token::AsyncTestToken/sendResult()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\token\AsyncTestToken.as:107]
			 *	at org.flexunit.internals.runners.statements::InvokeMethod/evaluate()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\InvokeMethod.as:73]
			 *	at org.flexunit.internals.runners.statements::SequencerWithDecoration/executeStep()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\SequencerWithDecoration.as:100]
			 *	at org.flexunit.internals.runners.statements::StatementSequencer/handleChildExecuteComplete()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\StatementSequencer.as:141]
			 *	at org.flexunit.internals.runners.statements::StatementSequencer/evaluate()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\StatementSequencer.as:109]
			 *	at org.flexunit.internals.runners.statements::RunBeforesInline/evaluate()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\RunBeforesInline.as:70]
			 *	at org.flexunit.internals.runners.statements::StackAndFrameManagement/handleTimerComplete()[E:\hudson\jobs\FlexUnit4-Flex4\workspace\FlexUnit4\src\org\flexunit\internals\runners\statements\StackAndFrameManagement.as:138]
			 *	at flash.events::EventDispatcher/dispatchEventFunction()
			 *	at flash.events::EventDispatcher/dispatchEvent()
			 *	at flash.utils::Timer/tick()
			 */
			
//			test against entire stacktrace with no parameter
			Assert.assertEquals("Failed to return the entire stacktrace when no parameter is given.",
				error1.getStackTrace().split("\n").length, this.reference.apply("%e", 
					new DefaultLoggerEntry(null, null, null, null, v1)).split("\n").length);
			
//			test against entire stacktrace with 'full' parameter
			Assert.assertEquals("Failed to return the entire stacktrace when 'full' is given.",
				error1.getStackTrace().split("\n").length, this.reference.apply("%e{full}",
					new DefaultLoggerEntry(null, null, null, null, v1)).split("\n").length);
			
//			test against limited stacktrace with 'short' parameter
			Assert.assertEquals("Failed to return two-line stacktrace when 'short' is given.",
				2, this.reference.apply("%e{short}", new DefaultLoggerEntry(null, null, null, null,
					v1)).split("\n").length);
					
//			test against limited stacktrace with numerical parameter
			Assert.assertEquals("Failed to return three-line stacktrace when '2' is given.",
				3, this.reference.apply("%e{2}", new DefaultLoggerEntry(null, null, null, null, 
					v1)).split("\n").length);
			
//			test against multiple errors concatenated, untrimmed
			Assert.assertEquals("Failed to concatenate two errors with no parameter is given.",
				error1.getStackTrace().split("\n").length + error2.getStackTrace().split("\n").length, 
				this.reference.apply("%e", new DefaultLoggerEntry(null, null, null, null, v2))
					.split("\n").length);
					
//			test against multiple errors concatenated using 'full' parameter
			Assert.assertEquals("Failed to concatenate two errors when 'full' is given.",
				error1.getStackTrace().split("\n").length + error2.getStackTrace().split("\n").length, 
				this.reference.apply("%e{full}", new DefaultLoggerEntry(null, null, null, null, v2))
					.split("\n").length);
			
//			test against multiple errors being trimmed using 'short' parameter.
			Assert.assertEquals("Failed to concatenate two errors to the result, trimming as 'short'.",
				4, this.reference.apply("%e{short}", new DefaultLoggerEntry(null, null, null, null, 
					v2)).split("\n").length);
					
//			test against multiple errors being trimmed using numerical parameter
			Assert.assertEquals("Failed to concatenate two errors when numerical parameter is given.",
				6, this.reference.apply("%e{2}", new DefaultLoggerEntry(null, null, null, null, v2))
					.split("\n").length);
		}
	}
}
