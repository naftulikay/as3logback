package ch.qos.logback.classic.pattern {
	import com.gskinner.performance.MethodTest;
	import com.gskinner.performance.TestSuite;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class PatternPerformanceTestSuite extends TestSuite {
		
//		private var loops:uint = 100000;
		
		public function PatternPerformanceTestSuite() {
			name = "PatternPerformanceTestSuite";
			description = "Demonstrates speed of pattern formatting components.";
//			tareTest = new MethodTest(tare);
			iterations = 50;
			tests = [
//				AbstractConverter
				new MethodTest(new AbstractConverterPTestCase().testAlignLeft, null, "Left Whitespace Padding", 0, 1, 
					"Tests left padding/alignment of strings."),
				new MethodTest(new AbstractConverterPTestCase().testAlignRight, null, "Right Whitespace Padding", 0, 1,
					"Tests right padding/alignment of strings."),
//				CallerNameConverter
				new MethodTest(new CallerNameConverterPTestCase().testApply, null, "FORMAT: %caller", 0, 1,
					"Tests formatting and generation of simple caller name."),
				new MethodTest(new CallerNameConverterPTestCase().testApplyWithAlign, null, "FORMAT: %100caller", 0, 1,
					"Tests formatting, generation, and alignment of simple caller name."),
				new MethodTest(new CallerNameConverterPTestCase().testApplyFull, null, "FORMAT: %caller{100}.", 0, 1,
					"Tests formatting and generation of full caller trace."),
				new MethodTest(new CallerNameConverterPTestCase().testApplyFullWithAlign, null, "FORMAT: %100caller{100}", 0, 1,
					"Tests formatting, generation, and alignment of full caller trace."),
//				ClassNameConverter
				new MethodTest(new ClassNameConverterPTestCase().testApply, null, "FORMAT: %class", 0, 1,
					"Tests formatting of calling class name."),
				new MethodTest(new ClassNameConverterPTestCase().testApplyWithAlign, null, "FORMAT: %100class", 0, 1,
					"Tests formatting and alignment of calling class name."),
				new MethodTest(new ClassNameConverterPTestCase().testApplyShrunk, null, "FORMAT: %class{1}", 0, 1,
					"Tests formatting and shrinkification of calling class name."),
				new MethodTest(new ClassNameConverterPTestCase().testApplyShrunkWithAlign, null, "FORMAT: %100class{1}", 0, 1,
					"Tests formatting, alignment, and shrinkification of calling class name."),
//				DateConverter
				new MethodTest(new DateConverterPTest().testApply, null, "FORMAT: %d{yyyy-MM-dd HH:mm:ss,SSS}", 0, 1,
					"Tests formatting of a simple date."),
				new MethodTest(new DateConverterPTest().testApplyWithAlign, null, "FORMAT: %100d{yyyy-MM-dd HH:mm:ss,SSS}", 0, 1,
					"Tests formatting and alignment of a simple date."),
//				ExceptionConverter
				new MethodTest(new ExceptionConverterPTestCase().testApply, null, "FORMAT: %error", 0, 1,
					"Tests formatting of a full exception."),
				new MethodTest(new ExceptionConverterPTestCase().testApplyWithAlign, null, "FORMAT: %100error", 0, 1,
					"Tests formatting and alignment of a full exception."),
				new MethodTest(new ExceptionConverterPTestCase().testApplyShort, null, "FORMAT: %error{short}", 0, 1,
					"Tests formatting of a short exception."),
				new MethodTest(new ExceptionConverterPTestCase().testApplyShortWithAlign, null, "FORMAT: %100error{short}", 0, 1,
					"Tests formatting and alignment of a short exception."),
//				FileNameConverter
				new MethodTest(new FileNameConverterPTestCase().testApply, null, "FORMAT: %file", 0, 1,
					"Tests formatting of a caller filename."),
				new MethodTest(new FileNameConverterPTestCase().testApplyWithAlign, null, "FORMAT: %100file", 0, 1,
					"Tests formatting and alignment of a filename."),
//				FormattingConverter
				new MethodTest(new FormattingConverterPTestCase().testApply, null, "FORMAT: %100(A brand new world is amazing!)", 0, 1,
					"Tests alignment of a subblock of text."),
//				LevelNameConverter
				new MethodTest(new LevelNameConverterPTestCase().testApply, null, "FORMAT: %level", 0, 1,
					"Tests formatting of a level."),
				new MethodTest(new LevelNameConverterPTestCase().testApplyWithAlign, null, "FORMAT: %100level", 0, 1,
					"Tests formatting and alignment of a level"),
				new MethodTest(new LevelNameConverterPTestCase().testApplyFirst, null, "FORMAT: %level{first}", 0, 1,
					"Tests formatting of a level with first letter capitalized."),
				new MethodTest(new LevelNameConverterPTestCase().testApplyFirstWithAlign, null, "FORMAT: %100level{first}", 0, 1,
					"Tests formatting and alignment of a level with first letter capitalized."),
				new MethodTest(new LevelNameConverterPTestCase().testApplyLowercase, null, "FORMAT: %level{lower}", 0, 1,
					"Tests formatting of a level in lowercase."),
				new MethodTest(new LevelNameConverterPTestCase().testApplyLowercaseWithAlign, null, "FORMAT: %100level{lower}", 0, 1,
					"Tests formatting and alignment of a level in lowercase."),
				new MethodTest(new LevelNameConverterPTestCase().testApplyUppercase, null, "FORMAT: %level{upper}", 0, 1,
					"Tests formatting of a level in uppercase."),
				new MethodTest(new LevelNameConverterPTestCase().testApplyUppercaseWithAlign, null, "FORMAT: %100level{upper}", 0, 1,
					"Tests formatting and alignment of a level in uppercase.")
//				LineNumberConverter
			];
		}
	}
}
