// turn off script timeout
fl.showIdleMessage(false);

// global namespace and shortcut
var com = {};
com.heymath = {};
com.heymath.jsfl = {};
com.heymath.jsfl.lang = function(){};
var Lang = com.heymath.jsfl.lang;


Lang.Config = { };
Lang.Config.IMPORT_STRING = "import com.heymath.jsfl.lib.*;";
Lang.Config.SWC_PATH = "../../../../langHMLib/langHMLib.swc";

Lang.num = 0;

Lang.Utils = { };

Lang.Utils.copyLibArray = function(){
	var items = Lang.lib.items;
	var len = items.length;
	var copyItems = [];
	var i;
	for(i=0;i<=len-1;i++){
		var item = items[i];
		if(Lang.getDoProcess(item)){
			copyItems.push(item);
		}
	}
	return copyItems;
};


Lang.init = function(){
	var docs = fl.documents;  
	if(docs.length!=1){
		alert("error, please open one doc");
		return false;
	}
	else{
		Lang.dom = fl.getDocumentDOM();
		Lang.dom.selectNone();
		Lang.lib = Lang.dom.library;
		Lang.mainTimeline = Lang.dom.getTimeline();
		Lang.textFields = [ ];
		return true;
	}
};

Lang.getLibItemByName = function(name){
	return Lang.lib.items[Lang.lib.findItemIndex(name)];
};

Lang.getProcessCode = function(name, x, y, w, h){
	var s = "new FlashLang(this, '"+name+"', new Rectangle("+Math.round(x)+","+Math.round(y)+","+Math.round(w)+","+Math.round(h)+"));";
	return Lang.Config.IMPORT_STRING+"\n"+s;
};

Lang.processTextField = function(text, addCode){
	var newName = "HMTtranslate_" +Lang.num;
	Lang.num = Lang.num + 1;
	Lang.dom.selectNone();
	Lang.dom.selection = [text];
	try{
		Lang.dom.convertToSymbol("movie clip", newName, "top left");
		if(addCode){
			var libItem = Lang.getLibItemByName(newName);
			var libTimeline = libItem.timeline;
			var newLayer = libTimeline.addNewLayer();
			libTimeline.setSelectedLayers(0);
			var s = Lang.getProcessCode(newName, text.x, text.y, text.width, text.height);
			libTimeline.layers[newLayer].frames[0].actionScript = s;
		}
		Lang.textFields.push(text);
	}
	catch(e){
		alert("error "+text+","+newName);
	}
};


Lang.processFrame=function(timeline, frame, addCode){
	var els = frame.elements; 
	for(var k=0;k<=els.length-1;k++){
		var el = els[k];
		if(el.elementType=="text" && Lang.textFields.indexOf(el)==-1 && el.textType=="static" ){
			Lang.processTextField(el, addCode);
		}
	}
};


Lang.processLayer = function(timeline, layer, addCode){
	var type = layer.layerType;
	if(type=="normal" || type=="guided" || type=="masked"){
		layer.locked = false;
		var frameCount = layer.frameCount;
		for(var j=0;j<=frameCount-1;j++){
			var frame = layer.frames[j];
			if(frame.startFrame == j){
				// it is a keyframe
				timeline.setSelectedFrames(j, j);
				Lang.processFrame(timeline, frame, addCode);
			}
		}
	}
};



Lang.scanTimeline = function(timeline, addCode){
	if(!timeline){
		return;
	}
	for(var i=0;i<=timeline.layerCount-1;i++){
		timeline.setSelectedLayers(i);
		var layer = timeline.layers[i];
		Lang.processLayer(timeline, layer, addCode);
	}
};
Lang.checkType = function(item){
	var itemType = item.itemType;
	if(itemType && (itemType=="movie clip" || itemType=="graphic") ){
		return true;
	}
	return false;
};
Lang.checkName = function(item){
	var itemName = item.name;
	if(itemName.substr(0,16)=="Component Assets" ){
		return false;
	}
	return true;
};
Lang.checkLink = function(item){
	var ex = item.linkageExportForAS;
	if(!ex){
		return true;
	}
	var itemBase = item.linkageBaseClass;
	var itemLink = item.linkageClassName;
	if(itemBase){
		var itemBase0 = itemBase.split(".")[0];
		if(itemBase0=="fl" || itemBase0=="flash"){
			return false;
		}
	}
	if(itemLink){
		var itemLink0 = itemLink.split(".")[0];
		if(itemLink0=="fl" || itemLink0=="flash"){
			return false;
		}
	}
	return true;
};
Lang.getDoProcess = function(item){
	return Lang.checkType(item) && Lang.checkName(item) && Lang.checkLink(item);
};

Lang.searchLib = function(){
	var copyItems = Lang.Utils.copyLibArray();
	var len = copyItems.length;
	fl.trace("items "+len);
	var item;
	for(var i=0;i<=len-1;i++){
		item = copyItems[i];
		fl.trace(item.name);
		Lang.lib.selectItem(item.name, true);
		Lang.lib.editItem(item.name);
		var itemTimeline = item.timeline;
		Lang.scanTimeline(itemTimeline, true);
		Lang.dom.exitEditMode();
	}
};


Lang.getDoc = function(){
	var docs = fl.documents;
	var doc = docs[0];
	return doc;
};


Lang.saveAndPublish = function(){
	var doc = Lang.getDoc();
	var docURI= doc.pathURI;
	var appendName = "_LANG.fla";
	docURI = docURI.replace(".fla",appendName);
	fl.saveDocument(doc ,docURI);
	fl.openDocument(docURI);
	doc = Lang.getDoc();
	doc.publish();
};
Lang.updateSrc = function(){
	var doc = Lang.getDoc();
	//doc.sourcePath = doc.sourcePath+";"+Lang.Config.AS_PATH;
	doc.libraryPath = doc.libraryPath+";"+Lang.Config.SWC_PATH;
};

Lang.insertBlank = function(){
	for(var i=0;i<=Lang.mainTimeline.layerCount-1;i++){
		var layer = Lang.mainTimeline.layers[i];
		var s = "";
		if(layer.frameCount>=1){
			s = layer.frames[0].actionScript;
			layer.frames[0].actionScript="";
		}
		
		Lang.mainTimeline.setSelectedLayers(i);
		Lang.mainTimeline.setSelectedFrames(0,0);
		Lang.mainTimeline.insertKeyframe(1);
		Lang.mainTimeline.cutFrames(0,0);
		Lang.mainTimeline.pasteFrames(1,1);
		layer.frames[0].actionScript=s;
		
	}
};

Lang.processAll = function(){
	//Lang.insertBlank();
	fl.trace("frame added");
	Lang.scanTimeline(Lang.mainTimeline, false);
	fl.trace("main timeline processed");
	Lang.searchLib();
	fl.trace("library scanned");
	Lang.updateSrc();
	Lang.saveAndPublish();
};


if(Lang.init()){
	Lang.processAll();
}

