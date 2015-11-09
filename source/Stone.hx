package;

import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
import GameObject;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Stone extends GameObject
{

	public var info:String;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.stone__png, false, 64, 64);
		this.setSize(64, 64);
		this.set_immovable(true);
		drag.x = drag.y = 1600;
		
		info = "What a strange rock...";
	}

	public override function onAction(S:PlayState):Void {
		
		S.info.showText(info);

	}
}