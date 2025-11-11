class com.google.chianti.event.EventDelegate extends Object
{
   function EventDelegate()
   {
      super();
   }
   static function create(scope, handler, data)
   {
      var _loc2_ = function()
      {
         arguments.push(data);
         return handler.apply(scope,arguments);
      };
      _loc2_.scope = scope;
      return _loc2_;
   }
}
