package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxTween;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _mWalls2:FlxTilemap;
	private var _grpSwitch:FlxTypedGroup<Switch>;
	private var _grpStone:FlxTypedGroup<Stone>;
	private var puzzleSolved:Bool;
	
	override public function create():Void
	{
		
		super.create();
		
		_map = new FlxOgmoLoader(AssetPaths.endeligt__oel);
		_mWalls = _map.loadTilemap(AssetPaths.cave01__png, 32, 32, "ground");
		_mWalls2 = _map.loadTilemap(AssetPaths.cave01__png, 32, 32, "ground2");
		//_mWalls.setTileProperties(1, FlxObject.NONE);
		//_mWalls2.
		add(_mWalls);
		add(_mWalls2);
 
		_player = new Player();
		
		_grpSwitch = new FlxTypedGroup<Switch>();
		add(_grpSwitch);
		_grpStone = new FlxTypedGroup<Stone>();
		add(_grpStone);
		add(_player);
		_map.loadEntities(placeEntities, "items");
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
		
		puzzleSolved = false;
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
		FlxG.collide(_player, _mWalls2);
		FlxG.collide(_player, _grpStone);
		FlxG.overlap(_player, _grpSwitch, switchAction);
		puzzleCheck();
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
     var x:Int = Std.parseInt(entityData.get("x"));
     var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
		else if (entityName == "switch")
		{
			_grpSwitch.add(new Switch(x, y ));
		}
		else if (entityName == "stone")
		{
			_grpStone.add(new Stone(x, y ));
			
		}
	}
	private function switchAction(P:Player, S:Switch):Void
	{
		if (FlxG.keys.anyJustReleased(["X"])) {
			S.changeState();
			FlxG.keys.reset();
			
		}
	}
	private function puzzleCheck():Void {
		
		var s:Switch = _grpSwitch.getRandom();
		var sVal:Bool = s.state;
		
		
		if (sVal && !puzzleSolved) {
			var st:Stone = _grpStone.getRandom();
			//st.immovable = false;
			FlxTween.tween(st, { x:st.x + 30, y:st.y }, 3);
			puzzleSolved = true;
			
		}
	}
}




