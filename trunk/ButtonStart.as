package {
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;    

    /**
     * @author user
     */
    public class ButtonStart extends SimpleButton {
        public function ButtonStart(upState : DisplayObject = null, overState : DisplayObject = null, downState : DisplayObject = null, hitTestState : DisplayObject = null) {
            super(upState, overState, downState, hitTestState);
        }
    }
}
