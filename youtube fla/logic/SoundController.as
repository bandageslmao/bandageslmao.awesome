class logic.SoundController extends MovieClip
{
   var sound_bar;
   var knob;
   var sound_button;
   var movie;
   var num_bars = 4;
   var volume_spacer = 5;
   var vs_space = 5;
   var muted = false;
   function SoundController()
   {
      super();
      var o = this;
      var _loc4_ = function()
      {
         o.knob.highLight();
         o.onEnterFrame = function()
         {
            var _loc2_ = this._xmouse - o.sound_bar._x;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            else if(_loc2_ > o.sound_bar._width)
            {
               _loc2_ = o.sound_bar._width;
            }
            o.hideMute();
            o.knob._x = _loc2_ + o.sound_bar._x;
            o.movie.setVolume(o.getSoundPos(o.knob._x));
         };
      };
      this.sound_bar.onPress = _loc4_;
      this.knob.onPress = _loc4_;
      var _loc6_ = function()
      {
         o.knob.normal();
         var _loc2_ = o.getSoundPos(o.knob._x);
         o.movie.setVolume(_loc2_);
         delete o.onEnterFrame;
      };
      this.sound_bar.onRelease = this.sound_bar.onReleaseOutside = this.knob.onRelease = this.knob.onReleaseOutside = _loc6_;
      this.sound_button.onRelease = function()
      {
         o.movie.toggleMute();
      };
   }
   function registerMovie(m)
   {
      this.movie = m;
      var o = this;
      m.onShowMute = function()
      {
         o.showMute();
      };
      m.onShowVolume = function(v)
      {
         o.hideMute();
         o.showVolume(v);
      };
   }
   function getSoundPos(pos)
   {
      var _loc2_ = Math.round((pos - this.sound_bar._x) * 100 / this.sound_bar._width);
      _loc2_ = Math.min(_loc2_,100);
      return Math.max(_loc2_,0);
   }
   function showMute()
   {
      this.showVolume(0);
   }
   function hideMute()
   {
   }
   function showVolume(v)
   {
      var _loc3_ = v * this.sound_bar._width / 100 + this.sound_bar._x;
      this.knob._x = _loc3_;
      this.showBars(v);
   }
   function showBars(v)
   {
      var _loc3_ = Math.round(v * this.num_bars / 100);
      var _loc2_ = 1;
      while(_loc2_ <= this.num_bars)
      {
         if(_loc2_ <= _loc3_)
         {
            this["v" + _loc2_]._visible = true;
         }
         else
         {
            this["v" + _loc2_]._visible = false;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_ == 0)
      {
         this.sound_button._alpha = 50;
      }
      else
      {
         this.sound_button._alpha = 100;
      }
   }
}
