package com.heymath.jsfl
{
    import com.adobe.serialization.json.*;
    import com.heymath.jsfl.components.*;
    import com.heymath.jsfl.events.*;
    import com.heymath.jsfl.float.*;
    
    import com.heymath.jsfl.model.*;
    import com.heymath.jsfl.trans.*;
    import com.heymath.jsfl.utils.*;
    import com.heymath.jsfl.window.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
	
    public class Lang extends Object
    {
        private var _container:MovieClip;
        private var _message:MessageBox;
        private var _float:LangFloat;
        private var _langbox:LangBox;
        private var _contents:LangContents;

        public function Lang()
        {
            this._message = new MessageBox();
            this._float = new LangFloat();
            EventSingleton.getInstance().addEventListener(LangEvent.DISPLAY_CHANGED, this.onDisplayChange);
            EventSingleton.getInstance().addEventListener(LangEvent.ALPHA_CHANGED, this.onAlphaChange);
            EventSingleton.getInstance().addEventListener(LangEvent.FONT_SIZE_CHANGED, this.onFontSizeChange);
            EventSingleton.getInstance().addEventListener(LangEvent.SAVE_NEW, this.onSave);
            EventSingleton.getInstance().addEventListener(LangEvent.SAVE_NEW_COMPLETE, this.onSaveComplete);
            this.onDisplayChange(null);
            return;
        }

        private function onRemoved(event:Event) : void
        {
            this.clearUp(event.target as MovieClip);
            return;
        }

        private function onSave(event:LangEvent) : void
        {
            this._message.show(true);
            return;
        }

        private function addEventListeners(data:Object) : void
        {
            var m:MovieClip = data.movieclip;
            m.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
            m.addEventListener(MouseEvent.ROLL_OVER, this.rollOverText);
            m.addEventListener(MouseEvent.ROLL_OUT, this.rollOutText);
            m.addEventListener(MouseEvent.CLICK, this.clickText);
            return;
        }

        private function clearUp(m:MovieClip) : void
        {
            if (m)
            {
                m.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
                m.removeEventListener(MouseEvent.ROLL_OVER, this.rollOverText);
                m.removeEventListener(MouseEvent.ROLL_OUT, this.rollOutText);
                m.removeEventListener(MouseEvent.CLICK, this.clickText);
                this._float.remove(m);
            }
            return;
        }

        private function decorate(data:Object) : void
        {
            var m:MovieClip = data.movieclip;
            var bounds:Rectangle = m.getBounds(this._container);
            var g:Graphics = m.graphics;
            m.graphics.lineStyle(0, 0, 0);
            g.beginFill(255, 0);
            data.gapx = Math.max(0, (data.w - m.width) / 2);
            data.gapy = Math.max(0, (data.h - m.height) / 2);
            g.drawRect(data.gapx, data.gapy, m.width, m.height);
            g.endFill();
            this._float.register(m, data);
            return;
        }

        public function setContainer(container:MovieClip) : void
        {
            this._container = container;
            return;
        }

        private function onSaveComplete(event:LangEvent) : void
        {
            this._message.show(false);
            return;
        }

        private function onAlphaChange(event:LangEvent) : void
        {
            this._float.setAlpha(LangModelSingleton.getInstance().getAlpha() / 100);
            return;
        }

        private function clickText(event:MouseEvent) : void
        {
            var data:Object = null;
            if (LangModelSingleton.getInstance().getOn())
            {
                data = {movieclip:event.target as MovieClip};
                EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.CLICK, true, true, data));
            }
            return;
        }

        private function rollOutText(event:MouseEvent) : void
        {
            var data:Object = null;
            if (LangModelSingleton.getInstance().getOn())
            {
                data = {movieclip:event.target as MovieClip};
                EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.ROLL_OUT, true, true, data));
            }
            return;
        }

        public function setData(json:String) : void
        {
            TransSingleton.getInstance().setData(JSON.decode(json).data as Array);
            this._langbox = new LangBox(this._container);
            this._container.addChild(this._message);
            return;
        }

        public function process(data:Object) : void
        {
            this.addEventListeners(data);
            this.decorate(data);
            return;
        }

        private function onDisplayChange(event:LangEvent) : void
        {
            return;
        }

        private function rollOverText(event:MouseEvent) : void
        {
            var data:Object = null;
            if (LangModelSingleton.getInstance().getOn())
            {
                data = {movieclip:event.target as MovieClip};
                EventSingleton.getInstance().dispatchEvent(new LangEvent(LangEvent.ROLL_OVER, true, true, data));
            }
            return;
        }

        private function onFontSizeChange(event:LangEvent) : void
        {
            this._float.sizeFont();
            return;
        }

    }
}
