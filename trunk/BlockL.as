package {
    import flash.geom.ColorTransform;
    import flash.geom.Point;        

    /**
     * @author user
     */
    public class BlockL extends Block {
        public function BlockL() {
            count = 4;
            super();
            map[0] = new Point();
            map[1] = new Point();
            map[2] = new Point();
            map[3] = new Point();
            for(var i : int = 0;i < 4;i++) {
                body[i] = new Cell();
                body[i].transform.colorTransform = new ColorTransform(5, 1, 5);
                body[i].index = "3";
                addChild(body[i]);
            }
            updateMap();
            updateBlock();
        }

        override public function updateMap() : void {
        	// update cell position
            if (direction == 0) {
                map[0].x = -1;
                map[0].y = -2;
                map[1].x = -1;
                map[1].y = -1;
                map[2].x = -1;
                map[2].y = 0;
                map[3].x = 0;
                map[3].y = 0;
                body[0].isTop = true;
                body[1].isTop = false;
                body[2].isTop = false;
                body[3].isTop = true;
            }
        	else if (direction == 1) {
                map[0].x = -1;
                map[0].y = -1;
                map[1].x = 0;
                map[1].y = -1;
                map[2].x = 1;
                map[2].y = -1;
                map[3].x = -1;
                map[3].y = 0;
                body[0].isTop = true;
                body[1].isTop = true;
                body[2].isTop = true;
                body[3].isTop = false;
            }
            else if (direction == 2) {
                map[0].x = -1;
                map[0].y = -1;
                map[1].x = 0;
                map[1].y = -1;
                map[2].x = 0;
                map[2].y = 0;
                map[3].x = 0;
                map[3].y = 1;
                body[0].isTop = true;
                body[1].isTop = true;
                body[2].isTop = false;
                body[3].isTop = false;
            }
            else if (direction == 3) {
                map[0].x = 0;
                map[0].y = -1;
                map[1].x = -2;
                map[1].y = 0;
                map[2].x = -1;
                map[2].y = 0;
                map[3].x = 0;
                map[3].y = 0;
                body[0].isTop = true;
                body[1].isTop = true;
                body[2].isTop = true;
                body[3].isTop = false;
            }
        }
    }
}
