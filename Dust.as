package {
    import flash.display.MovieClip;

    /**
     * @author user
     */
    public class Dust extends MovieClip {
        public function Dust(x : int,y : int) {
            this.x = (x + Math.random()) * Cell.length;
            this.y = y * Cell.length;
            this.rotation = (Math.random() - 0.5) * 60;
            this.scaleY = this.scaleX = 1 + Math.random() * 0.2;
            gotoAndPlay(Math.ceil(Math.random() * 10));
        }
    }
}
