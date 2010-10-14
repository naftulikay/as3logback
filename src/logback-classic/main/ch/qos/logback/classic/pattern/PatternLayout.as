package ch.qos.logback.classic.pattern {
	
	
	
	
	
	
	
	
	import ch.qos.logback.core.LoggerEntry;
	import ch.qos.logback.core.layout.AbstractLayout;

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class PatternLayout extends AbstractLayout {
		
		private var formattingPatternProcessor:Converter = new FormattingConverter();
		
		private var _processors:Vector.<Converter> = new Vector.<Converter>();
		
		private var splitter:RegExp = /((?<!\\)%(?:(?:\\-?[0-9]+)?\\.?(?:\\-?[0-9]+))?(?:[\w\.\-]+)?(?:\(.+?\))?(?:\{.+?\})?)/;
		
		private var percentEscape:RegExp = /(\\%)/;
		
		private var _pattern:String = "%d [%p] %c - %m %e %n";
		
		public function PatternLayout() {
			this.processors.push(formattingPatternProcessor,
				new CallerNameConverter(),
				new ClassNameConverter(),
				new DateConverter(),
				new ExceptionConverter(),
				new FileNameConverter(),
				new LevelNameConverter(),
				new LineNumberConverter(),
				new LoggerNameConverter(),
				new MessageConverter(),
				new MethodNameConverter(),
				new NewlineConverter(),
				new RelativeConverter()
			);
		}
		
		override public function apply(value:LoggerEntry) : String {
			var chunks:Array = this.pattern.split(splitter);
				
			for (var i:uint = 0; i < chunks.length; i++) {
				var chunk:String = chunks[i];
				
				if (splitter.test(chunk)) {
//					if we have a viable pattern, operate
					chunks[i] = operate(chunk, value);
				} else if (percentEscape.test(chunk)) {
//					if we have an escaped pattern, break it apart and replace 
					chunks[i] = unescapePercent(chunk);
				}
			}
			
			return chunks.join("");
		}
		
		public function operate(value:String, entry:LoggerEntry):String {
			for each (var processor:Converter in processors) {
				if (processor.test(value)) {
//					operate!!!
					if (!(processor is FormattingConverter))
						value = processor.apply(value, entry);
					else 
						value = unescapeFormat(value, entry);
					break; // break since we're pretty much done here. 
				}
			}
			
			return value;
		}
		
		public function unescapeFormat(value:String, entry:LoggerEntry):String {
//			get the formatted contents
			value = formattingPatternProcessor.apply(value, entry);
//			split it up into other parameters and extras
			var chunks:Array = value.split(splitter);
//			loop over and replace if need be
			for (var i:uint = 0; i < chunks.length; i++) {
				var chunk:String = chunks[i];
				
				if (splitter.test(chunk)) {
					chunks[i] = operate(chunk, entry);
				} else if (percentEscape.test(chunk)) {
					chunks[i] = unescapePercent(chunk);
				}
			}
			
			return chunks.join("");
		}
		
		public function unescapePercent(value:String):String {
			var result:Array = value.split(percentEscape);
			
			for (var i:uint = 0; i < result.length; i++) {
				var chunk:String = result[i];
				if (percentEscape.test(chunk))
					result[i] = "%";
			}
			
			return result.join("");
		}
		
		[Bindable]
		[Configurable]
		public function get pattern():String { return _pattern; }
		public function set pattern(value:String):void { _pattern = value; }
		
		[Bindable]
		public function get processors():Vector.<Converter> { return _processors; }
		public function set processors(value:Vector.<Converter>):void { _processors = value; }
		
		public function getPattern():String { return pattern; }
		
		public function setPattern(value:String):PatternLayout {
			this.pattern = value;
			return this;
		}
	}
}
