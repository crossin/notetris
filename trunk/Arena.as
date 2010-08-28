package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;    

	/**
	 * @author user
	 */
	public class Arena extends Sprite {
		static var col : int = 10;
		static var row : int = 18;
		static var startX : int = 50;
		static var startY : int = 30;
		static var g : int = 5;
		static var v : int = 15;
		static var posNext : Point = new Point(256, 54);
		//        static var posHold : Point = new Point(320, 0);

		var map : Array;
		var mapTag : Array;
		var big : CellBig;

		public function Arena() {
			this.x = startX;
			this.y = startY;
			map = new Array(row);
			for (var i : int = 0;i < row;i++) {
				map[i] = new Array(col);
			}
			mapTag = new Array(row);
			for (i = 0;i < row;i++) {
				mapTag[i] = new Array(col);
			}
            
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            

            //////////////////////////////////////////////////////////////////////
            // test
            //////////////////////////////////////////////////////////////////////
//            for (var r : int = 0;r < row;r++) {
//                for (var c : int = 0;c < col;c++) {
//                    if(!map[r][c]) {
//                        //this.graphics.beginFill(0xFFCC00);
//                        //this.graphics.lineStyle(2, 0x990000, .75);
//                        //this.graphics.drawRect(c * Cell.length, r * Cell.length, Cell.length, Cell.length);
//                    }
//                }
//            }
		}

		
		private function enterFrameHandler(event : Event) : void {
			if(Tetris.gameState == Tetris.PLAYING) {
				for (var r : int = 0;r < row;r++) {
					for (var c : int = 0;c < col;c++) {
						if(map[r][c] && map[r][c].isDrop) {
							map[r][c].y += g;
							if(map[r][c].y >= r * Cell.length) {
								map[r][c].y = r * Cell.length;
								map[r][c].isDrop = false;
								// dust effect
								if(map[r][c].isBottom && (r + 1 == Arena.row || map[r + 1][c])) {
									for(var j : int = 0;j < 10;j++) {
										addChild(new Dust(c, r));
									}
									map[r][c].isBottom = false;
								}
                                
                                
								if(Tetris.gameLevel == 2) {
									// for level 2
									check();
								}
                                else if(Tetris.gameLevel == 4) {
									// for level 4
									checkColor();
								}
							}
						}
					}
				}
//                // hold effect
//                if(Tetris.blockHold.isHold) {
//                    Tetris.blockHold.x += v;
//                    Tetris.blockNext.x -= v;
//                    if(Tetris.blockNext.x <= posNext.x) {
//                        Tetris.blockHold.isHold = false;
//                        Tetris.blockHold.x = posHold.x;
//                        Tetris.blockHold.y = posHold.y;
//                        Tetris.blockHold.scaleY = Tetris.blockHold.scaleX = 0.5;
//                        Tetris.blockNext.x = posNext.x;
//                        Tetris.blockNext.y = posNext.y;
//                        Tetris.blockNext.scaleY = Tetris.blockNext.scaleX = 1;
//                    }
//                }
			}
		}

		public function init() : void {
			if (Tetris.gameLevel == 9) {
				// for level 9
				Tetris.blockNext = new BlockI();
			} else {
				switch(Math.floor(Math.random() * 7)) {
					case 0:
						Tetris.blockNext = new BlockI();
						break;
					case 1:
						Tetris.blockNext = new BlockJ();
						break;
					case 2:
						Tetris.blockNext = new BlockL();
						break;
					case 3:
						Tetris.blockNext = new BlockO();
						break;
					case 4:
						Tetris.blockNext = new BlockS();
						break;
					case 5:
						Tetris.blockNext = new BlockT();
						break;
					case 6:
						Tetris.blockNext = new BlockZ();
						break;
					default:
						Tetris.blockNext = new BlockT();
						break;
				}
			}
			Tetris.blockNext.x = posNext.x;
			Tetris.blockNext.y = posNext.y;
			addChild(Tetris.blockNext);
			//            switch(Math.floor(Math.random() * 7)) {
			//                case 0:
			//                    Tetris.blockHold = new BlockI();
			//                    break;
			//                case 1:
			//                    Tetris.blockHold = new BlockJ();
			//                    break;
			//                case 2:
			//                    Tetris.blockHold = new BlockL();
			//                    break;
			//                case 3:
			//                    Tetris.blockHold = new BlockO();
			//                    break;
			//                case 4:
			//                    Tetris.blockHold = new BlockS();
			//                    break;
			//                case 5:
			//                    Tetris.blockHold = new BlockT();
			//                    break;
			//                case 6:
			//                    Tetris.blockHold = new BlockZ();
			//                    break;
			//                default:
			//                    Tetris.blockHold = new BlockT();
			//                    break;
			//            }
			//            Tetris.blockHold.x = posHold.x;
			//            Tetris.blockHold.y = posHold.y;
			//            Tetris.blockHold.scaleY = Tetris.blockHold.scaleX = 0.5;
			//            addChild(Tetris.blockHold);
			next();
            
			// init level
			map[row - 1][5] = new CellStar();
			map[row - 1][5].setPos(5 * Cell.length, (row - 1) * Cell.length);
			addChild(map[row - 1][5]);
            
			if (Tetris.gameLevel == 1) {
				// for level 1
				map[row - 1][3] = new Cell();
				map[row - 1][3].transform.colorTransform = new ColorTransform(5, 5, 5);
				map[row - 1][3].setPos(3 * Cell.length, (row - 1) * Cell.length);
				addChild(map[row - 1][3]);
                
				map[row - 1][7] = new Cell();
				map[row - 1][7].transform.colorTransform = new ColorTransform(5, 5, 5);
				map[row - 1][7].setPos(7 * Cell.length, (row - 1) * Cell.length);
				addChild(map[row - 1][7]);
                
				//                map[row - 2][4] = new Cell();
				//                map[row - 2][4].transform.colorTransform = new ColorTransform(5, 5, 5);
				//                map[row - 2][4].setPos(4 * Cell.length, (row - 2) * Cell.length);
				//                addChild(map[row - 2][4]);
				//                
				//                map[row - 2][6] = new Cell();
				//                map[row - 2][6].transform.colorTransform = new ColorTransform(5, 5, 5);
				//                map[row - 2][6].setPos(6 * Cell.length, (row - 2) * Cell.length);
				//                addChild(map[row - 2][6]);

				desc.text = "有什么不同？这不就是一般的俄罗斯方块吗？";
			}
            else if (Tetris.gameLevel == 2) {
				// for level 2
				map[row - 1][4] = new CellRock();
				map[row - 1][4].setPos(4 * Cell.length, (row - 1) * Cell.length);
				addChild(map[row - 1][4]);
                
				desc.text = "怎么有个球堵在那里！";
			}
            else if (Tetris.gameLevel == 3) {
				// for level 3
				desc.text = "小心暗器！";
			}
            else if (Tetris.gameLevel == 4) {
				// for level 4
				map[row - 1][5].transform.colorTransform = new ColorTransform(1, 5, 5);
				map[row - 1][5].gotoAndStop(2);
                
				map[row - 1][4] = new Cell();
				map[row - 1][4].transform.colorTransform = new ColorTransform(1, 5, 1);
				map[row - 1][4].setPos(4 * Cell.length, (row - 1) * Cell.length);
				map[row - 1][4].index = "4";
				addChild(map[row - 1][4]);
                
				map[row - 1][6] = new Cell();
				map[row - 1][6].transform.colorTransform = new ColorTransform(5, 1, 1);
				map[row - 1][6].setPos(6 * Cell.length, (row - 1) * Cell.length);
				map[row - 1][6].index = "1";
				addChild(map[row - 1][6]);
                
				map[row - 2][5] = new Cell();
				map[row - 2][5].transform.colorTransform = new ColorTransform(5, 3, 1);
				map[row - 2][5].setPos(5 * Cell.length, (row - 2) * Cell.length);
				map[row - 2][5].index = "5";
				addChild(map[row - 2][5]);
                
				map[row - 2][4] = new Cell();
				map[row - 2][4].transform.colorTransform = new ColorTransform(5, 1, 5);
				map[row - 2][4].setPos(4 * Cell.length, (row - 2) * Cell.length);
				map[row - 2][4].index = "3";
				addChild(map[row - 2][4]);
                
				map[row - 2][6] = new Cell();
				map[row - 2][6].transform.colorTransform = new ColorTransform(5, 5, 1);
				map[row - 2][6].setPos(6 * Cell.length, (row - 2) * Cell.length);
				map[row - 2][6].index = "2";
				addChild(map[row - 2][6]);
                
				desc.text = "这难道是魔法方块吗……";
			}
            else if (Tetris.gameLevel == 5) {
				// for level 5
				this.graphics.lineStyle(4, 0xff9999, 0.5);
				this.graphics.moveTo(0, 8 * Cell.length + 2);
				this.graphics.lineTo(col * Cell.length, 8 * Cell.length + 2);
                
				map[row - 2][4] = new Cell();
				map[row - 2][4].transform.colorTransform = new ColorTransform(5, 5, 5);
				map[row - 2][4].setPos(4 * Cell.length, (row - 2) * Cell.length);
				addChild(map[row - 2][4]);
                
				map[row - 2][6] = new Cell();
				map[row - 2][6].transform.colorTransform = new ColorTransform(5, 5, 5);
				map[row - 2][6].setPos(6 * Cell.length, (row - 2) * Cell.length);
				addChild(map[row - 2][6]);
                
				map[row - 3][5] = new Cell();
				map[row - 3][5].transform.colorTransform = new ColorTransform(5, 5, 5);
				map[row - 3][5].setPos(5 * Cell.length, (row - 3) * Cell.length);
				addChild(map[row - 3][5]);
                
				desc.text = "换个角度看问题。";
			}
            else if (Tetris.gameLevel == 6) {
				// for level 6
				this.graphics.lineStyle(4, 0xffffff);
				this.graphics.moveTo(0, 10 * Cell.length + 2);
				this.graphics.lineTo(5 * Cell.length - 2, 10 * Cell.length + 2);
				this.graphics.moveTo(6 * Cell.length + 2, 10 * Cell.length + 2);
				this.graphics.lineTo(col * Cell.length, 10 * Cell.length + 2);
                
				desc.text = "俄罗斯方块也是很需要微操的。";
			}
            else if (Tetris.gameLevel == 7) {
				// for level 7
				desc.text = "刚才的方块到哪里去了？！！";
			}
            else if (Tetris.gameLevel == 8) {
				// for level 8
				this.graphics.lineStyle(4, 0xffffff);
				this.graphics.moveTo(0, 10 * Cell.length + 2);
				this.graphics.lineTo(col * Cell.length, 10 * Cell.length + 2);
                
				desc.text = "此路不通！";
			}
            else if (Tetris.gameLevel == 9) {
				// for level 9
				for (var r : int = row - 4;r < row;r++) {
					for (var c : int = 0;c < col;c++) {
						if(c != 4 && !(c == 5 && r == row - 4) && !map[r][c]) {
							map[r][c] = new Cell();
							map[r][c].transform.colorTransform = new ColorTransform(5, 5, 5);
							map[r][c].setPos(c * Cell.length, r * Cell.length);
							addChild(map[r][c]);
						}
					}
				}
                
				big = new CellBig();
				addChild(big);
                
				desc.text = "塞不进去-_-|||";
			}
            
			// add tips
			Tetris.info["cover"].mat.graphics.clear();
			switch (Tetris.gameLevel) {
				case 1:
					Tetris.info["txtTip"].text = "第1关：没什么好提示的，和普通的俄罗斯方块一样。快去消掉带星方块吧！";
					break;
				case 2:
					Tetris.info["txtTip"].text = "第2关：再坚硬的球，也经不住重压。";
					break;
				case 3:
					Tetris.info["txtTip"].text = "第3关：保护工作自始至终都要做好哦~";
					break;
				case 4:
					Tetris.info["txtTip"].text = "第4关：一条直线上，连续四个或更多的同色方块将被消去。";
					break;
				case 5:
					Tetris.info["txtTip"].text = "第5关：不要再定势思维了，谁说俄罗斯方块一定要横着消？";
					break;
				case 6:
					Tetris.info["txtTip"].text = "第6关：利用旋转穿过阻挡的障碍。不过，不是所有方块都能完成这种高难动作的。";
					break;
				case 7:
					Tetris.info["txtTip"].text = "第7关：学会舍弃，只选择最需要的方块。没什么比Z字形更好用的了。";
					break;
				case 8:
					Tetris.info["txtTip"].text = "第8关：敲了敲四周墙壁，好像是空的！";
					break;
				case 9:
					Tetris.info["txtTip"].text = "第9关：真恨不得把那个挡道的家伙给拖走！";
					break;
			}
		}

		public function clear() : void {
			for (var r : int = 0;r < row;r++) {
				for (var c : int = 0;c < col;c++) {
					// clear
					if(map[r][c]) {
						map[r][c].destruct();
						map[r][c] = null;
					}
					Tetris.isPressDown = false;
				}
			}
			if(Tetris.block && Tetris.blockNext) {
				Tetris.block.destruct();
				Tetris.blockNext.destruct();
				Tetris.block = null;
				Tetris.blockNext = null;
			}
			if (Tetris.arena.big) {
				Tetris.arena.big.destruct();
				Tetris.arena.big = null;
			}
			this.graphics.clear();
		}

		public function next() : void {
			// give a next block after land
			if(Tetris.gameLevel == 4) {
				// for level 4
				checkColor();
			}else if(Tetris.gameLevel == 5) {
				// for level 5
				checkVertical();
			} else {
				check();
			}
			// put in map
			Tetris.block = Tetris.blockNext;
			Tetris.block.scaleY = Tetris.block.scaleX = 1;
			Tetris.block.init();
			// new block
			switch(Math.floor(Math.random() * 7)) {
				case 0:
					Tetris.blockNext = new BlockI();
					break;
				case 1:
					Tetris.blockNext = new BlockJ();
					break;
				case 2:
					Tetris.blockNext = new BlockL();
					break;
				case 3:
					Tetris.blockNext = new BlockO();
					break;
				case 4:
					Tetris.blockNext = new BlockS();
					break;
				case 5:
					Tetris.blockNext = new BlockT();
					break;
				case 6:
					Tetris.blockNext = new BlockZ();
					break;
				default:
					Tetris.blockNext = new BlockT();
					break;
			}
			Tetris.blockNext.x = posNext.x;
			Tetris.blockNext.y = posNext.y;
			addChild(Tetris.blockNext);
		}

		private function check() : void {
			// check if clear line needed
			for (var r : int = 0;r < row;r++) {
				for (var c : int = 0;c < col;c++) {
					if(!map[r][c]) {
						break;
					}
					// for level 2
					if(Tetris.gameLevel == 2 && map[r][c] is CellRock) {
						break;
					}
				}
				// full of a line
				if(c == col) {
					for (var c2 : int = 0;c2 < col;c2++) {
						// check star cell
						//						if (map[r][c2] is CellStar) {
						//							// pass
						//							if(Tetris.gameLevel == 9) {
						//								// for level 9
						//								big.destruct();
						//								big = null;
						//                                
						//								// game ending
						//								Tetris.gameState = Tetris.ENDING;
						//								Tetris.endAll.visible = true;
						//								Tetris.arena.visible = false;
						//							} else {
						//								Tetris.gameState = Tetris.PASSING;
						//								Tetris.pass.visible = true;
						//								Tetris.arena.visible = false;
						//							}
						//						}
						// clear the line
						map[r][c2].isOut = true;
						map[r][c2].g_x = (c2 / col - 0.5) * (1 + 2 * Math.random());
						map[r][c2].g_y = 6 + 2 * Math.random();
                        
						if(r > 0 && map[r - 1][c2]) {
							map[r - 1][c2].isBottom = true;
						}
					}

					for (var r2 : int = r;r2 > 0;r2--) {
						for ( c2 = 0;c2 < col;c2++) {
							map[r2][c2] = map[r2 - 1][c2];
							if(map[r2][c2]) {
								map[r2][c2].isDrop = true;
							}
						}
					}
				}
			}
		}

		private function checkColor() : void {
			// check if clear row needed
			for (var r : int = 0;r < row;r++) {
				for (var c : int = 0;c < col - 3;c++) {
					if(map[r][c] && sameColorRow(r, c)) {
						mapTag[r][c] = true;
						mapTag[r][c + 1] = true;
						mapTag[r][c + 2] = true;
						mapTag[r][c + 3] = true;
					}
				}
			}
			// check if clear col needed

			for (c = 0;c < col;c++) {
				for (r = 0;r < row - 3;r++) {
					if(map[r][c] && sameColorCol(r, c)) {
						mapTag[r][c] = true;
						mapTag[r + 1][c] = true;
						mapTag[r + 2][c] = true;
						mapTag[r + 3][c] = true;
					}
				}
			}
            
			// drop
			for (r = 0;r < row;r++) {
				for (c = 0;c < col;c++) {
					if(mapTag[r][c]) {
						//						// check star cell
						//						if (map[r][c] is CellStar) {
						//							// pass
						//							Tetris.gameState = Tetris.PASSING;
						//							Tetris.pass.visible = true;
						//							Tetris.arena.visible = false;
						//						}

						map[r][c].isOut = true;
						map[r][c].g_x = (c / col - 0.5) * (1 + 2 * Math.random());
						map[r][c].g_y = 6 + 2 * Math.random();
                        
						for (var r2 : int = r;r2 > 0;r2--) {
							map[r2][c] = map[r2 - 1][c];
							if(map[r2][c]) {
								map[r2][c].isDrop = true;
							}
						}
						mapTag[r][c] = null;
					}
				}
			}
		}

		private function sameColorRow(r : int,c : int) : Boolean {
			for(var i : int = 1;i < 4;i++) {
				if (!map[r][c + i]) {
					return false;
				}
				if (map[r][c].transform.colorTransform.redMultiplier != map[r][c + i].transform.colorTransform.redMultiplier) {
					return false;
				}
				if (map[r][c].transform.colorTransform.greenMultiplier != map[r][c + i].transform.colorTransform.greenMultiplier) {
					return false;
				}
				if (map[r][c].transform.colorTransform.blueMultiplier != map[r][c + i].transform.colorTransform.blueMultiplier) {
					return false;
				}
			}
			return true;
		}

		private function sameColorCol(r : int,c : int) : Boolean {
			for(var i : int = 1;i < 4;i++) {
				if (!map[r + i][c]) {
					return false;
				}
				if (map[r][c].transform.colorTransform.redMultiplier != map[r + i][c].transform.colorTransform.redMultiplier) {
					return false;
				}
				if (map[r][c].transform.colorTransform.greenMultiplier != map[r + i][c].transform.colorTransform.greenMultiplier) {
					return false;
				}
				if (map[r][c].transform.colorTransform.blueMultiplier != map[r + i][c].transform.colorTransform.blueMultiplier) {
					return false;
				}
			}
			return true;
		}

		private function checkVertical() : void {
			// check if clear line needed
			for (var c : int = 0;c < col;c++) {
				for (var r : int = row - 10;r < row;r++) {
					if(!map[r][c]) {
						break;
					}
				}
				// full of a line
				if(r == row) {
					// check star cell
					//					if (c == 5) {
					//						// pass
					//						Tetris.gameState = Tetris.PASSING;
					//						Tetris.pass.visible = true;
					//						Tetris.arena.visible = false;
					//					}
					for (var r2 : int = 0;r2 < row;r2++) {
						// clear the vertical line
						if (map[r2][c]) {
							map[r2][c].isOut = true;
							map[r2][c].g_x = (r2 / row - 0.5) * (1 + 2 * Math.random());
							map[r2][c].g_y = 6 + 2 * Math.random();
							map[r2][c] = null;
						}
					}
				}
			}
		}
//        public function hold() : void {
//            // hold a block
//            if (!Tetris.blockHold.isHold) {
//                var blockTemp : Block;
//                blockTemp = Tetris.blockHold;
//                Tetris.blockHold = Tetris.blockNext;
//                Tetris.blockNext = blockTemp;
//                Tetris.blockHold.isHold = true;
//            }
//        }
	}
}
