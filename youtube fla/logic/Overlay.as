class logic.Overlay extends MovieClip
{
   var loading;
   var play_button;
   var loading_mc;
   var bg;
   var img;
   var onRelease;
   function Overlay()
   {
      super();
      this.loading._visible = false;
      this.loading._woffset = this._width - this.loading._width;
      this.play_button._visible = false;
   }
   function show_message(msg)
   {
      this.loading.text = msg;
      this.loading_mc.removeMovieClip();
   }
   function show_loading()
   {
      this.loading_mc = this.attachMovie("spinner","loading_mc",this.getNextHighestDepth());
      this.loading_mc._xscale = 200;
      this.loading_mc._yscale = 200;
      this.loading._visible = true;
      this.play_button._visible = false;
   }
   function hide()
   {
      this.loading_mc.removeMovieClip();
      this.loading._visible = false;
      this._alpha = 0;
   }
   function show()
   {
      this.loading._visible = false;
      this._alpha = 100;
   }
   function resize(w, h)
   {
      this.bg._width = w;
      this.bg._height = h;
      this.loading._width = w - this.loading._woffset;
      if(this.loading._xscale > 100)
      {
         this.loading._xscale = 100;
      }
      this.loading._yscale = this.loading._xscale;
      this.loading._x = -1 * this.loading._width / 2;
      this.fit_img();
   }
   function fit_img()
   {
      if(this.img._loaded)
      {
         this.img._width = this.bg._width;
         this.img._height = this.bg._height;
         this.img._x = -1 * this.bg._width / 2;
         this.img._y = -1 * this.bg._height / 2;
      }
   }
   function gotoURL()
   {
      this.getURL(this._parent.movie_url,"_blank");
   }
   function makePressable()
   {
      this.onRelease = this.gotoURL;
   }
   function makePlayMoviePressable()
   {
      this.play_button._visible = true;
      this.onRelease = function()
      {
         this.play_button._visible = false;
         this._parent.playMovie();
         delete this.onRelease;
      };
   }
   function loadClip(still_url)
   {
      var _loc2_ = new Object();
      var o = this;
      if(!still_url || !logic.Util.inYTDomain(still_url,["vi/","i/","u/","c/"]))
      {
         return undefined;
      }
      _loc2_.onLoadInit = function(target_mc)
      {
         target_mc._loaded = true;
         o.fit_img();
      };
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc2_);
      this.createEmptyMovieClip("img",this.loading.getDepth() - 1);
      _loc3_.loadClip(still_url,this.img);
   }
}
