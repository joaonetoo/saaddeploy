"undefined"==typeof jQuery.migrateMute&&(jQuery.migrateMute=!0),function(t,e,n){function i(n){var i=e.console;o[n]||(o[n]=!0,t.migrateWarnings.push(n),i&&i.warn&&!t.migrateMute&&(i.warn("JQMIGRATE: "+n),t.migrateTrace&&i.trace&&i.trace()))}function r(e,n,r,o){if(Object.defineProperty)try{return void Object.defineProperty(e,n,{configurable:!0,enumerable:!0,get:function(){return i(o),r},set:function(t){i(o),r=t}})}catch(t){}t._definePropertyBroken=!0,e[n]=r}t.migrateVersion="1.4.1";var o={};t.migrateWarnings=[],e.console&&e.console.log&&e.console.log("JQMIGRATE: Migrate is installed"+(t.migrateMute?"":" with logging active")+", version "+t.migrateVersion),t.migrateTrace===n&&(t.migrateTrace=!0),t.migrateReset=function(){o={},t.migrateWarnings.length=0},"BackCompat"===document.compatMode&&i("jQuery is not compatible with Quirks Mode");var a=t("<input/>",{size:1}).attr("size")&&t.attrFn,s=t.attr,l=t.attrHooks.value&&t.attrHooks.value.get||function(){return null},c=t.attrHooks.value&&t.attrHooks.value.set||function(){return n},u=/^(?:input|button)$/i,h=/^[238]$/,f=/^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i,d=/^(?:checked|selected)$/i;r(t,"attrFn",a||{},"jQuery.attrFn is deprecated"),t.attr=function(e,r,o,l){var c=r.toLowerCase(),p=e&&e.nodeType;return l&&(s.length<4&&i("jQuery.fn.attr( props, pass ) is deprecated"),e&&!h.test(p)&&(a?r in a:t.isFunction(t.fn[r])))?t(e)[r](o):("type"===r&&o!==n&&u.test(e.nodeName)&&e.parentNode&&i("Can't change the 'type' of an input or button in IE 6/7/8"),!t.attrHooks[c]&&f.test(c)&&(t.attrHooks[c]={get:function(e,i){var r,o=t.prop(e,i);return o===!0||"boolean"!=typeof o&&(r=e.getAttributeNode(i))&&r.nodeValue!==!1?i.toLowerCase():n},set:function(e,n,i){var r;return n===!1?t.removeAttr(e,i):(r=t.propFix[i]||i,r in e&&(e[r]=!0),e.setAttribute(i,i.toLowerCase())),i}},d.test(c)&&i("jQuery.fn.attr('"+c+"') might use property instead of attribute")),s.call(t,e,r,o))},t.attrHooks.value={get:function(t,e){var n=(t.nodeName||"").toLowerCase();return"button"===n?l.apply(this,arguments):("input"!==n&&"option"!==n&&i("jQuery.fn.attr('value') no longer gets properties"),e in t?t.value:null)},set:function(t,e){var n=(t.nodeName||"").toLowerCase();return"button"===n?c.apply(this,arguments):("input"!==n&&"option"!==n&&i("jQuery.fn.attr('value', val) no longer sets properties"),void(t.value=e))}};var p,g,m=t.fn.init,v=t.find,y=t.parseJSON,w=/^\s*</,b=/\[(\s*[-\w]+\s*)([~|^$*]?=)\s*([-\w#]*?#[-\w#]*)\s*\]/,x=/\[(\s*[-\w]+\s*)([~|^$*]?=)\s*([-\w#]*?#[-\w#]*)\s*\]/g,_=/^([^<]*)(<[\w\W]+>)([^>]*)$/;t.fn.init=function(e,r,o){var a,s;return e&&"string"==typeof e&&!t.isPlainObject(r)&&(a=_.exec(t.trim(e)))&&a[0]&&(w.test(e)||i("$(html) HTML strings must start with '<' character"),a[3]&&i("$(html) HTML text after last tag is ignored"),"#"===a[0].charAt(0)&&(i("HTML string cannot start with a '#' character"),t.error("JQMIGRATE: Invalid selector string (XSS)")),r&&r.context&&r.context.nodeType&&(r=r.context),t.parseHTML)?m.call(this,t.parseHTML(a[2],r&&r.ownerDocument||r||document,!0),r,o):(s=m.apply(this,arguments),e&&e.selector!==n?(s.selector=e.selector,s.context=e.context):(s.selector="string"==typeof e?e:"",e&&(s.context=e.nodeType?e:r||document)),s)},t.fn.init.prototype=t.fn,t.find=function(t){var e=Array.prototype.slice.call(arguments);if("string"==typeof t&&b.test(t))try{document.querySelector(t)}catch(n){t=t.replace(x,function(t,e,n,i){return"["+e+n+'"'+i+'"]'});try{document.querySelector(t),i("Attribute selector with '#' must be quoted: "+e[0]),e[0]=t}catch(t){i("Attribute selector with '#' was not fixed: "+e[0])}}return v.apply(this,e)};var S;for(S in v)Object.prototype.hasOwnProperty.call(v,S)&&(t.find[S]=v[S]);t.parseJSON=function(t){return t?y.apply(this,arguments):(i("jQuery.parseJSON requires a valid JSON string"),null)},t.uaMatch=function(t){t=t.toLowerCase();var e=/(chrome)[ \/]([\w.]+)/.exec(t)||/(webkit)[ \/]([\w.]+)/.exec(t)||/(opera)(?:.*version|)[ \/]([\w.]+)/.exec(t)||/(msie) ([\w.]+)/.exec(t)||t.indexOf("compatible")<0&&/(mozilla)(?:.*? rv:([\w.]+)|)/.exec(t)||[];return{browser:e[1]||"",version:e[2]||"0"}},t.browser||(p=t.uaMatch(navigator.userAgent),g={},p.browser&&(g[p.browser]=!0,g.version=p.version),g.chrome?g.webkit=!0:g.webkit&&(g.safari=!0),t.browser=g),r(t,"browser",t.browser,"jQuery.browser is deprecated"),t.boxModel=t.support.boxModel="CSS1Compat"===document.compatMode,r(t,"boxModel",t.boxModel,"jQuery.boxModel is deprecated"),r(t.support,"boxModel",t.support.boxModel,"jQuery.support.boxModel is deprecated"),t.sub=function(){function e(t,n){return new e.fn.init(t,n)}t.extend(!0,e,this),e.superclass=this,e.fn=e.prototype=this(),e.fn.constructor=e,e.sub=this.sub,e.fn.init=function(i,r){var o=t.fn.init.call(this,i,r,n);return o instanceof e?o:e(o)},e.fn.init.prototype=e.fn;var n=e(document);return i("jQuery.sub() is deprecated"),e},t.fn.size=function(){return i("jQuery.fn.size() is deprecated; use the .length property"),this.length};var k=!1;t.swap&&t.each(["height","width","reliableMarginRight"],function(e,n){var i=t.cssHooks[n]&&t.cssHooks[n].get;i&&(t.cssHooks[n].get=function(){var t;return k=!0,t=i.apply(this,arguments),k=!1,t})}),t.swap=function(t,e,n,r){var o,a,s={};k||i("jQuery.swap() is undocumented and deprecated");for(a in e)s[a]=t.style[a],t.style[a]=e[a];o=n.apply(t,r||[]);for(a in e)t.style[a]=s[a];return o},t.ajaxSetup({converters:{"text json":t.parseJSON}});var C=t.fn.data;t.fn.data=function(e){var r,o,a=this[0];return!a||"events"!==e||1!==arguments.length||(r=t.data(a,e),o=t._data(a,e),r!==n&&r!==o||o===n)?C.apply(this,arguments):(i("Use of jQuery.fn.data('events') is deprecated"),o)};var T=/\/(java|ecma)script/i;t.clean||(t.clean=function(e,n,r,o){n=n||document,n=!n.nodeType&&n[0]||n,n=n.ownerDocument||n,i("jQuery.clean() is deprecated");var a,s,l,c,u=[];if(t.merge(u,t.buildFragment(e,n).childNodes),r)for(l=function(t){return!t.type||T.test(t.type)?o?o.push(t.parentNode?t.parentNode.removeChild(t):t):r.appendChild(t):void 0},a=0;null!=(s=u[a]);a++)t.nodeName(s,"script")&&l(s)||(r.appendChild(s),"undefined"!=typeof s.getElementsByTagName&&(c=t.grep(t.merge([],s.getElementsByTagName("script")),l),u.splice.apply(u,[a+1,0].concat(c)),a+=c.length));return u});var E=t.event.add,A=t.event.remove,I=t.event.trigger,R=t.fn.toggle,L=t.fn.live,D=t.fn.die,P=t.fn.load,M="ajaxStart|ajaxStop|ajaxSend|ajaxComplete|ajaxError|ajaxSuccess",O=new RegExp("\\b(?:"+M+")\\b"),N=/(?:^|\s)hover(\.\S+|)\b/,F=function(e){return"string"!=typeof e||t.event.special.hover?e:(N.test(e)&&i("'hover' pseudo-event is deprecated, use 'mouseenter mouseleave'"),e&&e.replace(N,"mouseenter$1 mouseleave$1"))};t.event.props&&"attrChange"!==t.event.props[0]&&t.event.props.unshift("attrChange","attrName","relatedNode","srcElement"),t.event.dispatch&&r(t.event,"handle",t.event.dispatch,"jQuery.event.handle is undocumented and deprecated"),t.event.add=function(t,e,n,r,o){t!==document&&O.test(e)&&i("AJAX events should be attached to document: "+e),E.call(this,t,F(e||""),n,r,o)},t.event.remove=function(t,e,n,i,r){A.call(this,t,F(e)||"",n,i,r)},t.each(["load","unload","error"],function(e,n){t.fn[n]=function(){var t=Array.prototype.slice.call(arguments,0);return"load"===n&&"string"==typeof t[0]?P.apply(this,t):(i("jQuery.fn."+n+"() is deprecated"),t.splice(0,0,n),arguments.length?this.bind.apply(this,t):(this.triggerHandler.apply(this,t),this))}}),t.fn.toggle=function(e,n){if(!t.isFunction(e)||!t.isFunction(n))return R.apply(this,arguments);i("jQuery.fn.toggle(handler, handler...) is deprecated");var r=arguments,o=e.guid||t.guid++,a=0,s=function(n){var i=(t._data(this,"lastToggle"+e.guid)||0)%a;return t._data(this,"lastToggle"+e.guid,i+1),n.preventDefault(),r[i].apply(this,arguments)||!1};for(s.guid=o;a<r.length;)r[a++].guid=o;return this.click(s)},t.fn.live=function(e,n,r){return i("jQuery.fn.live() is deprecated"),L?L.apply(this,arguments):(t(this.context).on(e,this.selector,n,r),this)},t.fn.die=function(e,n){return i("jQuery.fn.die() is deprecated"),D?D.apply(this,arguments):(t(this.context).off(e,this.selector||"**",n),this)},t.event.trigger=function(t,e,n,r){return n||O.test(t)||i("Global events are undocumented and deprecated"),I.call(this,t,e,n||document,r)},t.each(M.split("|"),function(e,n){t.event.special[n]={setup:function(){var e=this;return e!==document&&(t.event.add(document,n+"."+t.guid,function(){t.event.trigger(n,Array.prototype.slice.call(arguments,1),e,!0)}),t._data(this,n,t.guid++)),!1},teardown:function(){return this!==document&&t.event.remove(document,n+"."+t._data(this,n)),!1}}}),t.event.special.ready={setup:function(){this===document&&i("'ready' event is deprecated")}};var B=t.fn.andSelf||t.fn.addBack,j=t.fn.find;if(t.fn.andSelf=function(){return i("jQuery.fn.andSelf() replaced by jQuery.fn.addBack()"),B.apply(this,arguments)},t.fn.find=function(t){var e=j.apply(this,arguments);return e.context=this.context,e.selector=this.selector?this.selector+" "+t:t,e},t.Callbacks){var q=t.Deferred,z=[["resolve","done",t.Callbacks("once memory"),t.Callbacks("once memory"),"resolved"],["reject","fail",t.Callbacks("once memory"),t.Callbacks("once memory"),"rejected"],["notify","progress",t.Callbacks("memory"),t.Callbacks("memory")]];t.Deferred=function(e){var n=q(),r=n.promise();return n.pipe=r.pipe=function(){var e=arguments;return i("deferred.pipe() is deprecated"),t.Deferred(function(i){t.each(z,function(o,a){var s=t.isFunction(e[o])&&e[o];n[a[1]](function(){var e=s&&s.apply(this,arguments);e&&t.isFunction(e.promise)?e.promise().done(i.resolve).fail(i.reject).progress(i.notify):i[a[0]+"With"](this===r?i.promise():this,s?[e]:arguments)})}),e=null}).promise()},n.isResolved=function(){return i("deferred.isResolved is deprecated"),"resolved"===n.state()},n.isRejected=function(){return i("deferred.isRejected is deprecated"),"rejected"===n.state()},e&&e.call(n,n),n}}}(jQuery,window);