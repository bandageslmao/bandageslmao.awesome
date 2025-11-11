class logic.UrlConstructor
{
   var baseUrl_;
   var hasParameter_;
   function UrlConstructor(baseUrl)
   {
      this.baseUrl_ = baseUrl;
      this.hasParameter_ = true;
      if(this.baseUrl_.indexOf("?") < 0)
      {
         this.hasParameter_ = false;
         this.baseUrl_ += "?";
      }
   }
   function addGlobalParameters(args)
   {
      this.baseUrl_ = this.makeUrl(args);
      this.hasParameter_ = true;
   }
   function get url()
   {
      return this.baseUrl_;
   }
   function makeUrl(args)
   {
      var _loc2_ = this.baseUrl_;
      var _loc3_ = this.hasParameter_;
      for(var _loc5_ in args)
      {
         if(_loc3_)
         {
            _loc2_ += "&";
         }
         _loc2_ += _loc5_ + "=" + args[_loc5_];
         _loc3_ = true;
      }
      return _loc2_;
   }
}
