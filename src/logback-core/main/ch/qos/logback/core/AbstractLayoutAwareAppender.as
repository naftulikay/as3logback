package ch.qos.logback.core {

	/**
	 * @author TK Kocheran <a href="mailto:rfkrocktk@gmail.com">&lt;rfkrocktk@gmail.com&gt;</a>
	 */
	public class AbstractLayoutAwareAppender extends AbstractAppender implements LayoutAware {
		
		private var _layout:Layout;
		
		public function getLayout() : Layout {
			return _layout;
		}

		public function setLayout(value:Layout) : LayoutAware {
			this.layout = value;
			return this;
		}
		
		[Bindable]
		public function get layout() : Layout {
			return _layout;
		}

		public function set layout(value:Layout) : void {
			this._layout = value;
		}
	}
}
