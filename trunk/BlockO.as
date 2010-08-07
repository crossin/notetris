package {
    import flash.geom.ColorTransform;
    import flash.geom.Point;        

    /**
     * @author user
     */
    public class BlockO extends Block {
        public function BlockO() {
            count = 4;
            super();
            map[0] = new Point();
            map[1] = new Point();
            map[2] = new Point();
            map[3] = new Point();
            for(var i : int = 0;i < 4;i++) {
                body[i] = new Cell();
                body[i].transform.colorTransform = new ColorTransform(1, 5, 5);
                body[i].index = "0";
                addChild(body[i]);
            }
            updateMap();
            updateBlock();
        }

        override public function updateMap() : void {
            // update cell position
            map[0].x = -1;
            map[0].y = -1;
            map[1].x = 0;
            map[1].y = -1;
            map[2].x = -1;
            map[2].y = 0;
            map[3].x = 0;
            map[3].y = 0;
            body[0].isTop = true;
            body[1].isTop = true;
            body[2].isTop = false;
            body[3].isTop = false;
        }
    }
}
