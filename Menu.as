package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;	

	/**
	 * @author user
	 */
	public class Menu extends Sprite {
		//var btnStart : ButtonStart;

		public function Menu() {
			//			btnStart = new ButtonStart();
			//			btnStart.x = 200;
			//			btnStart.y = 250;
			//			addChild(btnStart);

			
			addEventListener(MouseEvent.CLICK, startClickHandler);
		}

		private function startClickHandler(event : MouseEvent) : void {
			//Tetris.gameState = Tetris.PLAYING;
			//Tetris.arena.visible = true;
			this.visible = false;
			
			Tetris.index.refresh();
			Tetris.index.visible = true;
			//Tetris.index.init(2);
			//Tetris.arena.level.text = "1";
            
			//Tetris.arena.init();
		}
	}
}
