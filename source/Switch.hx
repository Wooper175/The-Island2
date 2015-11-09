package;

import GameObject;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Switch extends GameObject
{

	public var state:Bool;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.switch__png, false, 32, 32);
		
		setSize(32, 32);
		offset.set(0, 0);
		animation.add("active", [1, 2, 3, 4], 4, false);
		animation.add("deactive", [4, 3, 2, 1], 4, false);
		
		state = false;
	}
	
	public override function onAction(S:PlayState):Void {
		
		if (state == false) {
			animation.play("active");
		
		}
		else{
			
			animation.play("deactive");
		}
		state = !state;
	}
	
}