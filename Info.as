package {
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.MouseEvent;	

	/**
	 * @author user
	 */
	public class Info extends Sprite {
		var drawing : Boolean = false;

		public function Info() {
			this["back"].buttonMode = true;
			this["back"].addEventListener(MouseEvent.CLICK, clickBack);
			
			this["cover"].mat = new Sprite();
			this["cover"].addChild(this["cover"].mat);
			this["cover"].blendMode = BlendMode.LAYER;
			this["cover"].mat.blendMode = BlendMode.ERASE;
			//this["cover"].mat.graphics.moveTo(this.mouseX, this.mouseY);
			this["cover"].addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}

		private function onMove(event : MouseEvent) : void {
			if (drawing) {
				this["cover"].mat.graphics.beginFill(0xFFFFFF);
				this["cover"].mat.graphics.lineStyle(4, 0xFFFFFF);
				this["cover"].mat.graphics.lineTo(event.localX, event.localY);
				this["cover"].mat.graphics.moveTo(event.localX, event.localY);
				this["cover"].mat.graphics.endFill();
			} else {
				drawing = true;
				this["cover"].mat.graphics.moveTo(event.localX, event.localY);
			}
		}

		private function clickBack(event : MouseEvent) : void {
			drawing = false;
			Tetris.gameState = Tetris.WAITING;
			Tetris.pause.visible = true;
			Tetris.info.visible = false;
		}
	}
}
