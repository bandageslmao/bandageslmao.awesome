class logic.restXML
{
   var request_url;
   var pr;
   var call_location = "api2_rest?method=";
   function restXML(_req_url)
   {
      this.request_url = _req_url;
   }
   function get_call_string(method)
   {
      return this.call_location + escape(method);
   }
   function dispatch(dispatcher, cb, cb_error, method, params)
   {
      var _loc5_ = new XML();
      var _loc7_ = new XML();
      _loc7_.ignoreWhite = false;
      _loc5_.ignoreWhite = true;
      if(_root.auth_code != undefined)
      {
         _loc7_.addRequestHeader("Authorization",_root.auth_code);
      }
      var _loc3_ = this.get_call_string(method);
      for(var _loc6_ in params)
      {
         if(_loc3_.indexOf("?") == -1)
         {
            _loc3_ += "?";
         }
         else
         {
            _loc3_ += "&";
         }
         _loc3_ += _loc6_ + "=";
         _loc3_ += escape(params[_loc6_]);
      }
      var _loc8_ = this.request_url + _loc3_;
      _loc5_.pr = this;
      _loc5_.dispatcher = dispatcher;
      _loc5_.cb = cb;
      _loc5_.cb_error = cb_error;
      _loc5_.onLoad = function(success)
      {
         this.pr.parse_dispatch_xml(this,success);
      };
      _loc7_.sendAndLoad(_loc8_,_loc5_);
   }
   function parse_dispatch_xml(loader, success)
   {
      if(success)
      {
         var _loc3_ = this.process(loader);
         if(_loc3_.error)
         {
            loader.cb_error.call(loader.dispatcher,_loc3_.data);
         }
         else
         {
            loader.cb.call(loader.dispatcher,_loc3_.data);
         }
      }
      else
      {
         loader.cb_error.call(loader.dispatcher);
      }
   }
   function process(xml_rsp)
   {
      var _loc1_ = {};
      var _loc2_ = logic.restXML.get_sub_node("ut_response",xml_rsp);
      if(_loc2_.attributes.status == "ok")
      {
         _loc1_.data = logic.restXML.get_dict(_loc2_);
      }
      else if(_loc2_.attributes.status == "fail")
      {
         var _loc3_ = logic.restXML.get_dict(_loc2_);
         _loc1_.data = logic.restXML.get_dict(_loc3_.error);
         _loc1_.error = true;
      }
      else
      {
         _loc1_.error = true;
      }
      return _loc1_;
   }
   static function get_dict(node)
   {
      if(!node)
      {
         return undefined;
      }
      var _loc4_ = new Object();
      var _loc2_ = 0;
      while(_loc2_ < node.childNodes.length)
      {
         var _loc1_ = node.childNodes[_loc2_];
         if(_loc1_.nodeType == 1)
         {
            var _loc3_ = _loc1_.childNodes[0];
            if(_loc3_.nodeType == 3)
            {
               _loc4_[_loc1_.nodeName] = logic.restXML.strip_white_space(_loc3_.nodeValue);
            }
            else
            {
               _loc4_[_loc1_.nodeName] = _loc1_;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   static function get_sub_array(name, node)
   {
      if(!node)
      {
         return undefined;
      }
      var _loc4_ = [];
      var _loc1_ = 0;
      while(_loc1_ < node.childNodes.length)
      {
         var _loc2_ = node.childNodes[_loc1_];
         if(_loc2_.nodeName == name)
         {
            _loc4_.push(_loc2_);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc4_;
   }
   static function get_sub_node(name, node)
   {
      var _loc2_ = node.childNodes;
      for(var _loc4_ in _loc2_)
      {
         var _loc1_ = _loc2_[_loc4_];
         if(_loc1_.nodeType == 1 and _loc1_.nodeName == name)
         {
            return _loc1_;
         }
      }
   }
   static function get_sub_text(name, node)
   {
      var _loc1_ = logic.restXML.get_sub_node(name,node);
      var _loc2_ = _loc1_.childNodes;
      for(var _loc3_ in _loc2_)
      {
         _loc1_ = _loc2_[_loc3_];
         if(_loc1_.nodeType == 3)
         {
            return logic.restXML.strip_white_space(_loc1_.nodeValue);
         }
      }
   }
   static function add_text_node(name, value, node)
   {
      var _loc2_ = new XML();
      var _loc1_ = _loc2_.createElement(name);
      _loc1_.appendChild(_loc2_.createTextNode(value));
      node.appendChild(_loc1_);
   }
   static function is_whitespace(c)
   {
      return c == " " || c == "\n" || c == "\t";
   }
   static function strip_white_space(buffer)
   {
      var _loc4_ = 0;
      var _loc3_ = buffer.length - 1;
      var _loc1_ = 0;
      while(_loc1_ < buffer.length)
      {
         if(_loc4_ == _loc1_ && logic.restXML.is_whitespace(buffer.charAt(_loc4_)))
         {
            _loc4_ = _loc4_ + 1;
         }
         if(_loc3_ == buffer.length - (_loc1_ + 1) && logic.restXML.is_whitespace(buffer.charAt(_loc3_)))
         {
            _loc3_ = _loc3_ - 1;
         }
         if(!(_loc4_ == _loc1_ + 1 || _loc3_ == buffer.length - (_loc1_ + 2)))
         {
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      return buffer.slice(_loc4_,_loc3_ + 1);
   }
}
