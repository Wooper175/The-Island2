package;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Switch extends FlxSprite
{

	public var state:Bool;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.switch__png, false, 32, 32);
		
		setSize(32, 32);
		offset.set(0, 32);
		animation.add("active", [1, 2, 3, 4], 6, false);
		animation.add("deactive", [4, 3, 2, 1], 6, false);
		
		state = false;
	}
	public function changeState():Void {
		
		if (state == false) {
			animation.play("active");
		
		}
		else{
			
			animation.play("deactive");
		}
		state = !state;
	}
	
}