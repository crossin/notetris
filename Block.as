package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;    

    /**
     * @author user
     */
    public class Block extends Sprite {
        static var v : int = 10;
        static var w : int = 30;
        static var g : int = 10;
        static var speed : Number = 1;
        static var start_x : int = 5;
        static var start_y : int = 2;

        var arena : Arena;
        var map : Array;
        var body : Array;
        var direction : int;
        var count : int;
        var pos : Point;
        var isLeft : Boolean;
        var isRight : Boolean;
        var isDown : Boolean;
        var isRotate : Boolean;

        //        var isHold : Boolean;

        public function Block() {
            arena = Tetris.arena;
            body = new Array(count);
            map = new Array(count);
            pos = new Point(start_x, start_y);
            direction = Math.floor(Math.random() * 4);
            isLeft = false;
            isRight = false;
            isRotate = false;
            isDown = false;
//            isHold = false;
        }

        public function init() : void {
            this.x = pos.x * Cell.length;
            this.y = pos.y * Cell.length;
            
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function enterFrameHandler(event : Event) : void {
            if(Tetris.gameState == Tetris.PLAYING) {
                if (isLeft) {
                    this.x -= v;
                    if (this.x <= pos.x * Cell.length) {
                        this.x = pos.x * Cell.length;
                        isLeft = false;
                    }
                }
                if (isRight) {
                    this.x += v;
                    if (this.x >= pos.x * Cell.length) {
                        this.x = pos.x * Cell.length;
                        isRight = false;
                    }
                }
                if (isRotate) {
                    this.rotation += w;
                    if (this.rotation >= 90) {
                        isRotate = false;
                        updateBlock();
                    }
                }
                // drop
                if(isDown) {
                    this.y += g * Tetris.time_elapsed;
                } else {
                    this.y += speed * Tetris.time_elapsed;
                }
                if (this.y > pos.y * Cell.length) {
                    if(isLand()) {
                        // hit ground
                        Tetris.soundLand.play();
                        for (var i : int = 0;i < count;i++) {
                            body[i].setPos((pos.x + map[i].x) * Cell.length, (pos.y + map[i].y) * Cell.length);
                            body[i].gotoAndStop(0);
                            if(pos.y + map[i].y < Arena.row && pos.x + map[i].x < Arena.col ) {
                                arena.map[pos.y + map[i].y][pos.x + map[i].x] = body[i];
                                arena.addChild(body[i]);
                            } else {
                                body[i].destruct();
                            }
                            body[i] = null;
                            // dust effect
                            if(Tetris.gameLevel == 6) {
                                // for level 6
                                if(pos.y + map[i].y + 1 == 10 || pos.y + map[i].y + 1 == Arena.row || arena.map[pos.y + map[i].y + 1][pos.x + map[i].x]) {
                                    for(var j : int = 0;j < 10;j++) {
                                        arena.addChild(new Dust(pos.x + map[i].x, pos.y + map[i].y));
                                    }
                                }
                            }
                            else if(Tetris.gameLevel == 7) {
                                // for level 7
                                if(pos.y + map[i].y + 1 < Arena.row && arena.map[pos.y + map[i].y + 1][pos.x + map[i].x]) {
                                    for(j = 0;j < 10;j++) {
                                        arena.addChild(new Dust(pos.x + map[i].x, pos.y + map[i].y));
                                    }
                                }
                            }
                            else if(Tetris.gameLevel == 8) {
                                // for level 8
                                if(pos.x + map[i].x < Arena.col && (pos.y + map[i].y + 1 == Arena.row || arena.map[pos.y + map[i].y + 1][pos.x + map[i].x])) {
                                    for(j = 0;j < 10;j++) {
                                        arena.addChild(new Dust(pos.x + map[i].x, pos.y + map[i].y));
                                    }
                                }
                            }
                            else if(pos.y + map[i].y + 1 == Arena.row || arena.map[pos.y + map[i].y + 1][pos.x + map[i].x]) {
                                for(j = 0;j < 10;j++) {
                                    arena.addChild(new Dust(pos.x + map[i].x, pos.y + map[i].y));
                                }
                            }
                        }                
                        // clear this block
                        destruct();
                        arena.next();
                        
                        
                        if (Tetris.gameLevel == 2) {
                            // for level 2
                            if(arena.map[Arena.row - 1][4] is CellRock) {
                                for (i = 1;i < Arena.row;i++) {
                                    if (!arena.map[Arena.row - 1 - i][4]) {
                                        break;
                                    }
                                }
                                if (i <= 10) {
                                    arena.map[Arena.row - 1][4].gotoAndStop(i);
                                } else {
                                    arena.map[Arena.row - 1][4].destruct();
                                    arena.map[Arena.row - 1][4] = null;
                                    for ( j = Arena.row - 1;j > 0;j--) {
                                        arena.map[j][4] = arena.map[j - 1][4];
                                        if(arena.map[j][4]) {
                                            arena.map[j][4].isDrop = true;
                                        }
                                    }
                                    arena.map[Arena.row - 1][4].isBottom = true;
                                }
                            }
                        }
                        else if (Tetris.gameLevel == 3) {
                            // for level 3 , drop a bomb
                            var bomb : Bomb = new Bomb();
                            arena.addChild(bomb);
                            bomb = null;
                        }
                    } else {
                        ++pos.y;
                    }
                }
                
                // for level 7 & 8
                if ((Tetris.gameLevel == 7 || Tetris.gameLevel == 8) && this.y > Arena.startY + Arena.row * Cell.length) {
                    destruct();
                    arena.next();
                }
            }
        }

        private function isLand() : Boolean {
            // check if hit ground
            for (var i : int = 0;i < count;i++) {
                if(Tetris.gameLevel == 6) {
                    // for level 6
                    if((pos.y + map[i].y + 1 == 10 && pos.x + map[i].x != 5) || pos.y + map[i].y + 1 >= Arena.row || arena.map[pos.y + map[i].y + 1][pos.x + map[i].x]) {
                        // check end
                        if(pos.y == start_y) {
                            Tetris.gameState = Tetris.ENDING;
                            Tetris.end.visible = true;
                            Tetris.arena.visible = false;
                            return false;
                        }
                        return true;
                    }
                }
                else if(Tetris.gameLevel == 7) {
                    // for level 7
                    if (pos.y + map[i].y + 1 < Arena.row && arena.map[pos.y + map[i].y + 1][pos.x + map[i].x]) {
                        // check end
                        if(pos.y == start_y) {
                            Tetris.gameState = Tetris.ENDING;
                            Tetris.end.visible = true;
                            Tetris.arena.visible = false;
                            return false;
                        }
                        return true;
                    }
                }
                else if(Tetris.gameLevel == 8) {
                    // for level 8
                    if(pos.x + map[i].x < Arena.col && (pos.y + map[i].y + 1 == 10 || pos.y + map[i].y + 1 >= Arena.row || arena.map[pos.y + map[i].y + 1][pos.x + map[i].x] )) {
                        // check end
                        if(pos.y == start_y) {
                            Tetris.gameState = Tetris.ENDING;
                            Tetris.end.visible = true;
                            Tetris.arena.visible = false;
                            return false;
                        }
                        return true;
                    }
                }
                else if(pos.y + map[i].y + 1 >= Arena.row || arena.map[pos.y + map[i].y + 1][pos.x + map[i].x]) {
                    // check end
                    if(pos.y == start_y) {
                        if(Tetris.gameLevel == 9) {
                            // for level 9
                            Tetris.arena.big.destruct();
                            Tetris.arena.big = null;
                        }
                        Tetris.gameState = Tetris.ENDING;
                        Tetris.end.visible = true;
                        Tetris.arena.visible = false;
                        return false;
                    }
                    return true;
                }
                
                
                // for level 9
                if(Tetris.gameLevel == 9 && Tetris.arena.big && !Tetris.arena.big.moving && hitTestObject(Tetris.arena.big)) {
                    return true;
                }
            }
            return false;
        }

        private function isHit() : Boolean {
            // check if hit cells
            for (var i : int = 0;i < count;i++) {
                if(Tetris.gameLevel == 8) {
                    if((pos.x + map[i].x == Arena.col - 1 && pos.y + map[i].y == 10) || pos.x + map[i].x < 0 || (pos.x + map[i].x >= Arena.col && pos.y + map[i].y < 6) || pos.y + map[i].y >= Arena.row || pos.y + map[i].y < 0 || (pos.x + map[i].x < Arena.col && arena.map[pos.y + map[i].y][pos.x + map[i].x])) {
                        // for level 
                        return true;
                    }
                }
                else if(pos.x + map[i].x < 0 || pos.x + map[i].x >= Arena.col || pos.y + map[i].y >= Arena.row || pos.y + map[i].y < 0 || arena.map[pos.y + map[i].y][pos.x + map[i].x]) {
                    return true;
                }
                
                if(Tetris.gameLevel == 6 && pos.y + map[i].y == 9 && (pos.x + map[i].x == 4 || pos.x + map[i].x == 6)) {
                    // for level 6
                    return true;
                }
            }

            return false;
        }

        public function moveLeft() : void {
            if(!isLeft && !isRight) {
                --pos.x;
                if(!isHit()) {
                    if(this.y % Cell.length > Cell.length * 2 / 3) {
                        isLeft = true;
                    } else {
                        // check higher hit
                        --pos.y;
                        if(!isHit()) {
                            isLeft = true;
                        } else {
                            ++pos.x;
                        }
                        ++pos.y;
                    }
                } else {
                    ++pos.x;
                }
            }
        }

        public function moveRight() : void {
            if(!isLeft && !isRight) {
                ++pos.x;
                if(!isHit()) {
                    if(this.y % Cell.length > Cell.length * 2 / 3) {
                        isRight = true;
                    } else {
                        // check higher hit
                        --pos.y;
                        if(!isHit()) {
                            isRight = true;
                        } else {
                            --pos.x;
                        }
                        ++pos.y;
                    }
                } else {
                    --pos.x;
                }
            }
        }

        public function moveDown() : void {
            isDown = true;
            for(var i : int = 0;i < 4;i++) {
                if(body[i].isTop) {
                    body[i].play();
                }
            }
        }

        public function stopDown() : void {
            isDown = false;
            for(var i : int = 0;i < 4;i++) {
                body[i].gotoAndStop(0);
            }
        }

        public function rotate() : void {
            if(!isRotate) {
                direction = (direction + 1) % 4;
                updateMap();
                if(!isHit()) {
                    isRotate = true;
                    Tetris.soundRotate.play();
                } else {
                    // slide to rotate
                    // slide left
                    --pos.x;
                    if(!isHit()) {
                        isRotate = true;
                        this.x = pos.x * Cell.length;
                        Tetris.soundRotate.play();
                    } else {
                        // slide right
                        pos.x += 2;
                        if(!isHit()) {
                            isRotate = true;
                            this.x = pos.x * Cell.length;
                            Tetris.soundRotate.play();
                        } else {
                            // slide left left
                            pos.x -= 3;
                            if(!isHit()) {
                                isRotate = true;
                                this.x = pos.x * Cell.length;
                                Tetris.soundRotate.play();
                            } else {
                                // slide right right
                                pos.x += 4;
                                if(!isHit()) {
                                    isRotate = true;
                                    this.x = pos.x * Cell.length;
                                    Tetris.soundRotate.play();
                                } else {
                                    pos.x -= 2;
                                    direction = (direction + 3) % 4;
                                    updateMap();
                                }
                            }
                        }
                    }
                }
            }
        }

        public function updateBlock() : void {
            // update cell's position
            this.rotation = 0;
            for(var i : int = 0;i < 4;i++) {
                body[i].setPos(map[i].x * Cell.length, map[i].y * Cell.length);
            }
        }

        public function updateMap() : void {
        	//abstract
        	// update cell's map
        }

        public function destruct() : void {
            // clear this block
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            arena.removeChild(this);
        }

        //////////////////////////////////////////////////////////////////////
        // test
        //////////////////////////////////////////////////////////////////////
//        public function test() : void {
//            trace(pos.y);
//            trace(direction);	
//            for (var i : int = 0;i < count;i++) {
//
//                (Arena)(this.parent).graphics.beginFill(0xFFCC00);
//                //this.graphics.lineStyle(2, 0x990000, .75);
//                (Arena)(this.parent).graphics.drawRect((map[i].x + pos.x) * Cell.length, (map[i].y + pos.y) * Cell.length, Cell.length, Cell.length);
//            }
//        }
    }
}
