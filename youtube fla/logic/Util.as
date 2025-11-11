class logic.Util
{
   var frame_count;
   var max_frames;
   var ox;
   var ax;
   var oy;
   var ay;
   var ow;
   var aw;
   var oh;
   var ah;
   var dx;
   var dy;
   var dw;
   var dh;
   var onEnterFrame;
   var notifier;
   var img_url;
   function Util()
   {
   }
   static function alert(msg)
   {
      getURL("javascript:alert(\'" + escape(msg) + "\');","");
   }
   static function createOverlay(clip, suffix)
   {
      var _loc2_ = clip._parent[clip._name + "_" + suffix];
      if(!_loc2_)
      {
         _loc2_ = clip._parent.createEmptyMovieClip(clip._name + "_" + suffix,clip._parent.getNextHighestDepth());
      }
      return _loc2_;
   }
   static function calc_accl(x1, x2, t, v0)
   {
      return (x2 - x1 - v0 * t) / (t * t);
   }
   static function calc_dist(x1, t, a, v0)
   {
      return a * t * t + v0 * t + x1;
   }
   static function tween_to(clip, x, y, w, h, frames, notifier)
   {
      var _loc2_ = logic.Util.createOverlay(clip,"tweener");
      _loc2_.ax = logic.Util.calc_accl(clip._x,x,frames,0);
      _loc2_.ay = logic.Util.calc_accl(clip._y,y,frames,0);
      _loc2_.aw = logic.Util.calc_accl(clip._width,w,frames,0);
      _loc2_.ah = logic.Util.calc_accl(clip._height,h,frames,0);
      _loc2_.ox = clip._x;
      _loc2_.oy = clip._y;
      _loc2_.dx = x;
      _loc2_.dy = y;
      _loc2_.ow = clip._width;
      _loc2_.oh = clip._height;
      _loc2_.dw = w;
      _loc2_.dh = h;
      _loc2_.clip = clip;
      _loc2_.frame_count = 0;
      _loc2_.max_frames = frames;
      _loc2_.notifier = notifier;
      _loc2_.onEnterFrame = function()
      {
         this.frame_count = this.frame_count + 1;
         if(this.frame_count < this.max_frames)
         {
            clip._x = logic.Util.calc_dist(this.ox,this.frame_count,this.ax,0);
            clip._y = logic.Util.calc_dist(this.oy,this.frame_count,this.ay,0);
            var _loc3_ = logic.Util.calc_dist(this.ow,this.frame_count,this.aw,0);
            var _loc2_ = logic.Util.calc_dist(this.oh,this.frame_count,this.ah,0);
            if(clip.resize)
            {
               clip.resize(_loc3_,_loc2_);
            }
            else
            {
               clip._width = _loc3_;
               clip._height = _loc2_;
            }
         }
         else
         {
            clip._x = this.dx;
            clip._y = this.dy;
            if(clip.resize)
            {
               clip.resize(this.dw,this.dh);
            }
            else
            {
               clip._width = this.dw;
               clip._height = this.dh;
            }
            delete this.onEnterFrame;
            if(this.notifier)
            {
               this.notifier.onTweenComplete();
            }
         }
      };
   }
   static function fade_in(_c, frames)
   {
      var clip = _c;
      var _loc2_ = logic.Util.createOverlay(clip,"fader");
      clip._visible = true;
      var increment = (100 - clip._alpha) / frames;
      _loc2_.onEnterFrame = function()
      {
         clip._alpha += increment;
         if(clip._alpha >= 100)
         {
            clip._alpha = 100;
            delete this.onEnterFrame;
         }
      };
   }
   static function fade_out(_c, frames)
   {
      var clip = _c;
      var _loc2_ = logic.Util.createOverlay(clip,"fader");
      var decrement = clip._alpha / frames;
      _loc2_.onEnterFrame = function()
      {
         clip._alpha -= decrement;
         if(clip._alpha <= 0)
         {
            clip._alpha = 0;
            clip._visible = false;
            delete this.onEnterFrame;
         }
      };
   }
   static function createClickableOverlay(field)
   {
      var _loc1_ = logic.Util.createOverlay(field,"overlay");
      _loc1_._x = field._x;
      _loc1_._y = field._y;
      var _loc3_ = field._width;
      var _loc4_ = field._height;
      if(field.textWidth && field.textWidth < field._width)
      {
         _loc3_ = field.textWidth;
      }
      _loc1_.clear();
      _loc1_.beginFill(0,0);
      _loc1_.moveTo(0,0);
      _loc1_.lineTo(_loc3_,0);
      _loc1_.lineTo(_loc3_,_loc4_);
      _loc1_.lineTo(0,_loc4_);
      _loc1_.lineTo(0,0);
      _loc1_.endFill();
      return _loc1_;
   }
   static function getDist(x1, y1, x2, y2)
   {
      return Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
   }
   static function call_js(func)
   {
      var _loc6_ = _global.flash.external.ExternalInterface;
      if(_loc6_.available)
      {
         var _loc5_ = [func];
         var _loc3_ = 1;
         while(_loc3_ < arguments.length)
         {
            _loc5_.push(arguments[_loc3_]);
            _loc3_ = _loc3_ + 1;
         }
         _loc6_.call.apply(null,_loc5_);
      }
      else
      {
         _loc5_ = "";
         _loc3_ = 1;
         while(_loc3_ < arguments.length)
         {
            var _loc4_ = "\'" + escape(arguments[_loc3_]) + "\'";
            if(_loc5_.length)
            {
               _loc5_ += "," + _loc4_;
            }
            else
            {
               _loc5_ += _loc4_;
            }
            _loc3_ = _loc3_ + 1;
         }
         getURL("javascript:" + func + "(" + _loc5_ + ");","");
      }
   }
   static function popUpWin(url, winName, w, h, toolbar, location, directories, status, menubar, scrollbars, resizable)
   {
      getURL("javascript:var " + winName + ";if (!" + winName + "||" + winName + ".closed){" + winName + "=window.open(\'" + url + "\', \'" + winName + "\', \'" + "width=" + w + ", height=" + h + ", toolbar=" + toolbar + ", location=" + location + ", directories=" + directories + ", status=" + status + ", menubar=" + menubar + ", scrollbars=" + scrollbars + ", resizable=" + resizable + "\')}else{" + winName + ".focus();};void(0);","");
   }
   static function format_minute_time(t)
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
   static function showShare(base_url, video_id)
   {
      logic.Util.call_js("shareVideoFromFlash");
   }
   static function popUpShare(base_url, video_id)
   {
      getURL(base_url + "share?v=" + video_id + "&embed=1","_blank");
   }
   static function popUpSharePlayList(base_url, pl_id)
   {
      getURL(base_url + "share?p=" + pl_id + "&embed=1","_blank");
   }
   static function inYTDomain(url, allow_paths)
   {
      var _loc6_ = "http://";
      if(url.indexOf(_loc6_) == 0)
      {
         var _loc8_ = url.indexOf("/",_loc6_.length);
         var _loc3_ = url.slice(_loc6_.length,_loc8_);
         var _loc2_ = url.slice(_loc8_ + 1).split("?",1)[0];
         if(_loc3_.indexOf("?") > -1 || _loc3_.indexOf("%") > -1 || _loc3_.indexOf("#") > -1)
         {
            return false;
         }
         var _loc5_ = false;
         if(_loc3_.toLowerCase() == "youtube.com")
         {
            _loc5_ = true;
         }
         if(_loc3_.substring(_loc3_.length - 12,_loc3_.length).toLowerCase() == ".youtube.com")
         {
            _loc5_ = true;
         }
         else if(_loc3_.substring(_loc3_.length - 17,_loc3_.length).toLowerCase() == ".youtube.com:8000")
         {
            _loc5_ = true;
         }
         if(!_loc5_)
         {
            return false;
         }
         if(!allow_paths)
         {
            return _loc2_.length == 0;
         }
         for(var _loc4_ in allow_paths)
         {
            if(allow_paths[_loc4_] == _loc2_ || allow_paths[_loc4_].charAt(allow_paths[_loc4_].length - 1) == "/" && _loc2_.indexOf(allow_paths[_loc4_]) == 0)
            {
               return true;
            }
         }
      }
      return false;
   }
   static function loadImgClip(clip, img_url, notifier, _b)
   {
      var _loc1_ = new Object();
      var b = _b;
      if(!b)
      {
         b = clip.getBounds(clip._parent);
      }
      var n = notifier;
      var _loc3_ = function(target_mc, error)
      {
         target_mc._x = b.xMin;
         target_mc._y = b.yMin;
         target_mc._width = b.xMax - b.xMin;
         target_mc._height = b.yMax - b.yMin;
         if(n)
         {
            n.onClipLoaded(target_mc,error);
         }
      };
      _loc1_.onLoadInit = _loc3_;
      _loc1_.onLoadError = _loc3_;
      var _loc2_ = new MovieClipLoader();
      _loc2_.addListener(_loc1_);
      var _loc5_ = _loc2_.loadClip(img_url,clip);
   }
   static function loadSafeImgClipAndFade(clip, img_url, notifier, _b)
   {
      var _loc3_ = new Object();
      var b = _b;
      if(!b)
      {
         b = clip.getBounds(clip._parent);
      }
      var n = notifier;
      var _loc5_ = function(target_mc, error)
      {
         target_mc._x = b.xMin;
         target_mc._y = b.yMin;
         target_mc._width = b.xMax - b.xMin;
         target_mc._height = b.yMax - b.yMin;
         target_mc._iurl = this.img_url;
         if(n)
         {
            n.onClipLoaded(target_mc,error);
         }
         target_mc._visible = true;
         target_mc._alpha = 0;
         target_mc.onEnterFrame = function()
         {
            target_mc._alpha += 20;
            if(target_mc._alpha >= 100)
            {
               delete this.onEnterFrame;
               target_mc._alpha = 100;
            }
         };
      };
      _loc3_.onLoadInit = _loc5_;
      _loc3_.onLoadError = _loc5_;
      _loc3_.img_url = img_url;
      if(clip._iurl)
      {
         if(clip._iurl == img_url)
         {
            clip._visible = true;
            return undefined;
         }
         clip = clip._parent.createEmptyMovieClip(clip._name,clip.getDepth());
      }
      clip._iurl = img_url;
      var _loc4_ = new MovieClipLoader();
      _loc4_.addListener(_loc3_);
      _loc4_.loadClip(img_url,clip);
   }
   static function loadFlash(clip, img_url, notifier)
   {
      var _loc1_ = new Object();
      var n = notifier;
      var _loc3_ = function(target_mc, error)
      {
         if(n)
         {
            n.onClipLoaded(target_mc,error);
         }
      };
      _loc1_.onLoadInit = _loc3_;
      _loc1_.onLoadError = _loc3_;
      var _loc2_ = new MovieClipLoader();
      _loc2_.addListener(_loc1_);
      _loc2_.loadClip(img_url,clip);
   }
}
