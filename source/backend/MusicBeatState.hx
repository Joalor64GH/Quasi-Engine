package backend;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.util.FlxColor;

import flixel.addons.transition.FlxTransitionableState;

import backend.Conductor;

class MusicBeatState extends FlxState
{
	private var curBeat:Int = 0;
	private var curStep:Int = 0;

	override function create()
	{
		super.create();

		if (!FlxTransitionableState.skipNextTransOut)
		{
			var cam:FlxCamera = new FlxCamera();
			cam.bgColor.alpha = 0;
			FlxG.cameras.add(cam, false);
			cam.fade(FlxColor.BLACK, 0.7, true, function()
			{
				FlxTransitionableState.skipNextTransOut = false;
			});
		}
		else
		{
			FlxTransitionableState.skipNextTransOut = false;
		}
	}

	override function update(elapsed:Float)
	{
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();

		super.update(elapsed);
	}

	override function destroy()
	{
		super.destroy();
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	private function updateCurStep():Void
	{
		curStep = Math.floor(Conductor.songPosition / Conductor.stepCrochet);
	}

	public static function switchState(nextState:FlxState)
	{
		if (!FlxTransitionableState.skipNextTransIn)
		{
			var cam:FlxCamera = new FlxCamera();
			cam.bgColor.alpha = 0;
			FlxG.cameras.add(cam, false);
			cam.fade(FlxColor.BLACK, 0.7, false, function()
			{
				FlxG.switchState(nextState);
				FlxTransitionableState.skipNextTransIn = false;
			});
		}
		else
		{
			FlxG.switchState(nextState);
			FlxTransitionableState.skipNextTransIn = false;
		}
	}

	public static function resetState() 
	{
		FlxG.resetState();
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void 
	{
		// do nothing lmao
	}
}