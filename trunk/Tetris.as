package {
	import Arena;
	import Block;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.net.SharedObject;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;	

	/**
	 * @author user
	 */
	public class Tetris extends Sprite {
		static const PLAYING : int = 1;
		static const STARTING : int = 2;
		static const ENDING : int = 3;
		static const PASSING : int = 4;
		static const WAITING : int = 5;
		static const HINTING : int = 6;

		static var time_last : int;
		static var time_now : int;
		static var time_elapsed : Number;

		static var block : Block;
		static var blockNext : Block;
		//        static var blockHold : Block;
		static var arena : Arena;
		static var menu : Menu;
		static var index : Index;
		static var end : End;
		static var pass : Pass;
		static var endAll : EndAll;
		static var pause : Pause;
		static var info : Info;

		static var soundRotate : Sound;
		static var soundLand : Sound;
		//static var channelRotate : SoundChannel;

		static var gameState : int;
		static var gameLevel : int;

		static var isPressDown : Boolean;

		static var savedData : SharedObject;
		static var maxLevel : int;
		static var failedLevel : int;

		var backX : Number = 0;
		var backY : Number = -0.2; 

		public function Tetris() {
        	
			gameState = STARTING;
			gameLevel = 1;
            
			time_elapsed = 0;
			time_last = getTimer();
            
			menu = new Menu();
			addChild(menu);
            
			index = new Index();
			addChild(index);
			index.visible = false;
			
			end = new End();
			addChild(end);
			end.visible = false;
            
			pass = new Pass();
			addChild(pass);
			pass.visible = false;
            
			endAll = new EndAll();
			addChild(endAll);
			endAll.visible = false;

			pause = new Pause();
			addChild(pause);
			pause.visible = false;
			            			
			info = new Info();
			addChild(info);
			info.visible = false;
			            
			arena = new Arena();
			addChild(arena);
			arena.visible = false;
            
			soundRotate = new SoundRotate();
			soundLand = new SoundLand();
            
			isPressDown = false;
			
			savedData = SharedObject.getLocal("savedData", "/");
			maxLevel = savedData.data["max"];
			failedLevel = savedData.data["failed"];
			maxLevel = (maxLevel == 0) ? 2 : maxLevel;			failedLevel = (failedLevel == 0) ? 1 : failedLevel;
			//				Tetris.savedData.data["max"] = 2;
			//				Tetris.savedData.data["failed"] = 1;
			//				Tetris.savedData.flush();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleaseHandler);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            
            //btnStart = new ButtonStart();
            //btnStart.x=btnStart.y=200;
            //addChild(btnStart);
            //btnStart.addEventListener(MouseEvent.CLICK, startClickHandler);
		}

		
		protected function keyPressHandler(event : KeyboardEvent) : void {
			if (gameState == PLAYING) {
				switch( event.keyCode ) {
					case Keyboard.UP:
						block.rotate();                 
						break;
					case Keyboard.DOWN:
						if(!isPressDown) {
							isPressDown = true;
							block.moveDown();
						}
						break;
					case Keyboard.LEFT:
						block.moveLeft();
						break;
					case Keyboard.RIGHT:
						block.moveRight();
						break;
					case Keyboard.ESCAPE:
						gameState = WAITING;
						arena.visible = false;
						pause.visible = true;
						break;
				}
			} else if (gameState == WAITING && event.keyCode == Keyboard.ESCAPE) {
				gameState = PLAYING;
				arena.visible = true;
				pause.visible = false;
			} else if (gameState == HINTING && event.keyCode == Keyboard.ESCAPE) {
				gameState = WAITING;
				Tetris.info.drawing = false;
				pause.visible = true;
				info.visible = false;
			}
		}

		protected function keyReleaseHandler(event : KeyboardEvent) : void {
			if(gameState == PLAYING) {
				switch( event.keyCode ) {
					case Keyboard.DOWN:
						block.stopDown();
						isPressDown = false;
						break;
				}
			}
		}

		private function enterFrameHandler(event : Event) : void {
			time_now = getTimer();
			time_elapsed = Number(time_now - time_last) / 30;
			time_last = time_now;
            
			this["backMenu"].x += backX * time_elapsed;
			this["backMenu"].y += backY * time_elapsed;
			
			if (backY < 0 && this["backMenu"].y < -700) {
				backX = -0.2;
				backY = 0;
			} else if (backX < 0 && this["backMenu"].x < -1000) {
				backX = 0;
				backY = 0.2;
			} else if (backY > 0 && this["backMenu"].y > -100) {
				backX = 0.2;
				backY = 0;
			} else if (backX > 0 && this["backMenu"].x > -100) {
				backX = 0;
				backY = -0.2;
			}
		}

        //private function startClickHandler(event : MouseEvent) : void {
        //    trace("ok");
            //gotoAndStop(2);
        //}
	}
}
