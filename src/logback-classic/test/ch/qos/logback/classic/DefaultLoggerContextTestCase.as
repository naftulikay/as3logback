package ch.qos.logback.classic {
	import org.flexunit.Assert;
	/**
	 * @author rfkrocktk
	 */
	public class DefaultLoggerContextTestCase {
		
		private var reference:DefaultLoggerContext;
		
		[Before]
		public function setup():void {
			this.reference = new DefaultLoggerContext();
		}
		
		[Test]
		[Ignore]
		public function test$constructor():void {
			Assert.fail("Not yet implemented.");	
		}
		
		[Test]
		[Ignore]
		public function testHasLogger():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testCreateLogger():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testGetLogger():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testGetLoggers():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testSetLoggers():void {
			Assert.fail("Not yet implemented.");
		}
	}
}
