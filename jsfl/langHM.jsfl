
//****  INIT  ****//
fl.showIdleMessage(false);
var url = fl.configURI + "Javascript/ObjectFindAndSelect.jsfl";
if( fl.findObjectInDocByType == null ){
	fl.runScript(url);
}
xjsfl.init(this);
clear();

var Lang = {};
Lang.dom = null;
Lang.groupArray = [];
Lang.textArray = [];
Lang.context = null;
Lang.IMPORT_STRING = "import com.heymath.jsfl.lib.*;";
Lang.SWC_PATH = "../../../../langHMLib/langHMLib.swc";
Lang.ROOT = "file:///c|/users/john/documents/heymath/work/jsfl/jsfl/";
Lang.LESSONS_ROOT = "file:///c|/users/john/documents/heymath/work/jsfl/";
Lang.CONFIG_FILE = Lang.ROOT+"fileList.txt";
Lang.LOG_FILE = Lang.ROOT+"compile_log.txt";
Lang.started = false;
Lang.DEBUG = false;
//****  END INIT  ****//



function exitEdit(sel){
	//Lang.context.goto();
	//return;
	
	while (sel && sel.parent != undefined){
		sel = sel.parent;
		Lang.dom.exitEditMode();
	}
	
}

function addTempLayer(){
	appendLog("add temporary layer");
	var timeline = Lang.dom.getTimeline();
	timeline.setSelectedLayers(0, true);
	timeline.addNewLayer("temp");
	timeline.setSelectedLayers(0, true);
}

function distributeAll(){
	appendLog("distributeAll");
	var inArray = fl.findObjectInDocByType("instance", Lang.dom);
	var len = inArray.length;
	for (var i = 0; i <= len - 1 ; i++) {
		var sel = inArray[i];
		fl.selectElement(sel, true);
		var timeline = Lang.dom.getTimeline();
		var fc = timeline.frameCount;
		var lc = timeline.layerCount; 
		if(lc===1 && fc===1){
			Lang.dom.selectAll();
			Lang.dom.distributeToLayers();
		}
		Lang.dom.exitEditMode();
		exitEdit(sel);
		appendLog("exited");
	}
}

function breakGroups(){
	var n = 0;
	appendLog("break all groups");
	var errors = false;
	var sel, layer, obj, i, len;
	getGroups();
	while(!errors && Lang.groupArray.length>=1){
		len = Lang.groupArray.length;
		appendLog("break "+len+" groups");
		appendLog("first, distribute!");
		distributeAll();
		for (i = 0; i <= len - 1; i++) {
			sel = Lang.groupArray[i];
			obj = sel.obj;
			fl.selectElement(sel, false);
			if(Lang.dom.selection.length===1){
				// sometimes selection fails
				appendLog("going to break "+obj.name);
				Lang.dom.unGroup();
				appendLog("broken "+n);
				n++;
			}
			else{
				appendLog("error selecting group");
				errors = true;
				break;
			}
			exitEdit(sel);
		}
		getGroups();
	}
}

function filterLib(item){
	var ex = item.linkageExportForAS;
	if(!ex){
		return false;
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
}

function addLibToStage(){
	appendLog("add all library items to stage");
	$$(':graphic').filter(filterLib).addToStage();
	$$(':movieclip').filter(filterLib).addToStage();
}

function getGroups(){
	Lang.groupArray = [];
	var shapeArray = fl.findObjectInDocByType("shape", Lang.dom);
	var len = shapeArray.length;
	for (var i = 0; i <= len - 1; i++) {
		var sel = shapeArray[i];
		var s = sel.obj;
		if(s.isGroup){
			Lang.groupArray.push(sel);
		}
	}
}

function convertText(){
	appendLog("convert all text fields");
	var sel;
	var textArray = fl.findObjectInDocByType("text", Lang.dom);
	var len = textArray.length;
	var num = 0;
	for (var i = 0; i <= len - 1; i++) {
		sel = textArray[i];
		var textField = sel.obj;
		if(textField.textType=="static"){
			num++;
			fl.selectElement(sel, false);
			if(Lang.dom.selection.length===1){
				Lang.dom.convertToSymbol("movie clip", "HMTRANS"+Lang.num, "top left");
				Lang.num++;
			}
		}
		exitEdit(sel);
	}
	appendLog("converted "+num+" static textfields");
}

function removeLayer(){
	appendLog("remove temporary layer");
	var timeline = Lang.dom.getTimeline();
	timeline.deleteLayer(0);
}

function addCode(){
	appendLog("add code to textfields");
	Iterators.items(true, itemCallback);
}

function unlockAllLayers(){
	appendLog("unlock all layers");
	Iterators.layers(true, unlockLayer);
	Iterators.items(true, null, unlockLayer);
}

function itemCallback(item, index, items, context){
	if(item.name.substr(0,7)=="HMTRANS"){
		appendLog("add code to "+item.name);
		var libTimeline = item.timeline;
		var newLayer = libTimeline.addNewLayer();
		libTimeline.setSelectedLayers(0);
		var s = getProcessCode(item.name);
		libTimeline.layers[newLayer].frames[0].actionScript = s;
	}
}

function unlockLayer(layer, index, layers, context){
	layer.locked=false;
	layer.visible=true;
}

function getProcessCode(name){
	var nameString = "'"+name+"'";
	var s = "new FlashLang(this, "+nameString+");";
	return Lang.IMPORT_STRING+"\n"+s;
}

function loadFiles(){
	var i, file, fileList, fileListArray, c10, c13, processList;
	c10 = String.fromCharCode(10);
	c13 = String.fromCharCode(13);
	appendLog("load "+Lang.CONFIG_FILE);
	fileList = FLfile.read(Lang.CONFIG_FILE);
	fileList = fileList.split(c10).join(c13).split(c13+c13).join(c13);
	fileListArray = fileList.split(c13);
	var filesToProcess = [];
	for(i=0;i<=fileListArray.length-1;i++){
		file = fileListArray[i];
		if(file.length>=5 && file.substr(0,1)!=="#" && file.substr(file.length-4)===".fla"){
			filesToProcess.push(file);
		}
	}
	appendLog("loaded "+filesToProcess.length+" files  ");
	for(i=0;i<=filesToProcess.length-1;i++){
		file = filesToProcess[i];
		openFile(Lang.LESSONS_ROOT+file);
	}
}

function appendLog (p) {
	p="DEBUG:\t" + (new Date()) + "\t\t"+p;
	if(!Lang.started){
		FLfile.write(Lang.LOG_FILE,p);
		Lang.started = true;
	}
	else{
		FLfile.write(Lang.LOG_FILE,"\n"+p,"append");
	}
	if(Lang.DEBUG){
		alert(p);
	}
}

function openFile(file){
	Lang.num = 0;
	if(fl.documents.length>=1){
		appendLog("aborting, a flash document is open");
		return;
	}
	else{
		fl.openDocument(file);
		appendLog("process "+file);
		Lang.dom = $dom;
		Lang.num = 0;
		Lang.context = Context.create();
		processFile();
		//fl.closeDocument(fl.documents[0]);
		appendLog("closing...\n------------------------------------\n");
	}
}

function saveAndPublish(){
	appendLog("saving");
	var doc = fl.documents[0];
	var docURI= doc.pathURI;
	var appendName = "_LANG.fla";
	docURI = docURI.replace(".fla",appendName);
	fl.saveDocument(doc, docURI);
	var doc = fl.documents[0];
	doc.publish();
}

function updateSrc (){
	appendLog("update src");
	var doc = fl.documents[0];
	doc.libraryPath = doc.libraryPath+";"+Lang.SWC_PATH;
}


function processFile(){
	addTempLayer();
	addLibToStage();
	unlockAllLayers();
	distributeAll();
	breakGroups();
	convertText();
	removeLayer();
	addCode();
	updateSrc();
	saveAndPublish();
}


loadFiles();
fl.quit();


