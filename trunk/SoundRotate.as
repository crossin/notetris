package {
    import flash.media.Sound;
    import flash.media.SoundLoaderContext;
    import flash.net.URLRequest;    

    /**
     * @author user
     */
    public class SoundRotate extends Sound {
        public function SoundRotate(stream : URLRequest = null, context : SoundLoaderContext = null) {
            super(stream, context);
        }
    }
}
