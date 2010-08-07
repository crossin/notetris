package {
    import flash.media.Sound;
    import flash.media.SoundLoaderContext;
    import flash.net.URLRequest;    

    /**
     * @author user
     */
    public class SoundLand extends Sound {
        public function SoundLand(stream : URLRequest = null, context : SoundLoaderContext = null) {
            super(stream, context);
        }
    }
}
