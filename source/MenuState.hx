package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	
	private var button1:FlxButton;
	
	override public function create():Void
	{
		super.create();
		button1 = new FlxButton(0, 0, "Puzzle Demo 1", clickPlay);
		button1.screenCenter();
		add(button1);
		 
	}
	
	private function clickPlay():Void
	{
		FlxG.switchState(new PlayState());
		
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		button1 = FlxDestroyUtil.destroy(button1);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}