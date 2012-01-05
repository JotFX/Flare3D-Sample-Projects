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
	import flare.collisions.CollisionInfo;
	import flare.collisions.MouseCollision;
	import flare.core.Pivot3D;
	import flare.materials.Shader3D;
	import flare.primitives.Cube;
	import flare.system.Input3D;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import rendering.filters.*;
	
	public class SwitchColorShaderTest extends SampleBase
	{
		
		private var object:Pivot3D;
		private var mat:SwitchColorFilter;
		private var mc:MouseCollision;
		
		public function SwitchColorShaderTest()
		{
			super();
			
			mat = new SwitchColorFilter(40, 6);
			
			object = new Cube("",50,50,100,50,new Shader3D("",[ mat ]));
			view.addChild(object);
			
			object.rotateY(45);
			view.camera.z = -100;
			
			mc = new MouseCollision(view.scene.camera);
			mc.addCollisionWith(object);
			lastAction = getTimer();
		}
		
		
		private var lastAction:Number;
		
		protected override function onSceneUpdate(e:Event):void
		{
			var hit:Boolean = false;
			if (Input3D.mouseHit)
			{
				hit = mc.test(stage.mouseX, stage.mouseY);
			}
			else if(getTimer() - lastAction > 5000)
			{
				hit = mc.test(stage.stageWidth/2, stage.stageHeight/2);
			}
			if(hit)
			{
				lastAction = getTimer();
				var ci:CollisionInfo = mc.data[0];
				var color:Vector3D = new Vector3D(Math.random(),Math.random(),Math.random());
				mat.switchColor(color,ci.point);
			}
		}
		
		
		
	}
}