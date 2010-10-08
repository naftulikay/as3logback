package ch.qos.logback.classic.layout.pattern {
	import ch.qos.logback.core.LoggerEntry;
	import ch.qos.logback.core.layout.AbstractLayout;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class PatternLayout extends AbstractLayout {
		
		private var callerNameProcessor:PatternLayoutProcessor = new CallerNamePatternLayoutProcessor();
		
		private var classNameProcessor:PatternLayoutProcessor = new ClassNamePatternLayoutProcessor();
		
		private var dateProcessor:PatternLayoutProcessor = new DatePatternLayoutProcessor();
		
		private var exceptionProcessor:PatternLayoutProcessor = new ExceptionPatternLayoutProcessor();
		
		private var fileNameProcessor:PatternLayoutProcessor = new FileNamePatternLayoutProcessor();
		
		private var levelNameProcessor:PatternLayoutProcessor = new LevelNamePatternLayoutProcessor();
		
		private var lineNumberProcessor:PatternLayoutProcessor = new LineNumberPatternLayoutProcessor();
		
		private var loggerNameProcessor:PatternLayoutProcessor = new LoggerNamePatternLayoutProcessor();
		
		private var messageProcessor:PatternLayoutProcessor = new MessagePatternLayoutProcessor();
		
		private var methodNameProcessor:PatternLayoutProcessor = new MethodNamePatternLayoutProcessor();
		
		private var processors:Vector.<PatternLayoutProcessor> = new Vector.<PatternLayoutProcessor>(
				callerNameProcessor, classNameProcessor, dateProcessor, exceptionProcessor,
				fileNameProcessor, levelNameProcessor, lineNumberProcessor, loggerNameProcessor,
				messageProcessor, methodNameProcessor
			);
		
		private var _pattern:String;
		
		override public function apply(value:LoggerEntry) : String {
			var result:String = "";
			if (processors)
				value = null;	
			return result;
		}
		
		[Bindable]
		[Configurable]
		public function get pattern():String { return _pattern; }
		public function set pattern(value:String):void { _pattern = value; }
		
		public function getPattern():String { return pattern; }
		
		public function setPattern(value:String):PatternLayout {
			this.pattern = value;
			return this;
		}
	}
}
