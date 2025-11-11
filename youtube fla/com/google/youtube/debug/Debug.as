class com.google.youtube.debug.Debug
{
   var isLocal;
   var mc;
   var _useLocalConnection;
   var outgoingLocalConnection;
   static var _log;
   static var _url;
   static var window;
   static var instance;
   static var debugMenu;
   static var INFO = "info";
   static var WARNING = "warning";
   static var SEVERE = "severe";
   static var className = "com.google.youtube.debug.Debug";
   static var LOG_LEVEL = 3;
   static var LOG_BUFFER = 100;
   var initCalled = false;
   var INFO_COLOR = "#00aa00";
   var WARN_COLOR = "#cc6600";
   var SEVERE_COLOR = "#ff0000";
   var DEFAULT_COLOR = "#000000";
   function Debug()
   {
      com.google.youtube.debug.Debug._log = new Array();
      this.isLocal = com.google.youtube.debug.Debug._url.indexOf("http://") == -1 || com.google.youtube.debug.Debug._url == undefined;
   }
   function build(mc)
   {
      this.mc = mc;
      com.google.youtube.debug.Debug.window = com.google.youtube.debug.LogWindow(mc.attachMovie("LogWindow","LogWindow_mc",mc.getNextHighestDepth()));
      com.google.youtube.debug.Debug.window._visible = false;
      com.google.youtube.debug.Debug.window.mc = mc;
   }
   function init(mc, useLocalConnection)
   {
      this.initCalled = true;
      this._useLocalConnection = useLocalConnection;
      if(this._useLocalConnection)
      {
         this.outgoingLocalConnection = new LocalConnection();
      }
      else
      {
         Key.addListener(this);
         this.build(mc);
      }
   }
   static function getInstance()
   {
      if(com.google.youtube.debug.Debug.instance == undefined)
      {
         com.google.youtube.debug.Debug.instance = new com.google.youtube.debug.Debug();
      }
      return com.google.youtube.debug.Debug.instance;
   }
   static function debugTrace(level, msg, classNameAndMethod, fileName, lineNumber)
   {
      var _loc1_ = undefined;
      switch(level)
      {
         case com.google.youtube.debug.Debug.INFO:
            _loc1_ = 2;
            break;
         case com.google.youtube.debug.Debug.WARNING:
            _loc1_ = 1;
            break;
         case com.google.youtube.debug.Debug.SEVERE:
            _loc1_ = 0;
            break;
         default:
            _loc1_ = 3;
      }
      if(com.google.youtube.debug.Debug.LOG_LEVEL > _loc1_)
      {
         com.google.youtube.debug.Debug.getInstance().log(level,msg,classNameAndMethod,fileName,lineNumber);
      }
   }
   function onKeyDown()
   {
      if(Key.isDown(17) && Key.isDown(68) && Key.isDown(16))
      {
         com.google.youtube.debug.Debug.window.toggleWindow();
      }
   }
   function enableMenuItems()
   {
      com.google.youtube.debug.Debug.debugMenu = new ContextMenu();
      com.google.youtube.debug.Debug.debugMenu.customItems.push(new ContextMenuItem("Log Level: Off",this.setLevelOff));
      com.google.youtube.debug.Debug.debugMenu.customItems.push(new ContextMenuItem("Log Level: Info",this.setLevelInfo));
      com.google.youtube.debug.Debug.debugMenu.customItems.push(new ContextMenuItem("Log Level: Warning",this.setLevelWarning));
      com.google.youtube.debug.Debug.debugMenu.customItems.push(new ContextMenuItem("Log Level: Severe",this.setLevelSevere));
      com.google.youtube.debug.Debug.debugMenu.customItems.push(new ContextMenuItem("Clear Log",this.clearLog));
      _root.menu = com.google.youtube.debug.Debug.debugMenu;
   }
   function disableMenuItems()
   {
      com.google.youtube.debug.Debug.debugMenu.customItems[0].visible = false;
      com.google.youtube.debug.Debug.debugMenu.customItems[1].visible = false;
      com.google.youtube.debug.Debug.debugMenu.customItems[2].visible = false;
      com.google.youtube.debug.Debug.debugMenu.customItems[3].visible = false;
      com.google.youtube.debug.Debug.debugMenu.customItems[4].visible = false;
      _root.menu = com.google.youtube.debug.Debug.debugMenu;
   }
   function clearLog()
   {
      com.google.youtube.debug.Debug._log = [];
      com.google.youtube.debug.Debug.updateOutput();
   }
   function setLevelOff()
   {
      com.google.youtube.debug.Debug.LOG_LEVEL = 0;
   }
   function setLevelInfo()
   {
      com.google.youtube.debug.Debug.LOG_LEVEL = 3;
   }
   function setLevelWarning()
   {
      com.google.youtube.debug.Debug.LOG_LEVEL = 2;
   }
   function setLevelSevere()
   {
      com.google.youtube.debug.Debug.LOG_LEVEL = 1;
   }
   static function info(msg, classNameAndMethod)
   {
      com.google.youtube.debug.Debug.getInstance().log(com.google.youtube.debug.Debug.INFO,msg,classNameAndMethod);
   }
   static function warning(msg, classNameAndMethod)
   {
      com.google.youtube.debug.Debug.getInstance().log(com.google.youtube.debug.Debug.WARNING,msg,classNameAndMethod);
   }
   static function severe(msg, classNameAndMethod)
   {
      com.google.youtube.debug.Debug.getInstance().log(com.google.youtube.debug.Debug.SEVERE,msg,classNameAndMethod);
   }
   function log(level, msg, classNameAndMethod, fileName, lineNumber)
   {
      if(!this.initCalled)
      {
         this.init(undefined,true);
      }
      if(this._useLocalConnection)
      {
         this.outgoingLocalConnection.send("_superSecretYouTubeDebugConnection","receive",level,msg,classNameAndMethod + "::","/","");
      }
      else
      {
         var _loc4_ = classNameAndMethod.split(":");
         var _loc7_ = _loc4_[0];
         var _loc11_ = _loc4_[2];
         var _loc3_ = _loc7_.split(".");
         var _loc5_ = _loc3_[_loc3_.length - 1];
         var _loc10_ = "[<font color=\'#FFFFCC\'>" + _loc5_ + "::" + (_loc11_ || "") + ":" + (lineNumber || "") + "</font>]";
         var _loc2_ = undefined;
         var _loc16_ = undefined;
         switch(level)
         {
            case "info":
               _loc2_ = this.INFO_COLOR;
               break;
            case "warn":
               _loc2_ = this.WARN_COLOR;
               break;
            case "severe":
               _loc2_ = this.SEVERE_COLOR;
               break;
            default:
               _loc2_ = this.DEFAULT_COLOR;
         }
         var _loc9_ = "[<font color=\'" + _loc2_ + "\'>" + level + "</font>]";
         com.google.youtube.debug.Debug._log.push(_loc9_ + _loc10_ + msg);
         var _loc12_ = com.google.youtube.debug.Debug._log.length;
         var _loc6_ = com.google.youtube.debug.Debug._log.length - com.google.youtube.debug.Debug.LOG_BUFFER;
         if(_loc6_ > 0 && com.google.youtube.debug.Debug.window.scrollbar.isScrolledDown)
         {
            com.google.youtube.debug.Debug._log = com.google.youtube.debug.Debug._log.slice(com.google.youtube.debug.Debug._log.length - com.google.youtube.debug.Debug.LOG_BUFFER);
         }
         if(com.google.youtube.debug.Debug.window._visible && com.google.youtube.debug.Debug.window.scrollbar.isScrolledDown)
         {
            com.google.youtube.debug.Debug.updateOutput();
         }
      }
   }
   static function updateOutput()
   {
      com.google.youtube.debug.Debug.window.setOutput(com.google.youtube.debug.Debug._log.join("<br>") + "<br>log len: " + com.google.youtube.debug.Debug._log.length);
   }
   static function toggleWindow()
   {
      com.google.youtube.debug.Debug.window.toggleWindow();
   }
   static function expandObject(o)
   {
      var _loc2_ = "Expanding Object: \n";
      for(var _loc3_ in o)
      {
         _loc2_ += _loc3_ + " = " + o[_loc3_] + "\n";
      }
      return _loc2_;
   }
   static function recursivePrint(name, obj, level)
   {
      if(level == undefined)
      {
         level = 0;
      }
      for(var _loc3_ in obj)
      {
         com.google.youtube.debug.Debug.recursivePrint(_loc3_,obj[_loc3_],level + 1);
      }
   }
}
