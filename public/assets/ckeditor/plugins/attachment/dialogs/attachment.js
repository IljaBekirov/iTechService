!function(){CKEDITOR.dialog.add("attachment",function(e){function t(e){var t=e.split("/").pop(),n=t.split(".").pop();return{filename:t,className:"attach_"+n}}var n=/^(_(?:self|top|parent|blank))$/,i=function(e,t){var i=t?t.getAttribute("_cke_saved_href")||t.getAttribute("href"):"",a={};if(a.type="url",a.url=i,t){var r=t.getAttribute("target");if(a.target={},r){var o=r.match(n);o?a.target.type=a.target.name=r:(a.target.type="frame",a.target.name=r)}a.title=t.getAttribute("title")}for(var s=e.document.getElementsByTag("img"),l=new CKEDITOR.dom.nodeList(e.document.$.anchors),c=a.anchors=[],d=0;d<s.count();d++){var u=s.getItem(d);u.getAttribute("_cke_realelement")&&"anchor"==u.getAttribute("_cke_real_element_type")&&c.push(e.restoreRealElement(u))}for(d=0;d<l.count();d++)c.push(l.getItem(d));for(d=0;d<c.length;d++)u=c[d],c[d]={name:u.getAttribute("name"),id:u.getAttribute("id")};return this._.selectedElement=t,a},a=function(){var t=this.getDialog(),n=t.getContentElement("general","linkTargetName"),i=this.getValue();n&&(n.setLabel(e.lang.link.targetFrameName),this.getDialog().setValueOf("general","linkTargetName","_"==i.charAt(0)?i:""))};return{title:e.lang.attachment.title,minWidth:420,minHeight:200,onShow:function(){this.fakeObj=!1;var e=this.getParentEditor(),t=e.getSelection(),n=t.getRanges(),a=null;if(1==n.length){var r=n[0].getCommonAncestor(!0);a=r.getAscendant("a",!0),a&&a.getAttribute("href")?t.selectElement(a):(a=r.getAscendant("img",!0))&&a.getAttribute("_cke_real_element_type")&&"anchor"==a.getAttribute("_cke_real_element_type")?(this.fakeObj=a,a=e.restoreRealElement(this.fakeObj),t.selectElement(this.fakeObj)):a=null}this.setupContent(i.apply(this,[e,a]))},onOk:function(){var e={href:"javascript:void(0)/*"+CKEDITOR.tools.getNextNumber()+"*/"},n=[],i={href:e.href},a=this.getParentEditor();this.commitContent(i);var r=i.url||"";e._cke_saved_href=0===r.indexOf("/")?r:"http://"+r;var o=t(r);if(i.title||"",e.title=0==i.title.length?o.filename:i.title,e["class"]=o.className,i.target&&("notSet"!=i.target.type&&i.target.name?e.target=i.target.name:n.push("target"),n.push("_cke_pa_onclick","onclick")),this._.selectedElement){var s=this._.selectedElement;if(CKEDITOR.env.ie&&e.name!=s.getAttribute("name")){var l=new CKEDITOR.dom.element('<a name="'+CKEDITOR.tools.htmlEncode(e.name)+'">',a.document);c=a.getSelection(),s.moveChildren(l),s.copyAttributes(l,{name:1}),l.replace(s),s=l,c.selectElement(s)}s.setAttributes(e),s.removeAttributes(n),s.getAttribute("title")&&s.setHtml(s.getAttribute("title")),s.getAttribute("name")?s.addClass("cke_anchor"):s.removeClass("cke_anchor"),this.fakeObj&&a.createFakeElement(s,"cke_anchor","anchor").replace(this.fakeObj),delete this._.selectedElement}else{var c=a.getSelection(),d=c.getRanges();if(1==d.length&&d[0].collapsed){var u=new CKEDITOR.dom.text(e.title,a.document);d[0].insertNode(u),d[0].selectNodeContents(u),c.selectRanges(d)}var h=new CKEDITOR.style({element:"a",attributes:e});h.type=CKEDITOR.STYLE_INLINE,h.apply(a.document)}},contents:[{label:e.lang.common.generalTab,id:"general",accessKey:"I",elements:[{type:"vbox",padding:0,children:[{type:"html",html:"<span>"+CKEDITOR.tools.htmlEncode(e.lang.attachment.url)+"</span>"},{type:"hbox",widths:["280px","110px"],align:"right",children:[{id:"src",type:"text",label:"",validate:CKEDITOR.dialog.validate.notEmpty(e.lang.flash.validateSrc),setup:function(e){e.url&&this.setValue(e.url),this.select()},commit:function(e){e.url=this.getValue()}},{type:"button",id:"browse",filebrowser:"general:src",hidden:!0,align:"center",label:e.lang.common.browseServer}]}]},{type:"vbox",padding:0,children:[{id:"name",type:"text",label:e.lang.attachment.name,setup:function(e){e.title&&this.setValue(e.title)},commit:function(e){e.title=this.getValue()}}]},{type:"hbox",widths:["50%","50%"],children:[{type:"select",id:"linkTargetType",label:e.lang.link.target,"default":"notSet",style:"width : 100%;",items:[[e.lang.link.targetNotSet,"notSet"],[e.lang.link.targetFrame,"frame"],[e.lang.link.targetNew,"_blank"],[e.lang.link.targetTop,"_top"],[e.lang.link.targetSelf,"_self"],[e.lang.link.targetParent,"_parent"]],onChange:a,setup:function(e){e.target&&this.setValue(e.target.type)},commit:function(e){e.target||(e.target={}),e.target.type=this.getValue()}},{type:"text",id:"linkTargetName",label:e.lang.link.targetFrameName,"default":"",setup:function(e){e.target&&this.setValue(e.target.name)},commit:function(e){e.target||(e.target={}),e.target.name=this.getValue()}}]}]},{id:"Upload",hidden:!0,filebrowser:"uploadButton",label:e.lang.common.upload,elements:[{type:"file",id:"upload",label:e.lang.common.upload,size:38},{type:"fileButton",id:"uploadButton",label:e.lang.common.uploadSubmit,filebrowser:"general:src","for":["Upload","upload"]}]}]}})}();