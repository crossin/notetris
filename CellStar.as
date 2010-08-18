package {
	import flash.events.Event;	

	/**
	 * @author user
	 */
	public class CellStar extends Cell {
		public function CellStar() {
			super();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		function enterFrameHandler(event : Event) : void {
			//check end
			if (this.y > 480) {
				// pass
				Tetris.arena.clear();
				if (Tetris.gameLevel == Tetris.failedLevel || Tetris.gameLevel == Tetris.maxLevel) {
					Tetris.failedLevel = (Tetris.gameLevel == Tetris.failedLevel) ? Tetris.maxLevel : Tetris.failedLevel;
					Tetris.maxLevel++;
					Tetris.savedData.data["max"] = Tetris.maxLevel;
					Tetris.savedData.data["failed"] = Tetris.failedLevel;
					Tetris.savedData.flush();
				}
				if(Tetris.gameLevel == 9) {
//					// for level 9
//					Tetris.arena.big.destruct();
//					Tetris.arena.big = null;
                                
					// game ending
					Tetris.gameState = Tetris.ENDING;
					Tetris.endAll.visible = true;
					Tetris.arena.visible = false;
				} else {
					Tetris.gameState = Tetris.PASSING;
					Tetris.pass.visible = true;
					Tetris.arena.visible = false;
				}
				destruct();
			}
		}

		override public function destruct() : void {
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			super.destruct();
		}
	}
}