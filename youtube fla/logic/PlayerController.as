class logic.PlayerController extends MovieClip
{
   var close_movie;
   var max_movie;
   var movie;
   var controller;
   var layout;
   var player;
   var warp;
   var real_width;
   var real_height;
   var warp_underlay;
   var show_warp = true;
   var WARP_MOVIE_MARGIN = 100;
   var WARP_VIDEO_WIDTH = 600;
   var WARP_VIDEO_HEIGHT = 450;
   function PlayerController()
   {
      super();
      this.show_warp = false;
      this.close_movie._visible = false;
      this.max_movie._visible = false;
      this.close_movie.onRelease = function()
      {
         this._parent.showWarp();
      };
      this.max_movie.onRelease = function()
      {
         this._parent.hideWarp();
      };
      this.movie.onPlayMovie = function()
      {
         if(!this._visible)
         {
            this._parent.hideWarp();
         }
      };
      this.movie.onEndMovie = function()
      {
         if(_root.playnext == "1")
         {
            delete _root.playnext;
            this.getURL("javascript:gotoNext()");
            return true;
         }
         if(this._parent.show_warp)
         {
            this._parent.hideWarpMovie();
            this._parent.showWarp();
            return true;
         }
      };
      this.controller.showFSButtons(true);
      this.layout = new logic.LayoutManager(this.movie.overlay,this);
      this.layout.registerObject(this.close_movie,logic.LayoutManager.TOP | logic.LayoutManager.RIGHT,true);
      this.layout.registerObject(this.max_movie,logic.LayoutManager.BOTTOM | logic.LayoutManager.RIGHT,true);
   }
   function onResize()
   {
      this.resize(Stage.width,Stage.height);
   }
   function init(root)
   {
      this.controller.registerMovie(this.movie);
      this.movie.useHandCursor = false;
      Stage.scaleMode = "noScale";
      Stage.addListener(this);
      this.resize(Stage.width,Stage.height);
   }
   function load_warp()
   {
      var _loc2_ = new Object();
      _loc2_.player = this;
      _loc2_.onLoadInit = function(mc)
      {
         var _loc3_ = {player:this.player,v:this.player.movie.video_id};
         mc.world.init(_loc3_);
         mc._x = this.player.movie._x - mc._width / 2;
         mc._y = this.player.movie._y - mc._height / 2;
         this.player.renderWarp();
      };
      System.security.allowDomain(this.movie.base_url);
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc2_);
      _loc3_.loadClip(this.movie.base_url + "warp.swf",this.warp);
   }
   function toggleWarp()
   {
      this.show_warp = !this.show_warp;
      this.renderWarp();
   }
   function hideWarp()
   {
      this.show_warp = false;
      this.renderWarp();
   }
   function showWarp()
   {
      this.show_warp = true;
      this.renderWarp();
   }
   function renderWarp()
   {
      this.controller.warp_button.setWarp(this.show_warp);
      if(this.show_warp)
      {
         if(!this.warp.world)
         {
            this.load_warp();
            return undefined;
         }
         this.warp.world.showWorld();
         this.warp._visible = true;
         this.movie._visible = false;
         this.hideWarpUnderlay();
      }
      else
      {
         this.warp.world.pauseWorld();
         this.movie._visible = true;
         this.warp._visible = false;
         this.close_movie._visible = false;
         this.max_movie._visible = false;
         this.hideWarpUnderlay();
      }
      this.resize(this.real_width,this.real_height);
   }
   function setMovie(video_id, image_url, movie_url, length, track_id, eurl, append)
   {
      this.movie.setMovie(video_id,image_url,movie_url,length,track_id,eurl,append);
   }
   function showWarpMovie()
   {
      this.close_movie._visible = true;
      this.max_movie._visible = true;
      this.movie._visible = true;
      this.showWarpUnderlay();
      this.warp_underlay._x = this.movie._x;
      this.warp_underlay._y = this.movie._y;
      this.warp_underlay._width = this.movie._width + 2;
      this.warp_underlay._height = this.movie._height + 2;
   }
   function showWarpUnderlay()
   {
      this.warp_underlay = this.createEmptyMovieClip("warp_underlay",this.movie.getDepth() - 1);
      this.warp_underlay.beginFill(13421772,100);
      this.warp_underlay.moveTo(-1,-1);
      this.warp_underlay.lineTo(1,-1);
      this.warp_underlay.lineTo(1,1);
      this.warp_underlay.lineTo(-1,1);
      this.warp_underlay.lineTo(-1,-1);
      this.warp_underlay.endFill();
      this.warp_underlay.onRelease = function()
      {
      };
      this.warp_underlay.useHandCursor = false;
   }
   function hideWarpUnderlay()
   {
      this.warp_underlay.clear();
      this.warp_underlay.removeMovieClip();
   }
   function hideWarpMovie()
   {
      this.hideWarpUnderlay();
      this.close_movie._visible = false;
      this.max_movie._visible = false;
      this.movie._visible = false;
   }
   function resize(w, h)
   {
      this.real_width = w;
      this.real_height = h;
      this.controller._y = h / 2 - this.controller._height;
      this.controller.resize_width(w);
      if(this.show_warp)
      {
         this.movie.resize(Math.min(w - this.WARP_MOVIE_MARGIN,this.WARP_VIDEO_WIDTH),Math.min(h - (this.controller._height + this.WARP_MOVIE_MARGIN),this.WARP_VIDEO_HEIGHT));
         this.warp.world.resize(w,h - this.controller._height);
         this.layout.layoutObjects();
         this.warp_underlay._width = this.movie._width + 2;
         this.warp_underlay._height = this.movie._height + 2;
      }
      else
      {
         this.movie.resize(w,h - this.controller._height);
      }
      if(Stage.displayState == "fullScreen" || _root.fs)
      {
         this.controller.warp_button._visible = true;
      }
      else
      {
         if(this.show_warp)
         {
            this.hideWarp();
         }
         this.controller.warp_button._visible = false;
      }
   }
}
