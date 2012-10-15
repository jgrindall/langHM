function onLoadHandler(){
  var lesson_xml_path = "../xmls/"+lid+".xml"
  var lesson_folder_path = "./"
  var url = "../../assets/players/content_player.swf?lid="+lid+"&lesson_xml_path="+lesson_xml_path+"&lesson_folder_path="+lesson_folder_path


	swfobject.embedSWF(url, "lessonContainer_div", "100%", "100%", "10.0","../../assets/swfobject/expressInstall.swf")
	
	
	if (navigator.appVersion.indexOf("X11")==-1){
		parent.resizeTo(screen.availWidth,screen.availHeight); moveTo(0,0);
	}
	parent.focus();
}
function resizeHandler(){
	if (navigator.appVersion.indexOf("X11")==-1){
		parent.resizeTo(screen.availWidth,screen.availHeight); moveTo(0,0);
	}
}
function closewin(){
	this.parent.close();
}

window.onload = onLoadHandler;
window.onresize = resizeHandler;
