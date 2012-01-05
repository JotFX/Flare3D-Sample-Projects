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
package   rendering.filters
{
    import flare.basic.*;
    import flare.core.Pivot3D;
    import flare.materials.flsl.*;
    import flare.system.*;
    
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class RimShadingFilter_v1 extends FLSLFilter
    {
		[Embed(source = '../resources/filters/rimshader_v1.flsl', mimeType = 'application/octet-stream')]
		private static var FLSL_FILTER:Class;
		private static var compiledFilter:ByteArray = FLSLCompiler.compile( new FLSL_FILTER );
		
        public function RimShadingFilter_v1(targetObject:Pivot3D)
        {
			
			compiledFilter;
            
			super(compiledFilter, "normal", "perVertex");
			
            if (!Device3D.scene)
            {
                throw new Error("Can not create Filter. You should create a new scene before!");
            }
			_targetObject = targetObject;
			
          	Device3D.scene.addEventListener(Scene3D.RENDER_EVENT, this.renderEvent, false, 0, true);
        }
		
		private var _targetObject:Pivot3D;
		private function renderEvent(event:Event) : void
        {
			var camPos:Vector3D = Device3D.camera.getPosition().subtract(_targetObject.getPosition());
			camPos.normalize();
			this.params.camNormal.value = Vector.<Number>([camPos.x,camPos.y,camPos.z]);
			update();
        }
		
		
    }
}
