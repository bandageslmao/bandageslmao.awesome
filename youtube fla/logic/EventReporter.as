class logic.EventReporter extends logic.UrlConstructor
{
   function EventReporter(baseUrl)
   {
      super(baseUrl);
   }
   function send(args)
   {
      var _loc2_ = this.makeUrl(args);
      this.sendUrl(_loc2_);
   }
   function sendUrl(url)
   {
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = _root.createEmptyMovieClip("junkClip",999999);
      _loc2_.loadClip(url,_loc3_);
   }
}
