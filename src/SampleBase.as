/*
Copyright (c) 2012 Jonas Volger

Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
and associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, 
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or 
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
package
{
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class SampleBase extends Sprite
	{
		protected var view:Viewer3D;
		
		public function SampleBase()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			view = new Viewer3D(this);
			view.antialias = 2;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			view.addEventListener(Scene3D.COMPLETE_EVENT, onSceneComplete);
			view.addEventListener(Scene3D.UPDATE_EVENT, onSceneUpdate);
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(event:Event):void
		{
			view.setViewport(0,0,stage.stageWidth,stage.stageHeight);
		}
		protected function onSceneUpdate(e:Event):void
		{
			
		}
		protected function onSceneComplete(e:Event):void
		{
			
		}
	}
}