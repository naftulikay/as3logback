package ch.qos.logback.classic.layout.pattern {
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class FileNamePatternLayoutProcessorTestCase {
		
		private var reference:FileNamePatternLayoutProcessor;
		
		private var logger:MockLogger;
		
		private var appender:MockAppender;
		
		private var layout:MockLayout;
		
		[Before]
		public function setup():void {
			this.reference = new FileNamePatternLayoutProcessor();
			this.layout = new MockLayout(reference);
			this.appender = new MockAppender(layout);
			this.logger = new MockLogger(appender);
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%F", "%file", "%20file", "%20.20file", 
				"%20.20file{24}"];
			
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.", 
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject an unrelated pattern.",
				this.reference.test("%unrelated"));
		}
		
		[Test]
		public function testApply():void {
			var regex:RegExp = new RegExp("ch/qos/logback/classic/layout/pattern/FileNamePatternLayoutProcessorTestCase\\.as$");
			
			Assert.assertTrue("Failed to return the file name of the caller.",
				regex.test(getResultForPattern("%F")));
				
//			TODO 
		}
		
		private function getResultForPattern(pattern:String):String {
			this.layout.pattern = pattern;
			this.logger.debug("Hello World!", 1, 2, 3);
			return this.appender.getLastEntry();
		}
	}
}
import ch.qos.logback.classic.entry.DefaultLoggerEntryFactory;
import ch.qos.logback.classic.format.DefaultMessageFormatter;
import ch.qos.logback.classic.layout.pattern.FileNamePatternLayoutProcessor;
import ch.qos.logback.core.AbstractLayoutAwareAppender;
import ch.qos.logback.core.AbstractLogger;
import ch.qos.logback.core.Appender;
import ch.qos.logback.core.Level;
import ch.qos.logback.core.LoggerEntry;
import ch.qos.logback.core.layout.AbstractLayout;

import org.slf4fp.Logger;

class MockLogger extends AbstractLogger {
	
	public function MockLogger(appender:MockAppender) {
		super("MockLogger", new DefaultMessageFormatter(), null, Level.TRACE,
			true, new DefaultLoggerEntryFactory());
		this.appenders.add(appender);
	}
	
	override public function trace(message:String, ...args):org.slf4fp.Logger {
		doAppend(Level.TRACE, message, args);
		return this;
	}
	
	override public function debug(message:String, ...args):org.slf4fp.Logger {
		doAppend(Level.DEBUG, message, args);
		return this;
	}
	
	override public function info(message:String, ...args):org.slf4fp.Logger {
		doAppend(Level.INFO, message, args);
		return this;
	}
	
	override public function warn(message:String, ...args):org.slf4fp.Logger {
		doAppend(Level.WARN, message, args);
		return this;
	}
	
	override public function error(message:String, ...args):org.slf4fp.Logger {
		doAppend(Level.ERROR, message, args);
		return this;
	}
	
	private function doAppend(level:Level, message:String, arguments:Array):void {
		var now:Date = new Date();
		
		var args:Vector.<Object> = new Vector.<Object>();
		for each (var arg:* in arguments)
			args.push(arg);
		
		for each (var appender:Appender in appenders.toVector()) {
			appender.append(loggerEntryFactory.create("MockLogger", now, level, 
				message, args, messageFormatter.format(message, arguments)));
		}
	}
}

class MockAppender extends AbstractLayoutAwareAppender {
		
	private var lastEntry:String;
	
	public function MockAppender(layout:MockLayout) {
		this.layout = layout;
	}
	
	override public function append(value:LoggerEntry) : Appender {
		this.lastEntry = this.layout.apply(value);
		return this;
	}
	
	public function getLastEntry():String {
		return lastEntry;
	}
}

class MockLayout extends AbstractLayout {
	
	private var fileNameProcessor:FileNamePatternLayoutProcessor;
	
	private var _pattern:String;
	
	public function MockLayout(processor:FileNamePatternLayoutProcessor) {
		this.fileNameProcessor = processor;
	}
	
	override public function apply(value:LoggerEntry):String {
		return fileNameProcessor.apply(pattern, value);
	}
	
	public function get pattern():String { return _pattern; }
	public function set pattern(value:String):void { _pattern = value; }
}
