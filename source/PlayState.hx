package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.system.FlxAssets;
import lime.Assets;
import openfl.geom.Point;
import GameObject;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var player:Player;
	public var _map:FlxOgmoLoader;
	public var _mWalls:FlxTilemap;
	public var _mWalls2:FlxTilemap;
	public var _grpSwitch:FlxTypedGroup<Switch>;
	public var _grpStone:FlxTypedGroup<Stone>;
	public var _grpGameObject:FlxGroup;
	public var puzzleSolved:Bool;
	public var info:InfoFrame;
	public var lpoint:FlxSprite;
	public var level:TiledLevel;
	public var floor:FlxObject;

	override public function create():Void
	{
		
		super.create();
		
		_grpSwitch = new FlxTypedGroup<Switch>();
		add(_grpSwitch);
		_grpStone = new FlxTypedGroup<Stone>();
		add(_grpStone);
		_grpGameObject = new FlxGroup();
		add(_grpGameObject);
		
		_grpGameObject.add(_grpStone);
		_grpGameObject.add(_grpSwitch);
		
		level = new TiledLevel("assets/testmap2.tmx");
		
		
		add(level.foregroundTiles);	
		
		
		// Add background tiles after adding level objects, so these tiles render on top of player
		add(level.backgroundTiles);
		level.loadObjects(this);
		
		info = new InfoFrame();
		add(info);
		info.set_visible(false);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);
		
		puzzleSolved = false;
		
		lpoint = new FlxSprite();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		FlxG.collide(player, level.backgroundTiles);
		FlxG.collide(player, _grpStone);

		playerAction();
	}
	
	private function puzzleCheck():Void {
		
		var s:Switch = _grpSwitch.getRandom();
		var sVal:Bool = s.state;
		
		
		if (sVal && !puzzleSolved) {
			var st:Stone = _grpStone.getRandom();
			FlxTween.tween(st, { x:st.x + 30, y:st.y }, 3);
			puzzleSolved = true;
			
		}
	}
	public function playerAction():Void {
		
		if (FlxG.keys.anyJustPressed(["E"])) {
			
			switch (player.facing)
				{
				case FlxObject.LEFT:
					lpoint.setPosition(player.getMidpoint().x-20, player.getMidpoint().y-20);
					FlxG.overlap(lpoint, _grpGameObject, doAction);
					FlxG.keys.reset();
					
				case FlxObject.RIGHT:
					lpoint.setPosition(player.getMidpoint().x+20, player.getMidpoint().y-20 );
					FlxG.overlap(lpoint, _grpGameObject, doAction);
					FlxG.keys.reset();
				case FlxObject.UP:
					
					lpoint.setPosition(player.getMidpoint().x, player.getMidpoint().y-30);
					FlxG.overlap(lpoint, _grpGameObject, doAction);
					FlxG.keys.reset();
				case FlxObject.DOWN:
					
					lpoint.setPosition(player.getMidpoint().x, player.getMidpoint().y+10);
					FlxG.overlap(lpoint, _grpGameObject, doAction);
					FlxG.keys.reset();
				}
		}	
	}
	public function doAction(P:FlxSprite, G:GameObject):Void {
		G.onAction(this);
	}
}














