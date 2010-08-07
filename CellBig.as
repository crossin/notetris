package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;    

    /**
     * @author user
     */
    public class CellBig extends Sprite {
        var moving : Boolean;

        public function CellBig() {
            this.x = 5 * Cell.length - 1;
            this.y = (Arena.row - 4) * Cell.length;
            moving = false;
            addEventListener(MouseEvent.MOUSE_DOWN, dragHandler);
            addEventListener(MouseEvent.MOUSE_UP, releaseHandler);
        }

        private function dragHandler(event : MouseEvent) : void {
            this.startDrag();
            moving = true;
        }

        private function releaseHandler(event : MouseEvent) : void {
            this.stopDrag();
            moving = false;
        }

        public function destruct() : void {
            removeEventListener(MouseEvent.MOUSE_DOWN, dragHandler);
            removeEventListener(MouseEvent.MOUSE_UP, releaseHandler);
            parent.removeChild(this);
        }
    }
}
