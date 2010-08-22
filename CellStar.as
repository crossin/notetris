package {
	import flash.events.Event;
	import flash.geom.ColorTransform;		

	/**
	 * @author user
	 */
	public class CellStar extends Cell {
		var tick : int;

		public function CellStar() {
			super();
			tick = 0;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		function enterFrameHandler(event : Event) : void {
			// change color
			if (currentFrame == 1) {
				if (tick < 10) {
					transform.colorTransform = new ColorTransform(5, 1, 1);
				} else if (tick < 20) {
					transform.colorTransform = new ColorTransform(5, 5, 1);
				} else if (tick < 30) {
					transform.colorTransform = new ColorTransform(5, 1, 5);
				} else if (tick < 40) {
					transform.colorTransform = new ColorTransform(1, 5, 5);
				} else if (tick < 50) {
					transform.colorTransform = new ColorTransform(1, 5, 1);
				} else if (tick < 60) {
					transform.colorTransform = new ColorTransform(5, 3, 1);
				} else if (tick < 70) {
					transform.colorTransform = new ColorTransform(1, 1, 5);
				} else {
					tick = 0;
				}
				tick++;
			}
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