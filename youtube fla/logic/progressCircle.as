class logic.progressCircle extends MovieClip
{
   var radius;
   var paused;
   var bg;
   var value;
   var notifier;
   var onEnterFrame;
   function progressCircle()
   {
      super();
      this.radius = 11;
      this.paused = false;
   }
   function genCurvePoints(r, d, delta)
   {
      var _loc6_ = Math.sin(d) * r;
      var _loc5_ = -1 * Math.cos(d) * r;
      var _loc2_ = Math.tan(d);
      var _loc12_ = Math.sin(d - delta) * r;
      var _loc11_ = -1 * Math.cos(d - delta) * r;
      var _loc3_ = Math.tan(d - delta);
      var _loc4_ = undefined;
      var _loc10_ = undefined;
      var _loc9_ = _loc11_ - _loc3_ * _loc12_;
      var _loc8_ = _loc5_ - _loc2_ * _loc6_;
      _loc4_ = (_loc8_ - _loc9_) / (_loc3_ - _loc2_);
      if(Math.abs(_loc3_) < Math.abs(_loc2_))
      {
         _loc10_ = _loc9_ + _loc3_ * _loc4_;
      }
      else
      {
         _loc10_ = _loc8_ + _loc2_ * _loc4_;
      }
      return [_loc4_,_loc10_,_loc6_,_loc5_];
   }
   function drawCircle(r, v)
   {
      var _loc4_ = 1 - v;
      this.clear();
      if(this.bg)
      {
         this.beginFill(16777215,40);
      }
      this.lineStyle(0,0,0);
      this.moveTo(0,0);
      this.lineTo(r * Math.sin(_loc4_ * 3.141592653589793 * 2),(- r) * Math.cos(_loc4_ * 3.141592653589793 * 2));
      this.lineStyle(2,13421772,100);
      var _loc2_ = 0;
      while(_loc2_ < 8)
      {
         if((_loc2_ + 1) * 0.125 > _loc4_)
         {
            var _loc3_ = undefined;
            if(_loc2_ * 0.125 > _loc4_)
            {
               _loc3_ = this.genCurvePoints(r,3.141592653589793 * (_loc2_ + 1) / 4,0.7853981633974483);
            }
            else
            {
               _loc3_ = this.genCurvePoints(r,3.141592653589793 * (_loc2_ + 1) / 4,3.141592653589793 * ((_loc2_ + 1) / 4 - 2 * _loc4_));
            }
            this.curveTo(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3]);
         }
         _loc2_ = _loc2_ + 1;
      }
      this.lineStyle(0,0,0);
      this.lineTo(0,0);
      if(this.bg)
      {
         this.endFill();
      }
   }
   function display_value(v)
   {
      this.value = v;
      this.drawCircle(this.radius,v);
   }
   function start_count_down(v, count_down_notifier)
   {
      this.notifier = count_down_notifier;
      this.display_value(v);
      this.onEnterFrame = this.count_down;
   }
   function is_counting()
   {
      return this.onEnterFrame != undefined;
   }
   function end_count()
   {
      this.display_value(0);
   }
   function count_down()
   {
      if(this.paused)
      {
         return undefined;
      }
      if(this.value != undefined)
      {
         if(this.value <= 0)
         {
            this.notifier.count_down_end();
            delete this.value;
            delete this.onEnterFrame;
         }
         else
         {
            this.display_value(this.value - 0.005);
         }
      }
   }
   function reset()
   {
      this.display_value(0);
      delete this.onEnterFrame;
   }
   function pause()
   {
      this.paused = true;
   }
   function unpause()
   {
      this.paused = false;
   }
   function onRollOver()
   {
      this.bg = true;
   }
   function onRollOut()
   {
      this.bg = false;
   }
   function onRelease()
   {
      this.end_count();
   }
}
