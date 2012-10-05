package {
	import fl.text.TLFTextField;
	import flash.display.Sprite;
	import flash.external.*;
	import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.Direction;
    import fl.text.TLFTextField;
			import flashx.textLayout.formats.TextLayoutFormat;
			import flashx.textLayout.elements.TextFlow;
			import flashx.textLayout.edit.EditManager;
			
			
	public class testFTE extends Sprite
	{
		
		public function testFTE()
		{
			
			var myTLFTextField:TLFTextField = new TLFTextField();
			addChild(myTLFTextField); 
			myTLFTextField.x = 10;
			myTLFTextField.y = 10;
			myTLFTextField.width = 200
			myTLFTextField.height = 100;
			myTLFTextField.text = "This is my text";
			
			myTLFTextField.selectable = true;
			
			var myFormat:TextLayoutFormat = new TextLayoutFormat();
			myFormat.fontSize = 24;
			myFormat.direction = Direction.RTL;
			
			var myTextFlow:TextFlow = myTLFTextField.textFlow;
			myTextFlow.hostFormat = myFormat;
			myTextFlow.flowComposer.updateAllControllers();
			
			var editManager:EditManager = new EditManager();
			myTextFlow.interactionManager = editManager;
			//editManager.applyLeafFormat(format, sel);
			
			
			// t.text="י אחראי לניהול הכלל";






			
			
									
		}
	}
}



