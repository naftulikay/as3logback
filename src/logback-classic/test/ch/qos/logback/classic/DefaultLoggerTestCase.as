package ch.qos.logback.classic {
	import org.flexunit.Assert;
	/**
	 * @author rfkrocktk
	 */
	public class DefaultLoggerTestCase {
		
		private var reference:DefaultLogger;
		
		[Before]
		public function setup():void {
			this.reference = new DefaultLogger();
		}
		
		[Test]
		[Ignore]
		public function test$constructor():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testTrace():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testDebug():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testInfo():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testWarn():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testError():void {
			Assert.fail("Not yet implemented.");
		}
		
		[Test]
		[Ignore]
		public function testAppend():void {
			Assert.fail("Not yet implemented.");
		}
	}
}
