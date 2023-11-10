package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxCamera;

import backend.MusicBeatState;
import backend.Conductor;

#if VIDEOS_ALLOWED
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as MP4Handler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as MP4Handler;
#elseif (hxCodec == "2.6.0") import VideoHandler as MP4Handler;
#else import vlc.MP4Handler; #end
#end

class PlayState extends MusicBeatState
{
    public var camGame:FlxCamera;
    public var camHud:FlxCamera;

    override public function create()
    {
        camGame = new FlxCamera();
        camHud = new FlxCamera();

        camGame.bgColor.alpha = 0;
        camHud.bgColor.alpha = 0;

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        add(bg);

        var text:FlxText = new FlxText(0, 0, 0, "Nothing much.", 12);
		text.scrollFactor.set();
		text.setFormat("VCR OSD Mono", 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.screenCenter(X);
		add(text);

        bg.cameras = [camHud];
        text.cameras = [camHud];

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            openSubState(new PauseSubState());
        }
    }

    override function stepHit()
    {
        super.stepHit();
    }

    override function beatHit()
    {
        super.beatHit();

        if (curBeat % 2 == 0)
            FlxTween.tween(camHud, {zoom:1.03}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
    }
}