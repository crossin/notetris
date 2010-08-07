package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;    

	/**
	 * @author user
	 */
	public class Pass extends Sprite {
		var btnStart : ButtonNext;

		public function Pass() {
			btnStart = new ButtonNext();
			btnStart.x = btnStart.y = 300;
			addChild(btnStart);
			btnStart.addEventListener(MouseEvent.CLICK, nextClickHandler);
		}

		private function nextClickHandler(event : MouseEvent) : void {
			Tetris.gameState = Tetris.PLAYING;
			Tetris.arena.visible = true;
			this.visible = false;
			if (Tetris.gameLevel == Tetris.failedLevel || Tetris.gameLevel == Tetris.maxLevel) {
				Tetris.failedLevel = (Tetris.gameLevel == Tetris.failedLevel) ? Tetris.maxLevel : Tetris.failedLevel;
				Tetris.maxLevel++;
				Tetris.savedData.data["max"] = Tetris.maxLevel;
				Tetris.savedData.data["failed"] = Tetris.failedLevel;
				Tetris.savedData.flush();
			}
			Tetris.gameLevel++;
			Tetris.arena["level"].text = Tetris.gameLevel.toString();
            
			Tetris.arena.clear();
			Tetris.arena.init();
		}
	}
}
