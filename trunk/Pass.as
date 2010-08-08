package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;    

	/**
	 * @author user
	 */
	public class Pass extends Sprite {
		var btnStart : ButtonNext;

		public function Pass() {
			//			btnStart = new ButtonNext();
			//			btnStart.x = btnStart.y = 300;
			//			addChild(btnStart);
			addEventListener(MouseEvent.CLICK, nextClickHandler);
		}

		private function nextClickHandler(event : MouseEvent) : void {
			Tetris.arena.visible = true;
			this.visible = false;

			Tetris.gameLevel++;
			Tetris.arena["level"].text = Tetris.gameLevel.toString();

			Tetris.arena.init();
			Tetris.gameState = Tetris.PLAYING;
		}
	}
}