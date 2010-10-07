package ch.qos.logback.classic.layout.pattern {
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import org.flexunit.Assert;
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class CallerNamePatternLayoutProcessorTestCase {
		
		private var reference:CallerNamePatternLayoutProcessor;
		
		private var logger:MockLogger;
		
		private var appender:MockAppender;
		
		private var layout:MockLayout;
		
		[Before]
		public function setup():void {
			this.reference = new CallerNamePatternLayoutProcessor();
			this.layout = new MockLayout(this.reference, "%caller");
			this.appender = new MockAppender(this.layout);
			this.logger = new MockLogger();
			this.logger.appenders.add(this.appender);
		}
		
		[Test]
		public function testTest():void {
			var tests:Array = ["%caller", "%20caller", "%20.-20caller", "%20.-20caller{2}"];
			for each (var test:String in tests) {
				Assert.assertTrue("Failed to match '" + test + "'.",
					this.reference.test(test));
			}
			
			Assert.assertFalse("Failed to reject '%abc'.",
				this.reference.test("%abc"));
		}
		
		[Test]
		public function testApply():void {
			Assert.assertTrue("Failed to return single line caller by default.",
				getResultForPattern("%caller").indexOf("getResultForPattern()") != -1);
				
			Assert.assertTrue("Failed to return two line caller when requested.",
				getResultForPattern("%caller{2}").indexOf("testApply()") != -1);
		}
		
		[Test]
		public function testGetDefinition():void {
			Assert.assertEquals("Failed to get the definition for 'ch.qos.logback.classic.pattern.layout.CallerNamePatternLayoutProcessor'.",
				CallerNamePatternLayoutProcessor, this.reference.getDefinition(
					'at ch.qos.logback.classic.layout.pattern::CallerNamePatternLayoutProcessor/apply()'));
			
			Assert.assertEquals("Failed to get the definition for 'flash.utils.getDefinitionByName'.",
				getDefinitionByName, this.reference.getDefinition(
					'at global/flash.utils::getDefinitionByName()'));
			
			Assert.assertEquals("Failed to get the definition for 'Function'.",
				Function, this.reference.getDefinition(
					'at Function/http://adobe.com/AS3/2006/builtin::apply()'));
		}
		
		[Test]
		public function testIsLogbackObject():void {
			Assert.assertTrue("Failed to recognize an implementor of 'ch.qos.logback.core.Appender' as a logback object.",
				this.reference.isLogbackObject(MockAppender));
				
			Assert.assertTrue("Failed to recognize an implementor of 'ch.qos.logback.core.Logger' as a logback object.",
				this.reference.isLogbackObject(MockLogger));
				
			Assert.assertTrue("Failed to recognize an implementor of 'ch.qos.logback.core.Layout' as a logback object.",
				this.reference.isLogbackObject(MockLayout));
				
			Assert.assertTrue("Failed to recognize an implementor of 'ch.qos.logback.classic.layout.pattern.PatternLayoutProcessor' as a logback object.",
				this.reference.isLogbackObject(CallerNamePatternLayoutProcessor));
				
			Assert.assertFalse("Failed to recognize 'flash.display.Sprite' as NOT a logback object.",
				this.reference.isLogbackObject(Sprite));
		}
		
		private function getResultForPattern(pattern:String):String {
			this.layout.pattern = pattern;
			this.logger.debug("Hello World!");
			return this.appender.getLastMessage();
		}
	}
}
import ch.qos.logback.classic.entry.DefaultLoggerEntryFactory;
import ch.qos.logback.classic.format.DefaultMessageFormatter;
import ch.qos.logback.classic.layout.pattern.PatternLayoutProcessor;
import ch.qos.logback.core.AbstractLayoutAwareAppender;
import ch.qos.logback.core.AbstractLogger;
import ch.qos.logback.core.Appender;
import ch.qos.logback.core.Layout;
import ch.qos.logback.core.Level;
import ch.qos.logback.core.LoggerEntry;
import ch.qos.logback.core.layout.AbstractLayout;

import org.slf4fp.Logger;

class MockLogger extends AbstractLogger {
	
	public function MockLogger() {
		super("ch.qos.logback.test.MockLogger", new DefaultMessageFormatter(), null, Level.ALL,
			true, new DefaultLoggerEntryFactory());
	}
	
	override public function trace(message:String, ...arguments):Logger {
		doAppend(message, arguments, Level.TRACE);
		return this;
	}
	
	override public function debug(message:String, ...arguments):Logger {
		doAppend(message, arguments, Level.DEBUG);	
		return this;
	}
	
	override public function info(message:String, ...arguments):Logger {
		doAppend(message, arguments, Level.INFO);
		return this;
	}
	
	override public function warn(message:String, ...arguments):Logger {
		doAppend(message, arguments, Level.WARN);
		return this;
	}
	
	override public function error(message:String, ...arguments):Logger {
		doAppend(message, arguments, Level.ERROR);
		return this;
	}
	
	private function doAppend(message:String, args:Array, level:Level):void {
		for each (var appender:Appender in this.appenders.toArray()) {
			appender.append(loggerEntryFactory.create(name, new Date(), level, 
				message, new Vector.<Object>().concat.apply(this, args), messageFormatter.format(message, args)));
		}
	}
}

class MockAppender extends AbstractLayoutAwareAppender {
	
	private var lastMessage:String;
	
	public function MockAppender(layout:Layout) {
		super("mockAppender");
		this.layout = layout;
	}
	
	override public function append(value:LoggerEntry):Appender {
		this.lastMessage = this.layout.apply(value);
		return this;
	}
	
	public function getLastMessage():String {
		return lastMessage;
	}
}

class MockLayout extends AbstractLayout {
	
	private var processor:PatternLayoutProcessor;
	
	private var _pattern:String;
	
	public function MockLayout(processor:PatternLayoutProcessor = null, pattern:String = null) {
		super("mockLayout");
		this.processor = processor;
		this.pattern = pattern;
	}
	
	override public function apply(entry:LoggerEntry):String {
		return this.processor.apply(pattern, entry);
	}
	
	public function get pattern():String { return _pattern; }
	public function set pattern(value:String):void { _pattern = value; }
}