class com.google.youtube.debug.LogWindow extends MovieClip
{
   var hit;
   var closebutton;
   var mc;
   var output_txt;
   var scrollbar;
   static var LINK_NAME = "LogWindow";
   static var FORCE_LINK = Object.registerClass(com.google.youtube.debug.LogWindow.LINK_NAME,com.google.youtube.debug.LogWindow);
   function LogWindow()
   {
      super();
   }
   function onLoad()
   {
      this.build();
   }
   function build()
   {
      var _self = this;
      this.hit.onPress = function()
      {
         _self.startDrag();
      };
      var _loc2_ = function()
      {
         _self.stopDrag();
      };
      this.hit.onRelease = this.hit.onReleaseOutside = _loc2_;
      this.closebutton.onRelease = function()
      {
         _self.toggleWindow();
      };
   }
   function toggleWindow()
   {
      if(this._visible)
      {
         this._visible = false;
         com.google.youtube.debug.Debug.getInstance().disableMenuItems();
      }
      else
      {
         this.swapDepths(this.mc.getNextHighestDepth());
         this._visible = true;
         com.google.youtube.debug.Debug.getInstance().enableMenuItems();
         com.google.youtube.debug.Debug.updateOutput();
      }
   }
   function setOutput(msg)
   {
      this.output_txt.htmlText = msg;
      if(this.scrollbar.isScrolledDown)
      {
         this.output_txt.scroll = this.output_txt.maxscroll;
      }
   }
}
