class logic.MovieLoader
{
   var delay_progress;
   var started;
   var nc;
   var ns;
   var interval_id;
   var movie;
   var wait_time;
   var format_string;
   var file;
   var append_vars;
   var movieTime;
   var start_pos;
   var start_time;
   var _load_start_time;
   var can_srub_to_offset;
   function MovieLoader()
   {
      this.delay_progress = false;
      this.started = false;
   }
   function initNetStream()
   {
      delete this.nc;
      delete this.ns;
      this.nc = new NetConnection();
      this.nc.connect(null);
      this.ns = new NetStream(this.nc);
      this.enableScrubToOffset();
      this.ns.setBufferTime(2);
      var o = this;
      this.ns.onMetaData = function(obj)
      {
         var _loc2_ = obj.duration;
         if(obj.totalduration != undefined)
         {
            _loc2_ = obj.totalduration;
         }
         if(_loc2_ != undefined)
         {
            o.movieTime = _loc2_;
            if(obj.keyframes)
            {
               o.cues = {times:obj.keyframes.times,positions:obj.keyframes.filepositions};
               o.resetScrubToOffset();
               if(o.movie.loader == o)
               {
                  o.movie.initSeek();
               }
            }
         }
         else
         {
            o.movieTime == undefined;
            o.cues = undefined;
         }
      };
      this.ns.onStatus = function(object)
      {
         if(object.code == "NetStream.Play.Stop")
         {
            if(o.movie.is_playing)
            {
               o.movie.endMovie();
            }
         }
         else if(object.code == "NetStream.Play.Start")
         {
            o.started = true;
            if(o.movie.loader == o)
            {
               o.movie.overlay.hide();
               o.movie.onDisplayMovie();
            }
         }
         else if(object.code == "NetStream.Buffer.Full")
         {
            o.delay_progress = false;
            if(o.movie.loader == o)
            {
               o.movie.onDisplayMovie();
               if(o.movieTime && o.movie.movieTime == undefined)
               {
                  o.movie.movieTime = o.movieTime;
               }
               else if(o.movie.movieTime == undefined && !o.api_loaded)
               {
                  o.movie.getMovieInfo();
               }
            }
         }
         else if(object.code == "NetStream.Play.StreamNotFound")
         {
            if(!o.timeout || o.timeout < getTimer() - o._start_load_time)
            {
               if(o.movie.is_embed && !o.movie.api_loaded)
               {
                  o.movie.getMovieInfo();
               }
               o.loadLater();
            }
            else
            {
               o.movie.onLoadError();
            }
         }
         else if(object.code == "NetStream.Buffer.Empty")
         {
            o.movie.bufferEmptyCount += 1;
         }
      };
   }
   function loadLater(waited)
   {
      if(this.interval_id)
      {
         clearInterval(this.interval_id);
         this.interval_id = undefined;
      }
      if(waited)
      {
         this.movie.videoDownloadRetries += 1;
         this._loadMovie();
         this.ns.pause(!(this.movie.loader == this && this.movie.is_playing));
      }
      else
      {
         this.interval_id = setInterval(this,"loadLater",this.wait_time * 1000,true);
         this.wait_time *= 5;
      }
   }
   function load(base_url, video_id, track_id, _append_vars, format)
   {
      var _loc2_ = base_url + "/videos/" + video_id + ".mp4?t=" + track_id;
      this.format_string = "";
      if(format)
      {
         this.format_string = "&fmt=" + format;
      }
      if(this.interval_id)
      {
         clearInterval(this.interval_id);
         this.interval_id = undefined;
      }
      if(_loc2_ != this.file)
      {
         this.append_vars = _append_vars;
         this.file = _loc2_;
         this.movieTime = undefined;
         this.wait_time = 5;
         this.started = false;
         this.start_pos = 0;
         this.start_time = 0;
         this.initNetStream();
      }
   }
   function setMovie(m)
   {
      this.movie = m;
   }
   function die()
   {
      this.started = false;
      this.ns.close();
      if(this.interval_id)
      {
         clearInterval(this.interval_id);
      }
   }
   function preLoad()
   {
      if(!this.started)
      {
         this.start_pos = 0;
         this.start_time = 0;
         this.ns.play(this.file + this.append_vars + this.format_string);
         this.ns.pause(true);
         this._load_start_time = getTimer();
      }
   }
   function start()
   {
      if(!this.started)
      {
         this.clearOffset();
         this.ns.play(this.file + this.append_vars + this.format_string);
         this._load_start_time = getTimer();
      }
   }
   function clearOffset()
   {
      if(this.start_pos)
      {
         this.start_pos = 0;
         this.start_time = 0;
         this.started = false;
         this.delay_progress = true;
      }
   }
   function loadOffset(_start_time, _pos)
   {
      if(this.start_pos != _pos && this.can_srub_to_offset)
      {
         this.start_pos = _pos;
         this.start_time = _start_time;
         this.started = false;
         this.delay_progress = true;
         this._loadMovie();
         return true;
      }
      return false;
   }
   function _loadMovie()
   {
      this.ns.play(this.file + this.append_vars + (!this.start_pos ? "" : "&start=" + this.start_pos) + this.format_string);
   }
   function isBuffered()
   {
      return this.ns.bufferLength > this.ns.bufferTime;
   }
   function enableScrubToOffset()
   {
      if(!_root.soff)
      {
         this.can_srub_to_offset = true;
      }
   }
   function resetScrubToOffset()
   {
      if(this.can_srub_to_offset && this.start_pos)
      {
         this.can_srub_to_offset = false;
         this.start_pos = 0;
         this.start_time = 0;
      }
   }
}
