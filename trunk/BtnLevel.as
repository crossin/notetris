package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;	

	/**
	 * @author user
	 */
	public class BtnLevel extends Sprite {
		var level : int;

		public function BtnLevel(i : int) {
			//trace(this["txtLevel"])
			//			btnStart = new ButtonStart();
			//			btnStart.x = 200;
			//			btnStart.y = 250;
			//			addChild(btnStart);
			buttonMode = true;
			mouseChildren = false;
			level = i;
			this["txtLevel"].text = i;
			
			addEventListener(MouseEvent.CLICK, startClickHandler);
		}

		private function startClickHandler(event : MouseEvent) : void {
			if (level <= Tetris.maxLevel) {
				Tetris.gameState = Tetris.PLAYING;
				Tetris.arena.visible = true;
				Tetris.gameLevel = level;
				Tetris.arena["level"].text = level;
			
				Tetris.index.visible = false;

				Tetris.arena.init();
			}
		}
	}
}
