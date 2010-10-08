package ch.qos.logback.classic.layout.pattern {
	
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	[Suite][RunWith("org.flexunit.runners.Suite")]
	public class PatternTestSuite {
		
		public var abstractPatternLayoutProcessorTestCase:AbstractPatternLayoutProcessorTestCase;
		
		public var callerNameLayoutProcessorTestCase:CallerNamePatternLayoutProcessorTestCase;
		
		public var classNameLayoutProcessorTestCase:ClassNamePatternLayoutProcessorTestCase;
		
		public var datePatternLayoutProcessorTestCase:DatePatternLayoutProcessorTestCase;
		
		public var formattingPatternLayoutProcessorTestCase:FormattingPatternLayoutProcessorTestCase;
		
		public var levelNamePatternLayoutProcessorTestCase:LevelNamePatternLayoutProcessorTestCase;
		
		public var loggerNamePatternLayoutProcessorTestCase:LoggerNamePatternLayoutProcessorTestCase;
		
		public var newlinePatternLayoutProcessorTestCase:NewlinePatternLayoutProcessorTestCase;
	}
}
