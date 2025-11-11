class logic.Movie extends MovieClip
{
   var videoDisplay;
   var bufferEmptyCount;
   var videoDownloadRetries;
   var snd;
   var sound_data_so;
   var sound_data;
   var audio;
   var base_url;
   var display_ratio;
   var end_screen;
   var firstChild;
   var jsApiInterval;
   var onShowMute;
   var onShowVolume;
   var is_playing;
   var onPlayMovie;
   var onPauseMovie;
   var video_id;
   var track_id;
   var movie_url;
   var movieTime;
   var load_awsome;
   var tracker;
   var tracker_cls;
   var started;
   var restart;
   var stall_count;
   var api_loaded;
   var max_seek_ratio;
   var overlay;
   var format;
   var loader;
   var ns;
   var static_share_clip;
   var static_share;
   var onEndMovie;
   var init_seek;
   var onStartMovie;
   var onSeek;
   var is_peeking;
   var onProgress;
   var lastTime;
   var stallCount;
   var bg;
   var init_run = true;
   var is_embed = false;
   var is_ad = false;
   var is_infringe_mute = false;
   function Movie()
   {
      super();
      com.google.youtube.debug.Debug.getInstance().init(null,true);
      com.google.youtube.debug.Debug.info("init()","Movie");
      this.videoDisplay.smoothing = true;
      this.bufferEmptyCount = 0;
      this.videoDownloadRetries = 0;
      this.snd = this.createEmptyMovieClip("snd",0);
      this.sound_data_so = SharedObject.getLocal("soundData","/");
      this.sound_data = this.sound_data_so.data;
      this.audio = new Sound(this.snd);
      if(this.sound_data.volume == undefined)
      {
         this.sound_data.volume = 100;
      }
      if(this.sound_data.mute == undefined)
      {
         this.sound_data.mute = false;
      }
      if(_root.BASE_YT_URL == undefined || !logic.Util.inYTDomain(_root.BASE_YT_URL))
      {
         this.base_url = "http://www.youtube.com/";
      }
      else
      {
         this.base_url = _root.BASE_YT_URL;
      }
      this.display_ratio = this.videoDisplay._width / this.videoDisplay._height;
      this.registerLoader(new logic.MovieLoader());
      this.end_screen._visible = false;
      _root.strings = {Share:"share",WatchAgain:"replay",From:"From:",Views:"Views:",Comments:"Comments:",VideoRating:"Video Rating",Ratings:"RATING_COUNT_1 ratings",ZeroRatings:"0 ratings",VideoNoLongerAvailable:"This video is no longer available.",EmbeddingNotAllowed:"The owner of this video does not allow video embedding please watch this video on YouTube.com",VideoUnavailable:"This video is unavailable.",RateThisVideo:"Rate this video",ThanksForRating:"Thanks for rating!",Poor:"Poor",NothingSpecial:"Nothing Special",WorthWatching:"Worth Watching",PrettyCool:"Pretty Cool",Awesome:"Awesome!",LoginToRate:"Login to rate video",Loading:"Loading..."};
      com.google.youtube.debug.Debug.info("hl = " + _root.hl,"Movie");
      if(_root.hl != "en" && _root.hl != "" && _root.hl != undefined)
      {
         com.google.youtube.debug.Debug.info("loading different language dict","Movie");
         var _loc8_ = new XML();
         _loc8_.ignoreWhite = true;
         var moviePointer = this;
         _loc8_.onLoad = function(s)
         {
            if(s)
            {
               com.google.youtube.debug.Debug.info(this);
               var _loc3_ = this.firstChild.firstChild.childNodes;
               for(var _loc4_ in _loc3_)
               {
                  if(_loc3_[_loc4_].nodeName == "msg")
                  {
                     _root.strings[_loc3_[_loc4_].attributes.name] = _loc3_[_loc4_].firstChild.nodeValue;
                  }
               }
               com.google.youtube.debug.Debug.info("parsed language: " + _root.hl);
               for(var _loc5_ in _root.strings)
               {
                  com.google.youtube.debug.Debug.info(_loc5_ + " = " + _root.strings[_loc5_]);
               }
               com.google.youtube.debug.Debug.info("-----");
               if(moviePointer.is_ad)
               {
                  moviePointer._parent.pva_info.stars.setStarText();
                  moviePointer.overlay.show_message(_root.strings.Loading);
               }
            }
            else
            {
               com.google.youtube.debug.Debug.warning("Failed to load xlb file");
            }
         };
         var _loc6_ = this.base_url + "xlb/" + _root.hl + ".xlb";
         if(this.is_ad)
         {
            _loc6_ = this.base_url + "xlb/yva/" + _root.hl + ".xlb";
         }
         com.google.youtube.debug.Debug.info("loading XML: " + _loc6_);
         _loc8_.load(_loc6_);
      }
      else if(this.is_ad)
      {
         this._parent.controller.share.instance10.text = _root.strings.Share;
      }
   }
   function enableJsApi()
   {
      if(!this.jsApiInterval)
      {
         System.security.allowDomain("*");
         com.google.youtube.debug.Debug.info("enabling js API","Movie");
         this.jsApiInterval = setInterval(this,"updateJsApi",100);
      }
   }
   function initController()
   {
      if(this.sound_data.mute)
      {
         this.audio.setVolume(0);
         this.onShowMute();
      }
      else
      {
         this.onShowVolume(this.sound_data.volume);
         this.audio.setVolume(this.sound_data.volume);
      }
      if(this.is_playing)
      {
         this.onPlayMovie();
      }
      else
      {
         this.onPauseMovie();
      }
   }
   function setMovie(_video_id, image_url, movie_url, l, _track_id, eurl, append_vars)
   {
      this.video_id = _video_id;
      this.track_id = _track_id;
      var _loc9_ = image_url;
      if(_loc9_ == undefined && this.is_embed)
      {
         _loc9_ = "http://img.youtube.com/vi/" + this.video_id + "/default.jpg";
      }
      if(eurl == undefined)
      {
         eurl = "";
      }
      if(append_vars == undefined)
      {
         append_vars = "";
      }
      if(movie_url == undefined)
      {
         movie_url = this.base_url + "watch?v=" + this.video_id + "&eurl=" + escape(eurl);
      }
      this.movie_url = movie_url;
      this.movieTime = l;
      if(this.is_embed)
      {
         append_vars += "&eurl=" + escape(eurl);
         if(this.is_ad)
         {
            append_vars += "&adp=1";
         }
         this.load_awsome = false;
      }
      else
      {
         this.load_awsome = true;
      }
      if(this.tracker)
      {
         this.tracker.endTrack();
         delete this.tracker;
      }
      if(this.tracker_cls)
      {
         this.tracker = new this.tracker_cls(this);
      }
      this.setSeek(0);
      this.pauseMovie();
      this.hideEnded();
      this.is_playing = false;
      this.started = false;
      this.restart = true;
      this.stall_count = 0;
      this.api_loaded = false;
      this.max_seek_ratio = 0;
      if(_loc9_)
      {
         if(this.is_embed && !this.is_ad)
         {
            this.overlay.makePressable();
         }
         else
         {
            this.overlay.makePlayMoviePressable();
         }
         this.overlay.loadClip(_loc9_);
      }
      var _loc8_ = logic.VideoStats.predictedBandwidthInBitsPerSecond();
      if(!_loc8_)
      {
         _loc8_ = 0;
      }
      var _loc7_ = _root.fmt_map.split(",");
      var _loc3_ = 0;
      while(_loc3_ < _loc7_.length)
      {
         var _loc5_ = _loc7_[_loc3_].split("/");
         var _loc4_ = _loc5_[0];
         var _loc6_ = parseInt(_loc5_[1]);
         if(_loc4_ && !isNaN(_loc6_) && _loc6_ <= _loc8_)
         {
            this.format = _loc4_;
            break;
         }
         _loc3_ = _loc3_ + 1;
      }
      this.loader.load(this.base_url,this.video_id,this.track_id,append_vars,this.format);
      this._attachLoader(this.loader);
      if(!this.loader.started)
      {
         this.overlay.show();
      }
      else
      {
         this.overlay.hide();
      }
   }
   function registerLoader(_loader, leave_old)
   {
      if(this.loader)
      {
         if(!leave_old)
         {
            this.loader.die();
         }
         delete this.ns;
         delete this.loader;
      }
      this._attachLoader(_loader);
   }
   function _attachLoader(_loader)
   {
      this.loader = _loader;
      this.loader.setMovie(this);
      this.ns = this.loader.ns;
      this.videoDisplay.attachVideo(this.ns);
      this.snd.attachAudio(this.ns);
   }
   function popLoader()
   {
      var _loc2_ = this.loader;
      delete this.ns;
      delete this.loader;
      this.registerLoader(new logic.MovieLoader());
      return _loc2_;
   }
   function share()
   {
      var _loc2_ = this._parent;
      if(this.static_share_clip)
      {
         this.static_share_clip.removeMovieClip();
         delete this.static_share_clip;
      }
      else if(this.static_share)
      {
         _loc2_.play_button._visible = false;
         this.attachMovie("StaticShare","static_share_clip",this.getNextHighestDepth(),{share_url:this.movie_url});
      }
      else if(!this.is_embed)
      {
         logic.Util.showShare(this.base_url,this.video_id);
      }
      else
      {
         logic.Util.popUpShare(this.base_url,this.video_id);
      }
      _loc2_.logShareEvent();
      this.pauseMovie();
   }
   function endMovie()
   {
      if(this.tracker)
      {
         this.tracker.doTrack(this.getTime(),this.getSeekRatio());
         this.tracker.doEndMovieTrack();
      }
      this.restart = true;
      this.loader.clearOffset();
      this.pauseMovie();
      if(this.load_awsome)
      {
         this.end_screen.load_for_awsome();
         this.load_awsome = false;
      }
      if(!this.onEndMovie())
      {
         this.showEnded();
      }
   }
   function showEnded()
   {
      this.end_screen.show();
   }
   function hideEnded()
   {
      this.end_screen.hide();
   }
   function pauseMovie()
   {
      this.ns.pause(true);
      this.is_playing = false;
      this.onPauseMovie();
   }
   function stopMovie()
   {
      this.restart = true;
      this.loader.clearOffset();
      this.pauseMovie();
   }
   function stopAll()
   {
      this.is_playing = false;
      this.loader.die();
      this.pauseMovie();
   }
   function setInitSeek(seek_time)
   {
      this.init_seek = seek_time;
   }
   function initSeek()
   {
      if(this.init_seek)
      {
         this.setSeek(this.init_seek);
      }
   }
   function playMovie()
   {
      if(this.static_share_clip)
      {
         this.static_share_clip.removeMovieClip();
         delete this.static_share_clip;
      }
      if(this.loader.started == false)
      {
         this.loader.start();
         this.overlay.show_loading();
         this.onStartMovie();
      }
      else
      {
         if(this.restart == true)
         {
            this.setSeek(0);
         }
         this.ns.pause(false);
      }
      this.hideEnded();
      this.onPlayMovie();
      this.is_playing = true;
      this.restart = false;
   }
   function isPlaying()
   {
      return this.is_playing;
   }
   function getMovieInfo()
   {
      var _loc2_ = new logic.restXML(this.base_url);
      _loc2_.dispatch(this,this.parseMovieInfo,undefined,"youtube.videos.get_video_info",{video_id:this.video_id});
   }
   function parseMovieInfo(data)
   {
      if(data.video)
      {
         var _loc3_ = logic.restXML.get_dict(data.video);
         var _loc4_ = Number(_loc3_.length_seconds);
         if(_loc4_)
         {
            this.movieTime = _loc4_;
         }
         if(_loc3_.embed_status == "rejected" || _loc3_.embed_status == "unavail")
         {
            this.overlay.show_message(_root.strings.VideoNoLongerAvailable);
            this.stopAll();
         }
         else if(_loc3_.embed_status == "not_allowed")
         {
            this.overlay.show_message(_root.strings.EmbeddingNotAllowed);
            this.stopAll();
         }
         else if(_loc3_.embed_status == "restricted")
         {
            this.overlay.show_message(_root.strings.VideoUnavailable);
            this.stopAll();
         }
         this.api_loaded = true;
      }
   }
   function Mute()
   {
      this.sound_data.mute = true;
      this.audio.setVolume(0);
      this.onShowMute();
      this.sound_data_so.flush();
   }
   function setInfringeMute()
   {
      this.is_infringe_mute = true;
   }
   function unMute()
   {
      if(!this.is_infringe_mute)
      {
         this.sound_data.mute = false;
         this.audio.setVolume(this.sound_data.volume);
         this.onShowVolume(this.sound_data.volume);
         this.sound_data_so.flush();
      }
   }
   function use_master_sound(master_movie)
   {
      this.sound_data = new Object();
      this.sound_data_so = undefined;
      var _loc2_ = master_movie.sound_data;
      this.sound_data = {mute:_loc2_.mute,volume:_loc2_.volume};
      if(this.sound_data.mute)
      {
         this.Mute();
      }
      else
      {
         this.unMute();
      }
   }
   function toggleMute()
   {
      if(this.sound_data.mute)
      {
         this.unMute();
      }
      else
      {
         this.Mute();
      }
   }
   function setVolume(v)
   {
      if(!this.is_infringe_mute)
      {
         this.sound_data.volume = v;
         this.sound_data.mute = false;
         this.audio.setVolume(this.sound_data.volume);
         this.onShowVolume(this.sound_data.volume);
         this.sound_data_so.flush();
      }
   }
   function setSeekRatio(ratio)
   {
      this.setSeek(ratio * this.movieTime);
   }
   function getTotalTime()
   {
      return this.movieTime;
   }
   function getCurrentTime()
   {
      return this.ns.time;
   }
   function findCue(t)
   {
      if(this.loader.cues)
      {
         var _loc3_ = this.loader.cues;
         var _loc2_ = 0;
         while(_loc2_ < _loc3_.times.length)
         {
            var _loc4_ = _loc2_ + 1;
            if(_loc3_.times[_loc2_] <= t && (_loc3_.times[_loc4_] >= t || _loc4_ == _loc3_.times.length))
            {
               return {time:_loc3_.times[_loc2_],position:_loc3_.positions[_loc2_]};
            }
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function setSeek(s)
   {
      delete this.init_seek;
      if(s != undefined)
      {
         var _loc2_ = this.findCue(s);
         if(_loc2_)
         {
            var _loc4_ = 100;
            if(_loc2_.position > this.loader.start_pos + this.ns.bytesLoaded + _loc4_ || _loc2_.position < this.loader.start_pos - _loc4_)
            {
               if(!this.loader.loadOffset(_loc2_.time,_loc2_.position))
               {
                  this.ns.seek(s);
               }
            }
            else
            {
               this.ns.seek(s);
            }
         }
         else
         {
            this.ns.seek(s);
         }
         this.onSeek(this.getStartRatio(),this.getSeekRatio());
         if(this.tracker)
         {
            this.tracker.doSetTrack(this.getTime(),this.getSeekRatio());
         }
         this.is_peeking = false;
         this.ns.pause(!this.is_playing);
      }
   }
   function peekSeekRatio(r)
   {
      this.restart = false;
      this.is_peeking = true;
      this.hideEnded();
      this.ns.seek(r * this.movieTime);
      this.onSeek(this.getStartRatio(),this.getSeekRatio());
   }
   function getLoadRatio()
   {
      if(!this.loader.started)
      {
         return 0;
      }
      var _loc3_ = this.ns.bytesLoaded + this.loader.start_pos;
      var _loc2_ = this.ns.bytesTotal + this.loader.start_pos;
      if(_loc2_ == 0)
      {
         return 0;
      }
      if(_loc3_ == _loc2_ && _loc3_ > 1000)
      {
         return 1;
      }
      return _loc3_ / _loc2_;
   }
   function getSeekRatio()
   {
      if(this.restart == true)
      {
         return 0;
      }
      if(this.loader.delay_progress || !this.loader.started)
      {
         return this.loader.start_time / this.movieTime;
      }
      if(this.ns.time > this.movieTime)
      {
         return 1;
      }
      return this.ns.time / this.movieTime;
   }
   function getStartRatio()
   {
      if(this.loader.start_time == undefined)
      {
         return 0;
      }
      if(this.loader.start_time > this.movieTime)
      {
         return 1;
      }
      return this.loader.start_time / this.movieTime;
   }
   function getTime()
   {
      return this.ns.time;
   }
   function onEnterFrame()
   {
      var _loc4_ = this.getStartRatio();
      var _loc3_ = this.getSeekRatio();
      var _loc2_ = this.getTime();
      this.onSeek(_loc4_,_loc3_);
      this.onProgress(_loc4_,this.getLoadRatio());
      this.max_seek_ratio = Math.max(this.max_seek_ratio,_loc3_);
      if(_loc3_ > 0.8 && this.load_awsome)
      {
         this.end_screen.load_for_awsome();
         this.load_awsome = false;
      }
      if(this.tracker)
      {
         this.tracker.doTrack(_loc2_,_loc3_);
      }
      if(this.init_run)
      {
         this.initController();
         this.init_run = false;
      }
      else if(this.ns.bytesTotal > 0 && this.ns.bytesLoaded == this.ns.bytesTotal && _loc2_ >= this.movieTime - 1 && this.is_playing && !this.is_peeking)
      {
         if(this.lastTime != _loc2_)
         {
            this.lastTime = _loc2_;
            this.stallCount = 0;
         }
         else if(this.stallCount < 30)
         {
            this.stallCount = this.stallCount + 1;
         }
         else
         {
            this.endMovie();
            this.stallCount = 0;
         }
      }
   }
   function resizeNormal()
   {
      this.videoDisplay._height = this.overlay._height;
      this.videoDisplay._width = this.overlay._width;
      this.videoDisplay._x = this.videoDisplay._width / -2;
      this.videoDisplay._y = this.videoDisplay._height / -2;
   }
   function resizeOriginal()
   {
      this.videoDisplay._height = this.videoDisplay.height;
      this.videoDisplay._width = this.videoDisplay.width;
      this.videoDisplay._x = this.videoDisplay._width / -2;
      this.videoDisplay._y = this.videoDisplay._height / -2;
   }
   function resize(w, h)
   {
      if(!this.is_embed)
      {
         this.clear();
         this.beginFill(0);
         var _loc5_ = -1 * w / 2;
         var _loc4_ = -1 * h / 2;
         this.moveTo(_loc5_,_loc4_);
         this.lineTo(_loc5_ + w,_loc4_);
         this.lineTo(_loc5_ + w,_loc4_ + h);
         this.lineTo(_loc5_,_loc4_ + h);
         this.lineTo(_loc5_,_loc4_);
         this.endFill();
      }
      var _loc6_ = w / h;
      if(_loc6_ > this.display_ratio)
      {
         w = h * this.display_ratio;
      }
      else
      {
         h = w / this.display_ratio;
      }
      this.videoDisplay._width = w;
      this.videoDisplay._height = h;
      this.videoDisplay._x = -1 * w / 2;
      this.videoDisplay._y = -1 * h / 2;
      this.bg._width = w;
      this.bg._height = h;
      this.overlay.resize(w,h);
      this.end_screen.resize(w,h);
   }
   function updateJsApi()
   {
      _root.duration = this.movieTime;
      _root.currentTime = this.ns.time;
      _root.totalBytes = this.ns.bytesTotal;
      _root.totalBytesLoaded = this.ns.bytesLoaded;
      _root.isPlaying = this.is_playing;
      if(_root.seekTo != null)
      {
         this.setSeek(parseInt(_root.seekTo));
         _root.seekTo = null;
      }
      if(_root.pauseMovie != null)
      {
         com.google.youtube.debug.Debug.info("Pause: " + _root.pauseMovie,"Movie");
         this.is_playing = _root.pauseMovie != "true" ? true : false;
         if(!this.is_playing)
         {
            this.pauseMovie();
         }
         else
         {
            com.google.youtube.debug.Debug.info("Restarting paused movie","Movie");
            this.playMovie();
         }
         _root.pauseMovie = null;
      }
   }
}
