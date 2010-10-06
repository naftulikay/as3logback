package ch.qos.logback.core {
	import ch.qos.logback.core.layout.DefaultLayout;
	
	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class SystemOutputAppender extends AbstractLayoutAwareAppender {
		
		public function SystemOutputAppender() {
			this.layout = new DefaultLayout();
		}
		
		override public function append(value:LoggerEntry) : Appender {
			trace(this.layout.apply(value));
			return this;
		}
	}
}
