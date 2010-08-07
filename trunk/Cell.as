package {
    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * @author user
     */
    public class Cell extends MovieClip {
        static var length : int = 20;

        var isDrop : Boolean;
        var isTop : Boolean;
        var isBottom : Boolean;
        var isOut : Boolean;
        var g_x : Number;
        var g_y : int;
        var index : String;

        public function Cell() {
            isDrop = false;
            isTop = false;
            isBottom = false;            isOut = false;
            index = "";
            
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function enterFrameHandler(event : Event) : void {
            if(Tetris.gameLevel == 4 && num) {
                num.text = index;
            }
            if(isOut) {
                this.x += g_x;
                this.y += g_y;
                if(this.y > 500 || Tetris.gameState == Tetris.PASSING) {
                    destruct();
                }
            }
        }

        public function setPos(x : int,y : int) : void {
            this.x = x;
            this.y = y;
        }

        public function destruct() : void {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            parent.removeChild(this);
        }
    }
}
