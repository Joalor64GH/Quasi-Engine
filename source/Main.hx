package;

import flixel.FlxG;
import flixel.FlxGame;

import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;

#if linux
import lime.graphics.Image;
#end

import core.ToastCore;

using StringTools;

class Main extends Sprite
{
	public static var gameHeight:Int = 1280; // game height (in pixels)
	public static var gameWidth:Int = 720; // game width (in pixels)
	
	public static var toast:ToastCore; // notification thing, credits go to MAJigsaw77

	public function new()
	{
		super();

		addChild(new FPS(10, 3, 0xFFFFFF));
		addChild(new FlxGame(gameHeight, gameWidth, states.MainMenuState, #if (flixel < "5.0.0") -1, #end 60, 60, false, false));

		#if linux
		var icon = Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		toast = new ToastCore();
		addChild(toast);
	}
}
