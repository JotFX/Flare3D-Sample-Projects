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
package rendering.filters
{
    import flare.basic.*;
    import flare.materials.flsl.*;
    import flare.system.*;
    
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class SwitchColorFilter extends FLSLFilter
    {
        private var _camPos:Vector3D;
		
		[Embed(source = '../resources/filters/switchcolor.flsl', mimeType = 'application/octet-stream')]
		private static var FLSL_FILTER:Class;
		private static var compiledFilter:ByteArray = FLSLCompiler.compile( new FLSL_FILTER );
		
        public static const PER_PIXEL:String = "perPixel";
		public static const PER_VERTEX:String = "perVertex";

		private var currentColor:Vector3D;
		private var newColor:Vector3D;
		private var origin:Vector3D;
		
		private var startTime:Number = 0;
		
		private var timeStretch:Number = 40;
		
        public function SwitchColorFilter(timeStretch:int = 40, spread:int = 10)
        {
            super(compiledFilter, "normal", "perVertex");
			this.timeStretch = timeStretch;
			
            if (!Device3D.scene)
            {
                throw new Error("Can not create FogFilter. You should create a new scene before!");
            }
			currentColor = new Vector3D(1,0,0);
			newColor = new Vector3D(0,1,0);
			
			this.params.spread.value = Vector.<Number>([spread]);
			this.params.currentcolor.value = Vector.<Number>([currentColor.x,currentColor.y,currentColor.z,1]);
			this.params.newcolor.value = Vector.<Number>([newColor.x,newColor.y,newColor.z,1]);
			this.params.currentcolor.value = Vector.<Number>([currentColor.x,currentColor.y,currentColor.z,1]);
			
			startTime = getTimer();
			
            Device3D.scene.addEventListener(Scene3D.RENDER_EVENT, this.renderEvent, false, 0, true);
        }
		
		public function switchColor(newc:Vector3D, neworigin:Vector3D):void
		{
			// save starttime, to avoid subtraction to zero in renderEvent, decrease about 1
			startTime = getTimer() - 1;	
			// set previous new color to the current one
			this.currentColor = this.newColor;
			// set new color and origin of transformation
			this.newColor = newc;
			this.origin = neworigin;
			// set colors and origin on the shader
			this.params.currentcolor.value[0] = currentColor.x;
			this.params.currentcolor.value[1] = currentColor.y;
			this.params.currentcolor.value[2] = currentColor.z;
			
			this.params.newcolor.value[0] = newc.x;
			this.params.newcolor.value[1] = newc.y;
			this.params.newcolor.value[2] = newc.z;
			
			this.params.origin.value[0] = neworigin.x;
			this.params.origin.value[1] = neworigin.y;
			this.params.origin.value[2] = neworigin.z;
		}
		
		private function renderEvent(e:Event):void
		{
			// on every frame update the elapsed time sind transformation start
			params.timedelta.value[0] = (getTimer() - startTime) / timeStretch;
			update();
		}
    }
}
