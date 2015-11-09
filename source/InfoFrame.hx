package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author ...
 */
class InfoFrame extends FlxTypedGroup<FlxSprite>
{
	private var bgSprite:FlxSprite;
	public var text:FlxText;
	private var border1:FlxSprite;
	private var border2:FlxSprite;
	
	public function new() 
	{
		super();
		
		bgSprite = new FlxSprite().makeGraphic(300, 40, FlxColor.ROYAL_BLUE);
		bgSprite.setPosition((FlxG.width / 2) - (bgSprite.width / 2), FlxG.height - 50);
		
		border1 = new FlxSprite().makeGraphic(298, 36, FlxColor.WHITE);
		border1.setPosition((FlxG.width / 2) - (border1.width / 2), FlxG.height - 48);
		
		border2 = new FlxSprite().makeGraphic(296, 34, FlxColor.ROYAL_BLUE);
		border2.setPosition((FlxG.width / 2) - (border2.width / 2), FlxG.height - 47);
        
        text = new FlxText(16, 2, 0, "Text", 8);
		text.setPosition(border2.x,border2.y);
		
		add(bgSprite);
		add(border1);
		add(border2);
		add(text);
		
		forEach(function(spr:FlxSprite) {
             spr.scrollFactor.set();
         });
		
		 //this.set_visible(true);
	}

	public function showText(s:String):Void {
				
		text.text = s;
		set_visible(true);
		fadeIn();
		fadeOut(8);
		
	
	}
		public function fadeIn():Void {
		
		bgSprite.alpha = 1;
		border1.alpha = 1;
		border2.alpha = 1;
		text.alpha = 1;
		
	}
		public function fadeOut(t:Float):Void {
		FlxSpriteUtil.fadeOut(bgSprite, t);
		FlxSpriteUtil.fadeOut(border1, t);
		FlxSpriteUtil.fadeOut(border2, t);
		FlxSpriteUtil.fadeOut(text, t);
	}
}




