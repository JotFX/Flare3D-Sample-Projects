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
	import flare.core.Pivot3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import rendering.filters.*;
	
	
	[SWF(frameRate='60',backgroundColor='0xFFFFFF')]
	public class RimShaderV1 extends SampleBase
	{
		private var object:Pivot3D;
		
		public function RimShaderV1()
		{
			super();
			object = view.addChildFromFile("../resources/test.f3d");
		}
		
		protected override function onSceneComplete(e:Event):void
		{
			object.setMaterial(new Shader3D("",[
				new ColorFilter(0xff0000)
				,new RimShadingFilter_v1(object)
			]));
		}
		
		private var roty:Number = 0;
		
		protected override function onSceneUpdate(e:Event):void
		{
			view.camera.rotateY(0.5,false,new Vector3D);
		}
		
		
		
	}
}