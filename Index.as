package {
	import flash.display.Sprite;	

	/**
	 * @author user
	 */
	public class Index extends Sprite {
		//var btnStart : ButtonStart;
		var btnLevel : Array;

		public function Index() {
			//			btnStart = new ButtonStart();
			//			btnStart.x = 200;
			//			btnStart.y = 250;
			//			addChild(btnStart);
			btnLevel = new Array(9);


			for (var i : int = 0;i < 9;i++) {
				btnLevel[i] = new BtnLevel(i + 1);
				btnLevel[i].x = 180 + i % 3 * 70;
				btnLevel[i].y = 100 + int(i / 3) * 50;
				addChild(btnLevel[i]);
			}

			//addEventListener(MouseEvent.CLICK, startClickHandler);
			//addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		public function refresh() : void {
			for (var i : int = 0;i < 9;i++) {
				btnLevel[i].lock.visible = false;
				btnLevel[i].pass.visible = false;
				btnLevel[i].buttonMode = true;
				if (i + 1 < Tetris.maxLevel && i + 1 != Tetris.failedLevel) {
					btnLevel[i].pass.visible = true;
				} else if (i + 1 > Tetris.maxLevel) {
					btnLevel[i].lock.visible = true;
					btnLevel[i].buttonMode = false;
				}
				
			}
		}
		
//		private function startClickHandler(event : MouseEvent) : void {
//			Tetris.gameState = Tetris.PLAYING;
//			Tetris.arena.visible = true;
//			this.visible = false;
//			Tetris.arena.level.text = "1";
//            
//			Tetris.arena.init();
//		}
	}
}
