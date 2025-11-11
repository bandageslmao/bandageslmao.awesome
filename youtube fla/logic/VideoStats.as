class logic.VideoStats
{
   var urlBase_;
   var namespace_;
   var plid_;
   var visitorId_;
   var sourceId_;
   var sourceDetail_;
   var query_;
   var eventLabel_;
   var playerStyle_;
   var playbackStarted_;
   var startTimes_;
   var endTimes_;
   var sendSegments_;
   var lastBufferEmptyEvents_;
   var thresholdCount_;
   var multipleInterval_;
   var eventReporter_;
   var sendDownloadData_;
   var startDownloadTime_;
   var startBytes_;
   var getBytesDownloaded;
   var endDownloadTime_;
   var lastBytes_;
   var downloadSampleTime_;
   var downloadSampleBytes_;
   var numSegments_;
   var numSegmentsSent_;
   var startTime_;
   var lastMediaTime_;
   var getMediaTime;
   var lastRealTime_;
   var segmentStart_;
   var sendInterval_;
   var sentInitialPing_;
   var sentTimeoutPing_;
   var sentFullPlayPing_;
   var mediaInterval_;
   var count_;
   var getMediaDuration;
   var getVideoDownloadRetries;
   var getBufferEmptyEvents;
   static var downloadPerfLoaded_;
   static var downloadPerf_;
   var MAX_REQ = 400;
   var BW_SAMPLE_SIZE = 1048576;
   var BW_MAX_SAMPLES = 3;
   var PLAYBACK_TIMEOUT = 5000;
   function VideoStats(urlBase, namespace, plid, eventLabel, playerStyle, sourceId, sourceDetail, query, visitorId)
   {
      this.urlBase_ = urlBase;
      this.namespace_ = namespace;
      this.plid_ = plid;
      this.visitorId_ = visitorId;
      this.sourceId_ = sourceId;
      this.sourceDetail_ = sourceDetail;
      this.query_ = query;
      this.eventLabel_ = eventLabel;
      this.playerStyle_ = playerStyle;
      this.playbackStarted_ = false;
      this.startTimes_ = new Array();
      this.endTimes_ = new Array();
      this.sendSegments_ = false;
      this.lastBufferEmptyEvents_ = 0;
      logic.VideoStats.downloadPerfLoaded_ = false;
      this.thresholdCount_ = 3;
      this.multipleInterval_ = 4;
   }
   function startPlayback(docid, format, sw)
   {
      if(this.playbackStarted_)
      {
         this.endPlayback();
      }
      this.playbackStarted_ = true;
      this.eventReporter_ = new logic.EventReporter(this.urlBase_);
      if(this.namespace_ != undefined && this.namespace_ != "")
      {
         this.eventReporter_.addGlobalParameters({ns:this.namespace_});
      }
      if(this.plid_ != undefined && this.plid_ != "")
      {
         this.eventReporter_.addGlobalParameters({plid:this.plid_});
      }
      if(this.sourceId_ != undefined && this.sourceId_ != "")
      {
         this.eventReporter_.addGlobalParameters({sourceid:escape(this.sourceId_)});
      }
      if(this.sourceDetail_ != undefined && this.sourceDetail_ != "")
      {
         this.eventReporter_.addGlobalParameters({sdetail:escape(this.sourceDetail_)});
      }
      if(this.query_ != undefined && this.query_ != "")
      {
         this.eventReporter_.addGlobalParameters({q:escape(this.query_)});
      }
      if(this.visitorId_ != undefined && this.visitorId_ != "")
      {
         this.eventReporter_.addGlobalParameters({vid:this.visitorId_});
      }
      this.eventReporter_.addGlobalParameters({docid:docid});
      if(sw != undefined)
      {
         this.eventReporter_.addGlobalParameters({sw:sw});
         this.sendSegments_ = true;
      }
      if(format != undefined)
      {
         this.eventReporter_.addGlobalParameters({fmt:format});
      }
      if(this.eventLabel_ != undefined && this.eventLabel_ != "")
      {
         this.eventReporter_.addGlobalParameters({el:this.eventLabel_});
      }
      if(this.playerStyle_ != undefined && this.playerStyle_ != "")
      {
         this.eventReporter_.addGlobalParameters({ps:this.playerStyle_});
      }
      logic.VideoStats.loadBandwidthData();
      var _loc3_ = 0;
      var _loc2_ = 0;
      for(var _loc4_ in logic.VideoStats.downloadPerf_)
      {
         _loc3_ += logic.VideoStats.downloadPerf_[_loc4_].bytes;
         _loc2_ += logic.VideoStats.downloadPerf_[_loc4_].time;
      }
      if(_loc3_ > 0 && _loc2_ > 0)
      {
         this.eventReporter_.addGlobalParameters({hbd:_loc3_});
         this.eventReporter_.addGlobalParameters({hbt:_loc2_});
      }
      this.sendDownloadData_ = false;
      this.startDownloadTime_ = getTimer();
      this.startBytes_ = this.getBytesDownloaded();
      this.endDownloadTime_ = this.startDownloadTime_;
      this.lastBytes_ = this.startBytes_;
      this.downloadSampleTime_ = 0;
      this.downloadSampleBytes_ = 0;
      this.numSegments_ = 0;
      this.numSegmentsSent_ = 0;
      this.startTime_ = this.startDownloadTime_;
      this.lastMediaTime_ = this.getMediaTime();
      this.lastRealTime_ = this.startTime_;
      this.segmentStart_ = this.lastMediaTime_;
      this.sendInterval_ = null;
      this.sentInitialPing_ = false;
      this.sentTimeoutPing_ = false;
      this.sentFullPlayPing_ = false;
      this.mediaInterval_ = setInterval(this,"mediaUpdate",100);
   }
   function endPlayback()
   {
      if(this.playbackStarted_)
      {
         this.playbackStarted_ = false;
         if(this.mediaInterval_ != null)
         {
            clearInterval(this.mediaInterval_);
         }
         if(this.sendInterval_ != null)
         {
            clearInterval(this.sendInterval_);
         }
         this.sendSegments();
         delete this.eventReporter_;
      }
   }
   function get playbackStarted()
   {
      return this.playbackStarted_;
   }
   function sendReport(forced)
   {
      this.addSegment();
      this.sendSegments(forced);
   }
   function onInterval()
   {
      if(this.count_ <= this.thresholdCount_ || (this.count_ - this.thresholdCount_) % this.multipleInterval_ == 0)
      {
         this.sendReport();
      }
      this.count_ = this.count_ + 1;
   }
   function mediaUpdate()
   {
      var _loc4_ = this.getBytesDownloaded();
      var _loc2_ = this.getMediaTime();
      var _loc3_ = getTimer();
      if(this.downloadSampleBytes_ < this.BW_SAMPLE_SIZE)
      {
         this.downloadSampleBytes_ += this.lastBytes_ - this.startBytes_;
         this.downloadSampleTime_ += (this.endDownloadTime_ - this.startDownloadTime_) / 1000;
         if(this.downloadSampleBytes_ >= this.BW_SAMPLE_SIZE)
         {
            var _loc6_ = new Object();
            _loc6_.bytes = this.downloadSampleBytes_;
            _loc6_.time = this.downloadSampleTime_;
            if(logic.VideoStats.downloadPerf_.length > this.BW_MAX_SAMPLES)
            {
               logic.VideoStats.downloadPerf_.shift();
            }
            logic.VideoStats.downloadPerf_.push(_loc6_);
            this.sendDownloadData_ = true;
            var _loc7_ = SharedObject.getLocal("videostats","/");
            if(_loc7_ != null)
            {
               _loc7_.data.perf = logic.VideoStats.downloadPerf_;
               _loc7_.flush();
            }
         }
      }
      if(this.sendSegments_ && !this.sentInitialPing_ && !this.sentTimeoutPing_ && _loc4_ == 0 && _loc3_ - this.startTime_ > this.PLAYBACK_TIMEOUT)
      {
         this.sentTimeoutPing_ = true;
         var _loc8_ = {st:_loc2_,et:_loc2_,pt:1,rt:(_loc3_ - this.startTime_) / 1000};
         this.setStandardArgs(_loc8_);
         this.eventReporter_.send(_loc8_);
      }
      if(!this.sentInitialPing_ && _loc2_ > 0)
      {
         this.sentInitialPing_ = true;
         _loc8_ = {st:_loc2_,et:_loc2_,rt:(_loc3_ - this.startTime_) / 1000,fv:escape(System.capabilities.version)};
         this.setStandardArgs(_loc8_);
         this.eventReporter_.send(_loc8_);
         this.count_ = 1;
         this.sendInterval_ = setInterval(this,"onInterval",10000);
      }
      if(this.startBytes_ == 0 || _loc4_ < this.lastBytes_)
      {
         this.startDownloadTime_ = _loc3_;
         this.endDownloadTime_ = _loc3_;
         this.startBytes_ = _loc4_;
      }
      else
      {
         var _loc10_ = _loc4_ - this.lastBytes_;
         if(_loc10_ > 0)
         {
            this.endDownloadTime_ = _loc3_;
         }
      }
      this.lastBytes_ = _loc4_;
      var _loc5_ = _loc2_ - this.lastMediaTime_;
      if(_loc5_ != 0)
      {
         var _loc9_ = _loc3_ - this.lastRealTime_;
         if(_loc5_ < 0 || _loc5_ > _loc9_ + 200)
         {
            this.addSegment();
            this.segmentStart_ = _loc2_;
         }
         this.lastRealTime_ = _loc3_;
      }
      this.lastMediaTime_ = _loc2_;
   }
   function setStandardArgs(args)
   {
      var _loc5_ = this.getMediaDuration();
      if(_loc5_ != undefined)
      {
         args.len = _loc5_;
      }
      if(this.getVideoDownloadRetries != undefined)
      {
         var _loc3_ = this.getVideoDownloadRetries();
         if(_loc3_ > 0)
         {
            args.retries = _loc3_;
         }
      }
      if(this.getBufferEmptyEvents != undefined)
      {
         var _loc4_ = this.getBufferEmptyEvents();
         args.nbe = _loc4_ - this.lastBufferEmptyEvents_;
         this.lastBufferEmptyEvents_ = _loc4_;
      }
      if(this.sendDownloadData_)
      {
         args.hcbd = logic.VideoStats.downloadPerf_[logic.VideoStats.downloadPerf_.length - 1].bytes;
         args.hcbt = logic.VideoStats.downloadPerf_[logic.VideoStats.downloadPerf_.length - 1].time;
         this.sendDownloadData_ = false;
      }
   }
   function addSegment()
   {
      if(this.numSegmentsSent_ > this.MAX_REQ)
      {
         return undefined;
      }
      if(this.lastMediaTime_ - this.segmentStart_ > 3)
      {
         this.startTimes_[this.numSegments_] = this.segmentStart_;
         this.endTimes_[this.numSegments_] = this.lastMediaTime_;
         this.numSegments_ = this.numSegments_ + 1;
         this.segmentStart_ = this.lastMediaTime_;
      }
   }
   function sendSegments(forced)
   {
      var _loc6_ = getTimer() - this.startTime_;
      if(this.numSegments_ > 0 || forced)
      {
         var _loc4_ = String(this.startTimes_[0]);
         var _loc3_ = String(this.endTimes_[0]);
         var _loc2_ = 1;
         while(_loc2_ < this.numSegments_)
         {
            _loc4_ += "," + String(this.startTimes_[_loc2_]);
            _loc3_ += "," + String(this.endTimes_[_loc2_]);
            _loc2_ = _loc2_ + 1;
         }
         if(this.sendSegments_ || forced)
         {
            var _loc5_ = {st:_loc4_,et:_loc3_,rt:_loc6_ / 1000,bc:this.lastBytes_,bd:this.lastBytes_ - this.startBytes_,bt:(this.endDownloadTime_ - this.startDownloadTime_) / 1000};
            this.setStandardArgs(_loc5_);
            this.eventReporter_.send(_loc5_);
         }
         this.startBytes_ = this.getBytesDownloaded();
         this.startDownloadTime_ = getTimer();
         this.endDownloadTime_ = this.startDownloadTime_;
         this.numSegmentsSent_ = this.numSegmentsSent_ + 1;
         this.numSegments_ = 0;
      }
   }
   function sendWatchPoint()
   {
      var _loc2_ = this.getMediaTime();
      this.eventReporter_.send({st:_loc2_,et:_loc2_,len:this.getMediaDuration(),rt:(getTimer() - this.startTime_) / 1000,yttk:1});
   }
   static function loadBandwidthData()
   {
      if(logic.VideoStats.downloadPerfLoaded_)
      {
         return undefined;
      }
      logic.VideoStats.downloadPerf_ = [];
      var _loc4_ = SharedObject.getLocal("videostats","/");
      if(_loc4_ != null && _loc4_.data.perf != undefined)
      {
         var _loc2_ = _loc4_.data.perf;
         for(var _loc3_ in _loc2_)
         {
            var _loc1_ = new Object();
            _loc1_.bytes = _loc2_[_loc3_].bytes;
            _loc1_.time = _loc2_[_loc3_].time;
            logic.VideoStats.downloadPerf_.push(_loc1_);
         }
      }
      logic.VideoStats.downloadPerfLoaded_ = true;
   }
   static function predictedBandwidthInBitsPerSecond()
   {
      logic.VideoStats.loadBandwidthData();
      var _loc2_ = 0;
      var _loc1_ = 0;
      for(var _loc3_ in logic.VideoStats.downloadPerf_)
      {
         _loc2_ += logic.VideoStats.downloadPerf_[_loc3_].bytes;
         _loc1_ += logic.VideoStats.downloadPerf_[_loc3_].time;
      }
      if(_loc1_ < 0.1)
      {
         return 0;
      }
      return _loc2_ * 8 / _loc1_ * 0.636717;
   }
}
