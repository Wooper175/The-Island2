package;

import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Stone extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.stone__png, false, 64, 64);
		this.setSize(64, 64);
		this.set_immovable(true);
		drag.x = drag.y = 1600;
	}
	
}