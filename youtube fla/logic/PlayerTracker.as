class logic.PlayerTracker
{
   var movie;
   var track_point;
   var track_tk;
   var google_tracker;
   function PlayerTracker(_m)
   {
      this.movie = _m;
      this.track_point = 0;
      this.track_tk = _root.tk;
      this.google_tracker = new logic.VideoStats("http://video-stats.video.google.com/s","yt",_root.plid,"detailpage",undefined,_root.sourceid,_root.sdetail,_root.q,_root.sk);
      var o = _m;
      this.google_tracker.getMediaTime = function()
      {
         return o.getTime();
      };
      this.google_tracker.getMediaDuration = function()
      {
         return o.getTotalTime();
      };
      this.google_tracker.getBytesDownloaded = function()
      {
         var _loc1_ = o.ns.bytesLoaded;
         if(isNaN(_loc1_))
         {
            return 0;
         }
         return _loc1_;
      };
      this.google_tracker.getBufferEmptyEvents = function()
      {
         return o.bufferEmptyCount;
      };
      this.google_tracker.getVideoDownloadRetries = function()
      {
         return o.videoDownloadRetries;
      };
   }
   function doSetTrack(time, percentage)
   {
   }
   function doTrack(time, percentage)
   {
      if(this.movie.getTotalTime() && !this.google_tracker.playbackStarted)
      {
         this.google_tracker.startPlayback(this.movie.video_id,this.movie.format,_root.sw);
      }
      if(isNaN(percentage) || !this.track_tk || !this.movie.isPlaying())
      {
         return undefined;
      }
      if(this.track_point < 1 && time >= 0)
      {
         this.sendTrack(time,percentage);
         this.track_point = 1;
      }
      else if(this.track_point < 2 && time >= 20)
      {
         this.sendTrack(time,percentage);
         this.track_point = 2;
      }
      else if(this.track_point < 3 && time >= 30)
      {
         this.sendTrack(time,percentage);
         this.track_point = 3;
      }
      else if(this.track_point < 4 && percentage >= 0.9)
      {
         this.sendTrack(time,percentage);
         this.track_point = 4;
      }
   }
   function doEndMovieTrack()
   {
      var _loc2_ = this.movie.getSeekRatio();
      var _loc3_ = this.movie.getTime();
      this.google_tracker.sendReport();
   }
   function endTrack()
   {
      this.google_tracker.endPlayback();
   }
   function sendTrack(time, percentage)
   {
      var _loc2_ = new logic.urlRestXML(this.movie.base_url);
      _loc2_.dispatch(this,undefined,undefined,"tracker",{w:1,tp:Math.floor(time),p:Math.round(percentage * 100),i:this.track_tk});
      this.google_tracker.sendWatchPoint();
   }
}
