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

Lang.Errors = {};
Lang.Errors.SELECT_FAIL = "Selecting the library item failed";

Lang.num = 0;

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
	var newName;
	if(addCode){
		newName = "HMTrans_" +Lang.num;
	}
	else{
		newName = "HMTransStage_" +Lang.num;
	}
	Lang.num = Lang.num + 1;
	Lang.dom.selectNone();
	Lang.dom.selection = [text];
	var len = Lang.dom.selection.length;
	if(len == 1){
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
	else{
		throw new Error(Lang.Errors.SELECT_FAIL);
	}
};

Lang.breakAll = function(frame){
	var k;
	var el;
	var type;
	var els;
	var len;
	var needsBreak = true;
	while(needsBreak){
		//alert("loop");
		needsBreak = false;
		els = frame.elements; 
		len = els.length;
		for( k = 0; k<=len - 1; k++){
			el = els[k];
			type = el.elementType;
			if(type=="shape" && el.isGroup){
				needsBreak = true;
				Lang.dom.selectNone();
				Lang.dom.selection = [el];
				//alert("going to break");
				Lang.dom.breakApart();
			}
		}
	}
	
};

Lang.processFrame=function(timeline, frame, addCode){
	var k;
	var el;
	var type;
	var els = frame.elements; 
	var len = els.length;
	els = frame.elements; 
	len = els.length;
	for( k = 0; k<=len - 1; k++){
		el = els[k];
		type = el.elementType;
		if(type=="text" && el.textType=="static" && Lang.textFields.indexOf(el)==-1  ){
			//alert("ptf "+addCode);
			Lang.processTextField(el, addCode);
		}
	}
};

Lang.processLayer = function(timeline, layer, addCode){
	var type = layer.layerType;
	if(type=="normal" || type=="guided" || type=="masked"){
		layer.locked = false;
		layer.visible = true;
		var frameCount = layer.frameCount;
		for(var j=0;j<=frameCount-1;j++){
			var frame = layer.frames[j];
			if(frame.startFrame == j){
				// it is a keyframe
				timeline.setSelectedFrames(j, j);
				//alert("frame "+j);
				Lang.breakAll(frame);
				//alert("broken");
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
		//alert("layer "+i);
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
	var items = Lang.lib.items;
	var len = items.length;
	var i;
	for(i=0;i<=len-1;i++){
		var item = items[i];
		Lang.lib.selectNone();
		var s = item.name;
		if(s.substring(0,8)!="HMTrans_" && Lang.getDoProcess(item)){
			fl.trace(i+", "+s);
			Lang.lib.selectItem(item.name, true);
			Lang.lib.editItem(s);
			//alert("edit "+s);
			var itemTimeline = item.timeline;
			Lang.scanTimeline(itemTimeline, true);
			Lang.dom.exitEditMode();
		}
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
	doc.libraryPath = doc.libraryPath+";"+Lang.Config.SWC_PATH;
};

Lang.processAll = function(){
	Lang.dom.selectNone();
	Lang.scanTimeline(Lang.mainTimeline, false);
	Lang.dom.selectNone();
	fl.trace("main timeline processed");
	Lang.searchLib();
	//Lang.updateSrc();
	//Lang.saveAndPublish();
};

if(Lang.init()){
	Lang.processAll();
}

