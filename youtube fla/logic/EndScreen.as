class logic.EndScreen extends MovieClip
{
   var movie;
   var end_buttons;
   var share;
   var replay;
   var prev_button;
   var next_panel;
   var count_down;
   var next_visible;
   var bg;
   var awsome_data;
   var awsome_videos;
   var next_index;
   var panels = [];
   var last_panels = 0;
   var margin = 11;
   function EndScreen()
   {
      super();
      this.movie = this._parent;
      if(this.end_buttons.shareButton)
      {
         this.share = this.end_buttons.shareButton;
      }
      else
      {
         this.share = this.end_buttons.share;
      }
      if(this.end_buttons.replayButton)
      {
         this.replay = this.end_buttons.replayButton;
      }
      else
      {
         this.replay = this.end_buttons.replay;
      }
      var o = this;
      this.replay.onRelease = function()
      {
         this.gotoAndStop(2);
         if(o.movie.rePlay)
         {
            o.movie.rePlay();
         }
         else
         {
            o.movie.playMovie();
         }
      };
      this.share.onRelease = function()
      {
         o.movie.share();
         this.gotoAndStop(2);
      };
      this.prev_button.onRelease = function()
      {
         o.load_previous_panels();
      };
      this.share.stop();
      this.replay.stop();
      this.share.onRollOver = this.replay.onRollOver = function()
      {
         this.gotoAndStop(2);
      };
      this.share.onRollOut = this.share.onReleaseOutside = this.replay.onRollOut = this.replay.onReleaseOutside = function()
      {
         this.gotoAndStop(1);
      };
      this.init();
   }
   function resetText(strings)
   {
      if(strings)
      {
         this.replay.replayText.watchagain_txt.text = strings.WatchAgain;
         this.share.shareText.share_txt.text = strings.Share;
         this.next_panel.views_txt.text = strings.Views;
         this.next_panel.from_txt.text = strings.From;
      }
   }
   function init()
   {
      this.end_buttons._visible = true;
      this.next_panel._visible = false;
      this.count_down._visible = false;
      this.prev_button._visible = false;
      this.next_visible = false;
   }
   function show()
   {
      if(!this._visible)
      {
         this._visible = true;
         this.init();
         this.display_next();
         this.resetText(_root.strings);
      }
   }
   function hide()
   {
      this._visible = false;
      this.count_down.reset();
   }
   function resize(w, h)
   {
      this.bg._width = w;
      this.bg._height = h;
      this.end_buttons._width = w - 20;
      if(this.end_buttons._xscale > 100)
      {
         this.end_buttons._xscale = 100;
      }
      this.end_buttons._yscale = this.end_buttons._xscale;
      this.layout_next();
   }
   function load_for_awsome()
   {
      var _loc2_ = new logic.urlRestXML(this.movie.base_url);
      this.next_visible = false;
      _loc2_.dispatch(this,this.parse_next,undefined,"set_awesome",{video_id:this.movie.video_id,w:this.movie.getSeekRatio(),l:this.movie.getTotalTime(),t:this.movie.track_id,m:""});
   }
   function show_next()
   {
      this.next_visible = true;
      this._visible = true;
      this.end_buttons._visible = false;
      var _loc3_ = new logic.urlRestXML(this.movie.base_url);
      _loc3_.dispatch(this,this.parse_next,undefined,"next_awesome",{video_id:this.movie.video_id,w:this.movie.getSeekRatio(),l:this.movie.getTotalTime(),t:this.movie.track_id,nc:_root.nc});
   }
   function parse_next(data)
   {
      this.awsome_data = data;
      if(this._visible)
      {
         this.display_next();
      }
   }
   function parse_data()
   {
      if(this.awsome_data)
      {
         var _loc4_ = logic.restXML.get_sub_array("video",this.awsome_data.video_list);
         this.awsome_videos = [];
         var _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            this.awsome_videos.push(logic.restXML.get_dict(_loc4_[_loc3_]));
            _loc3_ = _loc3_ + 1;
         }
         this.awsome_data = undefined;
         _root.status.text = "Data parsed :" + this.awsome_videos.length;
      }
   }
   function display_next()
   {
      if(!this.movie.supress_next)
      {
         if(this.next_visible)
         {
            this.end_buttons._visible = false;
         }
         if(this.awsome_data)
         {
            this.parse_data();
         }
         this.layout_next();
      }
   }
   function layout_next()
   {
      if(!this.next_panel)
      {
         return undefined;
      }
      var _loc7_ = this.bg.getBounds(this);
      var _loc10_ = _loc7_.yMin;
      var _loc9_ = _loc7_.yMax - _loc7_.yMin;
      var _loc8_ = 0;
      if(this.end_buttons._visible == true)
      {
         _loc8_ = this.end_buttons._height + 2 * this.margin;
      }
      var _loc5_ = Math.max(0,Math.min(int((_loc9_ - _loc8_) / (this.next_panel._height + this.margin)),4));
      var _loc6_ = _loc7_.yMin + (_loc9_ - (_loc8_ + this.next_panel._height * _loc5_ + this.margin * Math.max(_loc5_ - 1,0))) / 2;
      if(this.end_buttons._visible == true)
      {
         this.end_buttons._y = _loc6_ + this.end_buttons._height / 2;
         _loc6_ += this.end_buttons._height + 2 * this.margin;
      }
      this.panels = [];
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         var _loc2_ = undefined;
         if(_loc3_ == 0)
         {
            _loc2_ = this.next_panel;
         }
         else
         {
            _loc2_ = this.attachMovie("NextVideoPanel","next_panel" + _loc3_,_loc3_);
         }
         _loc2_._x = this.next_panel._x;
         _loc2_._y = _loc6_ + _loc2_._height / 2;
         _loc6_ += _loc2_._height + this.margin;
         _loc2_.load(this.get_next());
         this.panels.push(_loc2_);
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = _loc5_;
      while(_loc4_ < this.last_panels)
      {
         if(_loc4_ != 0)
         {
            this["next_panel" + _loc4_].removeMovieClip();
         }
         _loc4_ = _loc4_ + 1;
      }
      this.last_panels = _loc5_;
      this.resize_next_prev_buttons(_loc7_);
      this.count_down.reset();
      this.count_down._visible = false;
      this.prev_button._visible = false;
   }
   function resize_next_prev_buttons(bounds)
   {
      this.count_down._x = bounds.xMax - (this.margin / 2 + this.count_down._width / 2);
      this.count_down._y = bounds.yMax - (this.margin / 2 + this.count_down._height / 2);
      this.prev_button._x = bounds.xMin + this.margin / 2 + this.prev_button._width / 2;
      this.prev_button._y = bounds.yMax - (this.margin / 2 + this.prev_button._height / 2);
   }
   function get_next()
   {
      if(isNaN(this.next_index))
      {
         this.next_index = 0;
      }
      else
      {
         this.next_index = (this.next_index + 1) % this.awsome_videos.length;
      }
      return this.awsome_videos[this.next_index];
   }
   function clip_loaded()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.panels.length)
      {
         if(!this.panels[_loc2_].loaded)
         {
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      this.count_down._visible = true;
      this.prev_button._visible = true;
      this.count_down.start_count_down(1,this);
   }
   function count_down_end()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.panels.length)
      {
         this.panels[_loc2_].load(this.get_next());
         _loc2_ = _loc2_ + 1;
      }
      this.count_down._visible = false;
      this.prev_button._visible = false;
   }
   function load_previous_panels()
   {
      if(this.count_down.is_counting())
      {
         this.next_index -= 2 * this.panels.length;
         if(this.next_index < 0)
         {
            this.next_index += this.awsome_videos.length;
         }
      }
      this.count_down.end_count();
   }
   function pause()
   {
      this.count_down.pause();
   }
   function unpause()
   {
      this.count_down.unpause();
   }
}
