class logic.LayoutManager
{
   var bounds_clip;
   var rel_clip;
   var layout_objects;
   var _show;
   var current_bounds;
   static var TOP = 2;
   static var BOTTOM = 4;
   static var V_CENTER = 0;
   static var H_CENTER = 0;
   static var RIGHT = 32;
   static var LEFT = 64;
   static var H_MASK = 240;
   static var V_MASK = 15;
   function LayoutManager(_bounds_clip, _rel_clip)
   {
      this.bounds_clip = _bounds_clip;
      this.rel_clip = _rel_clip;
      this.layout_objects = [];
      this._show = true;
      this.setBounds();
   }
   function setBounds(bounds)
   {
      if(bounds)
      {
         this.current_bounds = bounds;
      }
      else
      {
         this.current_bounds = this.bounds_clip.getBounds(this.rel_clip);
      }
   }
   function isRel(point, dir)
   {
      return point.indexOf(dir) > -1;
   }
   static function getBounds(object)
   {
      var _loc1_ = object.getBounds(object);
      if(!_loc1_)
      {
         _loc1_ = {xMin:0,yMin:0,xMax:object._width,yMax:object._height};
      }
      return _loc1_;
   }
   static function getRelY(object)
   {
      if(object._fixed)
      {
         return 0;
      }
      var _loc1_ = logic.LayoutManager.getBounds(object);
      if(object._rel & logic.LayoutManager.TOP)
      {
         return - _loc1_.yMin;
      }
      if(object._rel & logic.LayoutManager.BOTTOM)
      {
         return - _loc1_.yMax;
      }
      if(object._rel & logic.LayoutManager.V_CENTER)
      {
         return (- (_loc1_.yMin + _loc1_.yMax)) / 2;
      }
   }
   static function getRelX(object)
   {
      if(object._fixed)
      {
         return 0;
      }
      var _loc1_ = logic.LayoutManager.getBounds(object);
      if(object._rel & logic.LayoutManager.LEFT)
      {
         return - _loc1_.xMin;
      }
      if(object._rel & logic.LayoutManager.RIGHT)
      {
         return - _loc1_.xMax;
      }
      if(object._rel & logic.LayoutManager.H_CENTER)
      {
         return (- (_loc1_.xMin + _loc1_.xMax)) / 2;
      }
   }
   function registerObject(object, rel_layout, fixed)
   {
      object._rel = rel_layout;
      object._fixed = fixed;
      switch(rel_layout & logic.LayoutManager.V_MASK)
      {
         case logic.LayoutManager.TOP:
            object._yoffset = this.current_bounds.yMin - (object._y + logic.LayoutManager.getRelY(object));
            break;
         case logic.LayoutManager.BOTTOM:
            object._yoffset = this.current_bounds.yMax - (object._y + logic.LayoutManager.getRelY(object));
            break;
         case logic.LayoutManager.V_CENTER:
            object._yoffset = (this.current_bounds.yMax + this.current_bounds.yMin) / 2 - (object._y + logic.LayoutManager.getRelY(object));
      }
      switch(rel_layout & logic.LayoutManager.H_MASK)
      {
         case logic.LayoutManager.LEFT:
            object._xoffset = this.current_bounds.xMin - (object._x + logic.LayoutManager.getRelX(object));
            break;
         case logic.LayoutManager.RIGHT:
            object._xoffset = this.current_bounds.xMax - (object._x + logic.LayoutManager.getRelX(object));
            break;
         case logic.LayoutManager.H_CENTER:
            object._xoffset = (this.current_bounds.xMax + this.current_bounds.xMin) / 2 - (object._x + logic.LayoutManager.getRelX(object));
      }
      this.layout_objects.push(object);
   }
   function layoutObject(object)
   {
      var _loc3_ = object._rel;
      switch(_loc3_ & logic.LayoutManager.V_MASK)
      {
         case logic.LayoutManager.TOP:
            object._y = this.current_bounds.yMin - (object._yoffset + logic.LayoutManager.getRelY(object));
            break;
         case logic.LayoutManager.BOTTOM:
            object._y = this.current_bounds.yMax - (object._yoffset + logic.LayoutManager.getRelY(object));
            break;
         case logic.LayoutManager.V_CENTER:
            object._y = (this.current_bounds.yMax + this.current_bounds.yMin) / 2 - (object._yoffset + logic.LayoutManager.getRelY(object));
      }
      switch(_loc3_ & logic.LayoutManager.H_MASK)
      {
         case logic.LayoutManager.LEFT:
            object._x = this.current_bounds.xMin - (object._xoffset + logic.LayoutManager.getRelX(object));
            break;
         case logic.LayoutManager.RIGHT:
            object._x = this.current_bounds.xMax - (object._xoffset + logic.LayoutManager.getRelX(object));
            break;
         case logic.LayoutManager.H_CENTER:
            object._x = (this.current_bounds.xMax + this.current_bounds.xMin) / 2 - (object._xoffset + logic.LayoutManager.getRelX(object));
      }
   }
   function layoutObjects(new_bounds)
   {
      this.setBounds(new_bounds);
      var _loc2_ = 0;
      while(_loc2_ < this.layout_objects.length)
      {
         this.layoutObject(this.layout_objects[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function hideObjects()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.layout_objects.length)
      {
         this.layout_objects[_loc2_]._visible = false;
         _loc2_ = _loc2_ + 1;
      }
      this._show = false;
   }
   function showObjects()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.layout_objects.length)
      {
         if(!this.layout_objects[_loc2_]._hide)
         {
            this.layout_objects[_loc2_]._visible = true;
         }
         _loc2_ = _loc2_ + 1;
      }
      this._show = true;
   }
   function permHide(object)
   {
      object._visible = false;
      object._hide = true;
   }
   function permShow(object)
   {
      object._visible = this._show;
      delete object._hide;
   }
}
