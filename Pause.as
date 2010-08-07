package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;			

	/**
	 * @author user
	 */
	public class Pause extends Sprite {

		public function Pause() {
			this["retry"].buttonMode = true;			this["tip"].buttonMode = true;			this["select"].buttonMode = true;			this["goon"].buttonMode = true;


			this["retry"].addEventListener(MouseEvent.CLICK, clickRetry);			this["tip"].addEventListener(MouseEvent.CLICK, clickTip);			this["select"].addEventListener(MouseEvent.CLICK, clickSelect);
			this["goon"].addEventListener(MouseEvent.CLICK, clickGoon);
		}

		private function clickTip(event : MouseEvent) : void {
			Tetris.gameState = Tetris.HINTING;
			Tetris.info.visible = true;
			this.visible = false;
		}

		private function clickRetry(event : MouseEvent) : void {
			Tetris.gameState = Tetris.PLAYING;
			Tetris.arena.visible = true;
			this.visible = false;			
			Tetris.arena.clear();
			Tetris.arena.init();
		}

		private function clickSelect(event : MouseEvent) : void {
			Tetris.gameState = Tetris.STARTING;
			Tetris.index.refresh();
			Tetris.index.visible = true;
			this.visible = false;
			Tetris.arena.clear();
		}

		private function clickGoon(event : MouseEvent) : void {
			Tetris.gameState = Tetris.PLAYING;
			Tetris.arena.visible = true;
			this.visible = false;
		}
	}
}
