class logic.NextVideoPanel extends MovieClip
{
   var clip1;
   var clip2;
   var load_next;
   var active_clip;
   var bg;
   var clip_bounds;
   var server;
   var data;
   var clip_index;
   var swap_clip;
   var clip3;
   var animate_interval_id;
   var title_field;
   var run_time;
   var view_count;
   var author;
   var from_txt;
   var views_txt;
   var stars;
   var loaded;
   var paused;
   var clip_interval_id;
   var MAX_LIFE = 200;
   function NextVideoPanel()
   {
      super();
      this._visible = false;
      this.clip1._visible = false;
      this.clip2._visible = false;
      this.load_next = undefined;
      this.active_clip = this.clip1;
      this.bg._alpha = 30;
      this.clip_bounds = this.clip1.getBounds(this.clip1._parent);
      this.server = this._parent;
   }
   function load(next_data)
   {
      this.load_next = next_data;
   }
   function load_data(d)
   {
      this.data = d;
      if(this.data == undefined)
      {
         this._visible = false;
         return undefined;
      }
      this.clip_index = 1;
      this.active_clip = this.swap_clip = this.clip2;
      logic.Util.loadImgClip(this.clip2,this.data.thumbnail_url2,this,this.clip_bounds);
      this.clip1._visible = false;
      this.clip2._visible = false;
      this.clip3._visible = false;
      this.clip1.loaded = false;
      this.clip2.loaded = false;
      this.clip3.loaded = false;
      clearInterval(this.animate_interval_id);
      this.animate_interval_id = undefined;
      this.title_field.text = "";
      this.run_time.text = "";
      this.view_count.text = "";
      this.author.text = "";
      this.from_txt.autoSize = "left";
      this.from_txt.text = _root.strings.From;
      this.author._x = this.from_txt._x + this.from_txt._width + 2;
      this.views_txt.autoSize = "left";
      this.view_count._x = this.views_txt._x + this.views_txt._width + 2;
      this.views_txt.text = _root.strings.Views;
      com.google.youtube.debug.Debug.info("moving txt: " + this.view_count._x,"EndScreen");
      this.stars.setStars(0);
      this.bg._alpha = 30;
      this.loaded = false;
   }
   function makeActiveClip(c)
   {
      this.swap_clip = c;
      this.swap_clip._visible = true;
      if(this.active_clip != this.swap_clip)
      {
         this.swap_clip._alpha = 0;
      }
      else
      {
         this.swap_clip._alpha = 100;
      }
   }
   function onClipLoaded(clip, error)
   {
      this._visible = true;
      if(!error)
      {
         this.makeActiveClip(clip);
         clip.loaded = true;
      }
      if(!this.loaded)
      {
         this.loaded = true;
         this.animate_interval_id = setInterval(this,"animate",25);
         this.server.clip_loaded();
      }
   }
   function loadNextClip()
   {
      this.clip_index = (this.clip_index + 1) % 3;
      var _loc2_ = this["clip" + (this.clip_index + 1)];
      if(_loc2_.loaded)
      {
         this.makeActiveClip(_loc2_);
      }
      else
      {
         logic.Util.loadImgClip(_loc2_,this.data["thumbnail_url" + (this.clip_index + 1)],this,this.clip_bounds);
      }
   }
   function onEnterFrame()
   {
      if(this.load_next && !this.paused)
      {
         if(this._alpha > 0 && this.data)
         {
            this._alpha -= 10;
         }
         else
         {
            this._alpha = 100;
            this._visible = false;
            this.load_data(this.load_next);
            this.load_next = undefined;
         }
      }
      if(this.active_clip != this.swap_clip)
      {
         if(this.active_clip._alpha > 0)
         {
            this.active_clip._alpha -= 3;
            this.swap_clip._alpha = 100 - this.active_clip._alpha;
         }
         else
         {
            this.active_clip._visible = false;
            this.active_clip = this.swap_clip;
            this.active_clip._alpha = 100;
         }
      }
   }
   function animate()
   {
      if(this.title_field.text.length < this.data.title.length)
      {
      }
      this.title_field.text += this.data.title.charAt(this.title_field.text.length);
      if(this.run_time.text.length < this.data.run_time.length)
      {
      }
      this.run_time.text += this.data.run_time.charAt(this.run_time.text.length);
      if(this.view_count.text.length < this.data.view_count.length)
      {
      }
      this.view_count.text += this.data.view_count.charAt(this.view_count.text.length);
      if(this.author.text.length < this.data.author.length)
      {
      }
      this.author.text += this.data.author.charAt(this.author.text.length);
      if(this.stars.value < Number(this.data.rating))
      {
      }
      this.stars.setStars(this.stars.value + 0.1);
   }
   function onRelease()
   {
      if(this.data.t && (_root.fs || Stage.displayState == "fullScreen"))
      {
         this._parent.movie.setMovie(this.data.id,undefined,undefined,this.data.length,this.data.t,undefined,"&fsnext=1");
         this._parent.movie.playMovie();
      }
      else
      {
         §§push(this.getURL(this.data.url + "&NR=1","_self"));
      }
   }
   function setTextNormal(c)
   {
      this.title_field.textColor = 6724044;
      this.run_time.textColor = 10066329;
      this.view_count.textColor = 6724044;
      this.author.textColor = 6724044;
      this.author.textColor = 6724044;
   }
   function setTextHighlight()
   {
      this.title_field.textColor = 10079487;
      this.run_time.textColor = 13421772;
      this.view_count.textColor = 10079487;
      this.author.textColor = 10079487;
      this.author.textColor = 10079487;
   }
   function onRollOver()
   {
      this._alpha = 100;
      this.bg._alpha = 50;
      this.paused = true;
      this.server.pause();
      this.setTextHighlight();
      if(this.swap_clip == this.active_clip)
      {
         this.loadNextClip();
      }
      this.clip_interval_id = setInterval(this,"loadNextClip",3000);
   }
   function onRollOut()
   {
      this.bg._alpha = 30;
      this.paused = false;
      this.server.unpause();
      this.setTextNormal();
      clearInterval(this.clip_interval_id);
   }
}
