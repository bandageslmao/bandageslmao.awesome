class com.google.youtube.debug.LogWindowScrollbar extends MovieClip
{
   var tf;
   var scrollTop;
   var track;
   var scrollBottom;
   var handle;
   var scrollTravel;
   var onEnterFrame;
   var trackhit;
   var mscroll;
   static var LINK_NAME = "LogWindowScrollbar";
   static var FORCE_LINK = Object.registerClass(com.google.youtube.debug.LogWindowScrollbar.LINK_NAME,com.google.youtube.debug.LogWindowScrollbar);
   function LogWindowScrollbar()
   {
      super();
      this.tf = this._parent.output_txt;
   }
   function onLoad()
   {
      this.build();
   }
   function build()
   {
      this.scrollTop = this.track._y;
      this.scrollBottom = this.track._y + this.track._height - this.handle._height;
      this.scrollTravel = this.scrollBottom - this.scrollTop;
      var _self = this;
      this.handle.onPress = function()
      {
         this.startDrag(false,this._x,_self.scrollTop,this._x,_self.scrollBottom);
         _self.mscroll = _self.tf.maxscroll;
         this.onEnterFrame = com.google.chianti.event.EventDelegate.create(_self,_self.onScroll);
      };
      var _loc2_ = function()
      {
         this.stopDrag();
         this.onEnterFrame = null;
         com.google.youtube.debug.Debug.updateOutput();
      };
      this.handle.onRelease = this.handle.onReleaseOutside = _loc2_;
      this.trackhit.onRelease = com.google.chianti.event.EventDelegate.create(this,this.onTrackClick);
      this.trackhit.useHandCursor = false;
      this.tf.scroll = this.tf.maxscroll;
   }
   function onTrackClick()
   {
      var _loc2_ = this.track._y + this.track._height;
      this.handle._y = this.track._ymouse - this.handle._height / 2;
      if(this.handle._y > _loc2_ - this.handle._height)
      {
         this.handle._y = _loc2_ - this.handle._height;
      }
      this.mscroll = this.tf.maxscroll;
      this.onScroll();
   }
   function onScroll()
   {
      var _loc2_ = Math.ceil((this.handle._y - this.scrollTop) / this.scrollTravel * 100);
      this.tf.scroll = Math.ceil((this.mscroll - 1) / 100 * _loc2_) + 1;
   }
   function get isScrolledDown()
   {
      if(this.handle._y == this.track._y + this.track._height - this.handle._height)
      {
         return true;
      }
      return false;
   }
}
