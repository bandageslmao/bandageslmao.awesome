class logic.MovieController extends MovieClip
{
   var pause_button;
   var play_button;
   var stop_button;
   var warp_button;
   var onEnterFrame;
   var full_progress_bar;
   var slider;
   var left_justified_elements;
   var ldiv;
   var right_justified_elements;
   var timer;
   var mrdiv;
   var sound_control;
   var rdiv;
   var regular;
   var small;
   var min;
   var max;
   var movie;
   var main_bg;
   var left_bg;
   var right_bg;
   var seek_time;
   var seek_total_time;
   var seekBar;
   var fullBar;
   var seekBar_l;
   var seekBar_r;
   var progressBar;
   var progressBar_l;
   var progressBar_r;
   var slider_down = false;
   static var MIN_PROGRESS_BAR_SIZE = 100;
   function MovieController()
   {
      super();
      this.pause_button._visible = false;
      var o = this;
      this.play_button.onRelease = function()
      {
         o.movie.playMovie();
      };
      this.pause_button.onRelease = function()
      {
         o.movie.pauseMovie();
      };
      this.stop_button.onRelease = function()
      {
         o.movie.stopMovie();
      };
      this.warp_button.onRelease = function()
      {
         o._parent.toggleWarp();
      };
      this.warp_button._visible = false;
      var _loc6_ = function()
      {
         o.slider_down = true;
         o.slider.highLight();
         this.onEnterFrame = function()
         {
            var _loc1_ = o._xmouse;
            if(_loc1_ < o.full_progress_bar._x)
            {
               _loc1_ = o.full_progress_bar._x;
            }
            else if(_loc1_ > o.full_progress_bar._x + o.full_progress_bar._width)
            {
               _loc1_ = o.full_progress_bar._x + o.full_progress_bar._width;
            }
            o.slider._x = _loc1_;
            o.movie.peekSeekRatio(o.getScale());
         };
      };
      var _loc7_ = function()
      {
         o.slider.normal();
         o.movie.setSeekRatio(o.getScale());
         o.slider_down = false;
         delete this.onEnterFrame;
      };
      this.full_progress_bar.onPress = this.slider.onPress = _loc6_;
      this.full_progress_bar.onRelease = this.full_progress_bar.onReleaseOutside = this.slider.onRelease = this.slider.onReleaseOutside = _loc7_;
      var _loc3_ = this.getBounds(this);
      this.left_justified_elements = [this.play_button,this.warp_button,this.pause_button,this.stop_button,this.ldiv,this.full_progress_bar];
      for(var _loc5_ in this.left_justified_elements)
      {
         this.left_justified_elements[_loc5_]._xstart = _loc3_.xMin - this.left_justified_elements[_loc5_]._x;
      }
      this.right_justified_elements = [this.timer,this.mrdiv,this.sound_control,this.rdiv,this.regular,this.small,this.min,this.max];
      for(_loc5_ in this.right_justified_elements)
      {
         this.right_justified_elements[_loc5_]._xstart = _loc3_.xMax - this.right_justified_elements[_loc5_]._x;
      }
      this.full_progress_bar._xend = _loc3_.xMax - (this.full_progress_bar._width + this.full_progress_bar._x);
   }
   function registerMovie(m)
   {
      this.movie = m;
      this.sound_control.registerMovie(m);
      var o = this;
      m.onPauseMovie = function()
      {
         o.showPlay();
      };
      var old_play_handler = m.onPlayMovie;
      m.onPlayMovie = function()
      {
         o.showPause();
         old_play_handler.call(this);
      };
      m.onSeek = function(ir, r)
      {
         o.showSeek(ir,r);
      };
      m.onProgress = function(ir, r)
      {
         o.showProgress(ir,r);
      };
   }
   function getScale()
   {
      var _loc2_ = (this.slider._x - this.full_progress_bar._x) / this.full_progress_bar._width;
      if(_loc2_ < 0)
      {
         return 0;
      }
      return _loc2_;
   }
   function resize_width(w)
   {
      var _loc6_ = Stage.displayState;
      if(_loc6_ == "fullScreen")
      {
         this.showFSButtons(true);
      }
      else if(_loc6_ == "normal")
      {
         if(this.min._perm_visible)
         {
            logic.Util.call_js("checkCurrentVideo",this.movie.video_id);
         }
         this.showFSButtons(false);
      }
      this.main_bg._width = w - (this.left_bg._width + this.right_bg._width - 2);
      this.left_bg._x = -1 * (w / 2);
      this.right_bg._x = w / 2;
      for(var _loc2_ in this.left_justified_elements)
      {
         this.left_justified_elements[_loc2_]._x = -1 * (w / 2) - this.left_justified_elements[_loc2_]._xstart;
      }
      var _loc5_ = this.full_progress_bar._x + logic.MovieController.MIN_PROGRESS_BAR_SIZE;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.right_justified_elements.length)
      {
         this.right_justified_elements[_loc2_]._x = w / 2 - this.right_justified_elements[_loc2_]._xstart;
         if(this.right_justified_elements[_loc2_]._x < this.rdiv._x)
         {
            if(this.right_justified_elements[_loc2_]._x - 10 < _loc5_)
            {
               this.right_justified_elements[_loc2_]._visible = false;
            }
            else
            {
               this.makeVisible(this.right_justified_elements[_loc2_]);
               if(isNaN(_loc3_))
               {
                  _loc3_ = this.right_justified_elements[_loc2_]._x;
               }
            }
         }
         else
         {
            this.makeVisible(this.right_justified_elements[_loc2_]);
            if(isNaN(_loc3_))
            {
               _loc3_ = this.right_justified_elements[_loc2_]._x;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      this.full_progress_bar._width = _loc3_ - this.full_progress_bar._x - 10;
   }
   function showPlay()
   {
      this.play_button._visible = true;
      this.pause_button._visible = false;
   }
   function showPause()
   {
      this.play_button._visible = false;
      this.pause_button._visible = true;
   }
   function format_minute_time(t)
   {
      if(t == undefined)
      {
         return "0:00";
      }
      var _loc1_ = String(Math.floor(t % 60));
      if(_loc1_.length == 1)
      {
         _loc1_ = "0" + _loc1_;
      }
      var _loc2_ = String(Math.floor(t / 60));
      if(_loc2_.length == 1)
      {
         _loc2_ = "0" + _loc2_;
      }
      return _loc2_ + ":" + _loc1_;
   }
   function showSeek(ir, r)
   {
      if(isNaN(r))
      {
         r = 0;
      }
      if(r < ir)
      {
         r = ir;
      }
      this.seek_time.text = this.format_minute_time(this.movie.getCurrentTime());
      this.seek_total_time.text = this.format_minute_time(this.movie.getTotalTime());
      this.seekBar._x = ir * this.fullBar._width + this.fullBar._x;
      this.seekBar._width = Math.max(r - ir,0) * this.fullBar._width;
      this.seekBar_l._x = this.seekBar._x;
      this.seekBar_r._x = this.seekBar._width + this.seekBar._x;
      if(!this.slider_down)
      {
         this.slider._x = r * this.full_progress_bar._width + this.full_progress_bar._x;
      }
   }
   function showProgress(ir, r)
   {
      if(r < ir)
      {
         r = ir;
      }
      this.progressBar._x = ir * this.fullBar._width + this.fullBar._x;
      if(!isNaN(r) && r <= 1)
      {
         this.progressBar._width = (r - ir) * this.fullBar._width;
      }
      else
      {
         this.progressBar._width = 0;
      }
      this.progressBar_l._x = this.progressBar._x;
      this.progressBar_r._x = this.progressBar._width + this.progressBar._x;
   }
   function showFSButtons(_show)
   {
      var o = this;
      if(_show)
      {
         this.permShow(this.min);
         this.permHide(this.max);
         this.permHide(this.regular);
         this.permHide(this.small);
      }
      else
      {
         this.permHide(this.min);
         this.permShow(this.max);
         this.permHide(this.regular);
         this.permShow(this.small);
         this.regular.onPress = function()
         {
            o.movie.resizeNormal();
            o.permHide(o.regular);
            o.permShow(o.small);
         };
         this.small.onRelease = function()
         {
            o.movie.resizeOriginal();
            o.permShow(o.regular);
            o.permHide(o.small);
         };
      }
   }
   function permShow(clip)
   {
      clip._visible = true;
      clip._perm_visible = true;
   }
   function permHide(clip)
   {
      clip._visible = false;
      clip._perm_visible = false;
   }
   function makeVisible(clip)
   {
      if(clip._perm_visible != undefined)
      {
         clip._visible = clip._perm_visible;
      }
      else
      {
         clip._visible = true;
      }
   }
}
