package {
    import flash.display.Sprite;
    import flash.events.Event;    

    /**
     * @author user
     */
    public class Bomb extends Sprite {
        var g : int = 10;
        var posY : int;

        public function Bomb() {

            this.x = 5 * Cell.length + 2;
            this.y = 0;
            posY = 0;
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function enterFrameHandler(event : Event) : void {
            this.y += g;
            posY = Math.floor(this.y / Cell.length);
            if(this.y > 500 || Tetris.gameState == Tetris.PASSING) {
                destruct();
            }else if(posY < Arena.row && Tetris.arena.map[posY][5]) {
                Tetris.arena.map[posY][5].destruct();
                Tetris.arena.map[posY][5] = null;
                destruct();
            }
        }

        public function destruct() : void {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            parent.removeChild(this);
        }
    }
}
