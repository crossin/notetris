package {
    import flash.display.DisplayObject;
    import flash.display.SimpleButton;    

    /**
     * @author user
     */
    public class ButtonNext extends SimpleButton {
        public function ButtonNext(upState : DisplayObject = null, overState : DisplayObject = null, downState : DisplayObject = null, hitTestState : DisplayObject = null) {
            super(upState, overState, downState, hitTestState);
        }
    }
}
