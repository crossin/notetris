package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;    

    /**
     * @author user
     */
    public class End extends Sprite {
//        var btnStart : ButtonRestart;

        public function End() {
//            btnStart = new ButtonRestart();
//            btnStart.x = 200;
//            btnStart.y = 250;
//            addChild(btnStart);
            addEventListener(MouseEvent.CLICK, restartClickHandler);
        }

        private function restartClickHandler(event : MouseEvent) : void {
            Tetris.gameState = Tetris.PLAYING;
            Tetris.arena.visible = true;
            this.visible = false;
            //Tetris.gameLevel = 1;
            //Tetris.arena.level.text = "1";
            
            Tetris.arena.clear();
            Tetris.arena.init();
        }
    }
}
