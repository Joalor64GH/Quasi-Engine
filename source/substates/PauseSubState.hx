package substates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

import backend.MusicBeatSubstate;

class PauseSubState extends MusicBeatSubstate
{
    	public function new()
    	{
        	super();

        	FlxG.mouse.visible = true;

        	var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        	add(bg);

        	var titleText:FlxText = new FlxText(0, 0, 0, "PAUSED?", 12);
		titleText.scrollFactor.set();
		titleText.setFormat("VCR OSD Mono", 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        	titleText.screenCenter(X);
		add(titleText);

        	var resumeBtn:FlxButton = new FlxButton(0, FlxG.height / 2, "Resume", function()
        	{
            		FlxG.mouse.visible = false;
            		close();
        	});
        	resumeBtn.scale.set(2, 2);
        	resumeBtn.screenCenter(X);
        	add(resumeBtn);

        	var exitBtn:FlxButton = new FlxButton(0, resumeBtn.y + 70, "Exit", function()
        	{
            		MusicBeatState.switchState(new states.MainMenuState());
            		FlxG.mouse.visible = false;
        	});
        	exitBtn.scale.set(2, 2);
        	exitBtn.screenCenter(X);
        	add(exitBtn);
    	}

    	override public function update(elapsed:Float)
    	{
        	super.update(elapsed);
    	}
}
