/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
!function(){function e(e){return e.type==CKEDITOR.NODE_TEXT&&e.getLength()>0&&(!n||!e.isReadOnly())}function t(e){return!(e.type==CKEDITOR.NODE_ELEMENT&&e.isBlockBoundary(CKEDITOR.tools.extend({},CKEDITOR.dtd.$empty,CKEDITOR.dtd.$nonEditable)))}function a(e){var t,a,n,i;t="find"===e?1:0,a=1-t;var s,l=r.length;for(s=0;l>s;s++)n=this.getContentElement(o[t],r[s][t]),i=this.getContentElement(o[a],r[s][a]),i.setValue(n.getValue())}var n,i=function(){var e=this;return{textNode:e.textNode,offset:e.offset,character:e.textNode?e.textNode.getText().charAt(e.offset):null,hitMatchBoundary:e._.matchBoundary}},o=["find","replace"],r=[["txtFindFind","txtFindReplace"],["txtFindCaseChk","txtReplaceCaseChk"],["txtFindWordChk","txtReplaceWordChk"],["txtFindCyclic","txtReplaceCyclic"]],s=function(o,r){function s(e,t){var a=new CKEDITOR.dom.range;return a.setStart(e.textNode,t?e.offset:e.offset+1),a.setEndAt(o.document.getBody(),CKEDITOR.POSITION_BEFORE_END),a}function l(e){var t=new CKEDITOR.dom.range;return t.setStartAt(o.document.getBody(),CKEDITOR.POSITION_AFTER_START),t.setEnd(e.textNode,e.offset),t}function d(e){var t,a=o.getSelection(),n=o.document.getBody();return a&&!e?(t=a.getRanges()[0].clone(),t.collapse(!0)):(t=new CKEDITOR.dom.range,t.setStartAt(n,CKEDITOR.POSITION_AFTER_START)),t.setEndAt(n,CKEDITOR.POSITION_BEFORE_END),t}var c=new CKEDITOR.style(CKEDITOR.tools.extend({attributes:{"data-cke-highlight":1},fullMatch:1,ignoreReadonly:1,childRule:function(){return 0}},o.config.find_highlight,!0)),u=function(a,n){var i=this,o=new CKEDITOR.dom.walker(a);o.guard=n?t:function(e){!t(e)&&(i._.matchBoundary=!0)},o.evaluator=e,o.breakOnFalse=1,a.startContainer.type==CKEDITOR.NODE_TEXT&&(this.textNode=a.startContainer,this.offset=a.startOffset-1),this._={matchWord:n,walker:o,matchBoundary:!1}};u.prototype={next:function(){return this.move()},back:function(){return this.move(!0)},move:function(e){var t=this,a=t.textNode;if(null===a)return i.call(t);if(t._.matchBoundary=!1,a&&e&&t.offset>0)return t.offset--,i.call(t);if(a&&t.offset<a.getLength()-1)return t.offset++,i.call(t);for(a=null;!(a||(a=t._.walker[e?"previous":"next"].call(t._.walker),t._.matchWord&&!a||t._.walker._.end)););return t.textNode=a,t.offset=a?e?a.getLength()-1:0:0,i.call(t)}};var p=function(e,t){this._={walker:e,cursors:[],rangeLength:t,highlightRange:null,isMatched:0}};p.prototype={toDomRange:function(){var e=new CKEDITOR.dom.range(o.document),t=this._.cursors;if(t.length<1){var a=this._.walker.textNode;if(!a)return null;e.setStartAfter(a)}else{var n=t[0],i=t[t.length-1];e.setStart(n.textNode,n.offset),e.setEnd(i.textNode,i.offset+1)}return e},updateFromDomRange:function(e){var t,a=this,n=new u(e);a._.cursors=[];do t=n.next(),t.character&&a._.cursors.push(t);while(t.character);a._.rangeLength=a._.cursors.length},setMatched:function(){this._.isMatched=!0},clearMatched:function(){this._.isMatched=!1},isMatched:function(){return this._.isMatched},highlight:function(){var e=this;if(!(e._.cursors.length<1)){e._.highlightRange&&e.removeHighlight();var t=e.toDomRange(),a=t.createBookmark();c.applyToRange(t),t.moveToBookmark(a),e._.highlightRange=t;var n=t.startContainer;n.type!=CKEDITOR.NODE_ELEMENT&&(n=n.getParent()),n.scrollIntoView(),e.updateFromDomRange(t)}},removeHighlight:function(){var e=this;if(e._.highlightRange){var t=e._.highlightRange.createBookmark();c.removeFromRange(e._.highlightRange),e._.highlightRange.moveToBookmark(t),e.updateFromDomRange(e._.highlightRange),e._.highlightRange=null}},isReadOnly:function(){return this._.highlightRange?this._.highlightRange.startContainer.isReadOnly():0},moveBack:function(){var e=this,t=e._.walker.back(),a=e._.cursors;return t.hitMatchBoundary&&(e._.cursors=a=[]),a.unshift(t),a.length>e._.rangeLength&&a.pop(),t},moveNext:function(){var e=this,t=e._.walker.next(),a=e._.cursors;return t.hitMatchBoundary&&(e._.cursors=a=[]),a.push(t),a.length>e._.rangeLength&&a.shift(),t},getEndCharacter:function(){var e=this._.cursors;return e.length<1?null:e[e.length-1].character},getNextCharacterRange:function(e){var t,a,n=this._.cursors;return a=(t=n[n.length-1])&&t.textNode?new u(s(t)):this._.walker,new p(a,e)},getCursors:function(){return this._.cursors}};var m=0,h=1,g=2,f=function(e,t){var a=[-1];t&&(e=e.toLowerCase());for(var n=0;n<e.length;n++)for(a.push(a[n]+1);a[n+1]>0&&e.charAt(n)!=e.charAt(a[n+1]-1);)a[n+1]=a[a[n+1]-1]+1;this._={overlap:a,state:0,ignoreCase:!!t,pattern:e}};f.prototype={feedCharacter:function(e){var t=this;for(t._.ignoreCase&&(e=e.toLowerCase());;){if(e==t._.pattern.charAt(t._.state))return t._.state++,t._.state==t._.pattern.length?(t._.state=0,g):h;if(!t._.state)return m;t._.state=t._.overlap[t._.state]}return null},reset:function(){this._.state=0}};var v=/[.,"'?!;: \u0085\u00a0\u1680\u280e\u2028\u2029\u202f\u205f\u3000]/,b=function(e){if(!e)return!0;var t=e.charCodeAt(0);return t>=9&&13>=t||t>=8192&&8202>=t||v.test(e)},y={searchRange:null,matchRange:null,find:function(e,t,a,n,i,o){var r=this;r.matchRange?(r.matchRange.removeHighlight(),r.matchRange=r.matchRange.getNextCharacterRange(e.length)):r.matchRange=new p(new u(r.searchRange),e.length);for(var c=new f(e,!t),h=m,v="%";null!==v;){for(r.matchRange.moveNext();(v=r.matchRange.getEndCharacter())&&(h=c.feedCharacter(v),h!=g);)r.matchRange.moveNext().hitMatchBoundary&&c.reset();if(h==g){if(a){var y=r.matchRange.getCursors(),k=y[y.length-1],C=y[0],w=l(C),T=s(k);w.trim(),T.trim();var _=new u(w,!0),S=new u(T,!0);if(!b(_.back().character)||!b(S.next().character))continue}return r.matchRange.setMatched(),i!==!1&&r.matchRange.highlight(),!0}}return r.matchRange.clearMatched(),r.matchRange.removeHighlight(),n&&!o?(r.searchRange=d(1),r.matchRange=null,arguments.callee.apply(r,Array.prototype.slice.call(arguments).concat([!0]))):!1},replaceCounter:0,replace:function(e,t,a,i,r,s,l){var d=this;n=1;var c=0;if(d.matchRange&&d.matchRange.isMatched()&&!d.matchRange._.isReplaced&&!d.matchRange.isReadOnly()){d.matchRange.removeHighlight();var u=d.matchRange.toDomRange(),p=o.document.createText(a);if(!l){var m=o.getSelection();m.selectRanges([u]),o.fire("saveSnapshot")}u.deleteContents(),u.insertNode(p),l||(m.selectRanges([u]),o.fire("saveSnapshot")),d.matchRange.updateFromDomRange(u),l||d.matchRange.highlight(),d.matchRange._.isReplaced=!0,d.replaceCounter++,c=1}else c=d.find(t,i,r,s,!l);return n=0,c}},k=o.lang.findAndReplace;return{title:k.title,resizable:CKEDITOR.DIALOG_RESIZE_NONE,minWidth:350,minHeight:170,buttons:[CKEDITOR.dialog.cancelButton],contents:[{id:"find",label:k.find,title:k.find,accessKey:"",elements:[{type:"hbox",widths:["230px","90px"],children:[{type:"text",id:"txtFindFind",label:k.findWhat,isChanged:!1,labelLayout:"horizontal",accessKey:"F"},{type:"button",id:"btnFind",align:"left",style:"width:100%",label:k.find,onClick:function(){var e=this.getDialog();y.find(e.getValueOf("find","txtFindFind"),e.getValueOf("find","txtFindCaseChk"),e.getValueOf("find","txtFindWordChk"),e.getValueOf("find","txtFindCyclic"))||alert(k.notFoundMsg)}}]},{type:"fieldset",label:CKEDITOR.tools.htmlEncode(k.findOptions),style:"margin-top:29px",children:[{type:"vbox",padding:0,children:[{type:"checkbox",id:"txtFindCaseChk",isChanged:!1,label:k.matchCase},{type:"checkbox",id:"txtFindWordChk",isChanged:!1,label:k.matchWord},{type:"checkbox",id:"txtFindCyclic",isChanged:!1,"default":!0,label:k.matchCyclic}]}]}]},{id:"replace",label:k.replace,accessKey:"M",elements:[{type:"hbox",widths:["230px","90px"],children:[{type:"text",id:"txtFindReplace",label:k.findWhat,isChanged:!1,labelLayout:"horizontal",accessKey:"F"},{type:"button",id:"btnFindReplace",align:"left",style:"width:100%",label:k.replace,onClick:function(){var e=this.getDialog();y.replace(e,e.getValueOf("replace","txtFindReplace"),e.getValueOf("replace","txtReplace"),e.getValueOf("replace","txtReplaceCaseChk"),e.getValueOf("replace","txtReplaceWordChk"),e.getValueOf("replace","txtReplaceCyclic"))||alert(k.notFoundMsg)}}]},{type:"hbox",widths:["230px","90px"],children:[{type:"text",id:"txtReplace",label:k.replaceWith,isChanged:!1,labelLayout:"horizontal",accessKey:"R"},{type:"button",id:"btnReplaceAll",align:"left",style:"width:100%",label:k.replaceAll,isChanged:!1,onClick:function(){var e=this.getDialog();for(y.replaceCounter=0,y.searchRange=d(1),y.matchRange&&(y.matchRange.removeHighlight(),y.matchRange=null),o.fire("saveSnapshot");y.replace(e,e.getValueOf("replace","txtFindReplace"),e.getValueOf("replace","txtReplace"),e.getValueOf("replace","txtReplaceCaseChk"),e.getValueOf("replace","txtReplaceWordChk"),!1,!0););y.replaceCounter?(alert(k.replaceSuccessMsg.replace(/%1/,y.replaceCounter)),o.fire("saveSnapshot")):alert(k.notFoundMsg)}}]},{type:"fieldset",label:CKEDITOR.tools.htmlEncode(k.findOptions),children:[{type:"vbox",padding:0,children:[{type:"checkbox",id:"txtReplaceCaseChk",isChanged:!1,label:k.matchCase},{type:"checkbox",id:"txtReplaceWordChk",isChanged:!1,label:k.matchWord},{type:"checkbox",id:"txtReplaceCyclic",isChanged:!1,"default":!0,label:k.matchCyclic}]}]}]}],onLoad:function(){var e,t,n=this,i=0;this.on("hide",function(){i=0}),this.on("show",function(){i=1}),this.selectPage=CKEDITOR.tools.override(this.selectPage,function(o){return function(r){o.call(n,r);var s,l,d,c=n._.tabs[r];l="find"===r?"txtFindFind":"txtFindReplace",d="find"===r?"txtFindWordChk":"txtReplaceWordChk",e=n.getContentElement(r,l),t=n.getContentElement(r,d),c.initialized||(s=CKEDITOR.document.getById(e._.inputId),c.initialized=!0),i&&a.call(this,r)}})},onShow:function(){var e=this;y.searchRange=d();var t=e.getParentEditor().getSelection().getSelectedText(),a="find"==r?"txtFindFind":"txtFindReplace",n=e.getContentElement(r,a);n.setValue(t),n.select(),e.selectPage(r),e[("find"==r&&e._.editor.readOnly?"hide":"show")+"Page"]("replace")},onHide:function(){var e;y.matchRange&&y.matchRange.isMatched()&&(y.matchRange.removeHighlight(),o.focus(),e=y.matchRange.toDomRange(),e&&o.getSelection().selectRanges([e])),delete y.matchRange},onFocus:function(){return"replace"==r?this.getContentElement("replace","txtFindReplace"):this.getContentElement("find","txtFindFind")}}};CKEDITOR.dialog.add("find",function(e){return s(e,"find")}),CKEDITOR.dialog.add("replace",function(e){return s(e,"replace")})}();