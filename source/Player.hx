package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{

	public var speed:Float = 200;
	public var movementSession:Bool = false;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.player__png, true, 32, 48);
		
		animation.add("l", [7, 6, 5,6], 6, false);
		animation.add("r", [11, 10, 9, 10], 6, false);
		animation.add("u", [13, 14, 15, 14], 6, false);
		animation.add("d", [ 1, 2,3, 2 ], 6, false);
		animation.add("li", [4], 6, false);
		animation.add("ri", [8], 6, false);
		animation.add("ui", [12], 6, false);
		animation.add("di", [0], 4, false);

		
		drag.x = drag.y = 1600;
		setSize(20, 20);
		offset.set(5, 30);
		
		
	}
	
	private function movement():Void
	{
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
			
		if (_up || _down || _left || _right) {
			var mA:Float = 0;
			if (_up)
			{
				mA = -90;
			if (_left)
			mA -= 45;
			else if (_right)
			mA += 45;
			facing = FlxObject.UP;
			}
			
			else if (_down)
			{
			mA = 90;
			if (_left)
			mA += 45;
			else if (_right)
			mA -= 45;
			facing = FlxObject.DOWN;
			}
			
			else if (_left) {
				mA = 180;
				facing = FlxObject.LEFT;
			}
			
			else if (_right) {
				mA = 0;
				facing = FlxObject.RIGHT;
			}
			
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);
			
			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
				
				
				switch (facing)
				{
				case FlxObject.LEFT:
					animation.play("l");
				case FlxObject.RIGHT:
					animation.play("r");
				case FlxObject.UP:
					animation.play("u");
				case FlxObject.DOWN:
					animation.play("d");
				}
			
			movementSession = true;
			}
		}
	}
	
	override public function update():Void
	{
    movement();
	idleAnimation();
    super.update();
	}
	
	private function idleAnimation():Void {
		
		
		if(!FlxG.keys.anyPressed(["UP", "W","DOWN", "S","LEFT", "A","RIGHT", "D"]) && movementSession){
			switch (facing)
				{
				case FlxObject.LEFT:
					animation.play("li");
				case FlxObject.RIGHT:
					animation.play("ri");
				case FlxObject.UP:
					animation.play("ui");
				case FlxObject.DOWN:
					animation.play("di");
				}
				
			movementSession = false;	
		}
	}
	
}