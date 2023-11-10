package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;

import backend.MusicBeatState;

class MainMenuState extends MusicBeatState
{
    	public static var curSelected:Int = 0;

    	var menuItems:FlxSprite;
    	var optionShit:Array<String> = ['story_mode', 'freeplay', 'mods', 'credits', 'options'];

    	var magenta:FlxSprite;

    	override public function create()
    	{
        	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBG'));
        	add(bg);

        	magenta = new FlxSprite().loadGraphic(Paths.image('menuBGMagenta'));
        	magenta.visible = false;
        	add(magenta);

        	menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, 80 + (i * 200));
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.updateHitbox();
		}

        	var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "v" + Application.current.meta.get('version') - "FNF v0.2.7.1", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		changeItem();

        	super.create();
    	}

    	var selectedSomethin:Bool = false;

    	override public function update(elapsed:Float)
    	{
        	if (!selectedSomethin)
		{
			if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN) 
            		{
				changeItem(FlxG.keys.justPressed.UP ? -1 : 1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (FlxG.keys.justPressed.ESCAPE)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
                		Main.toast.create('Nope.', 0xFFFFFF00, "Can't do that. I didn't even make TitleState yet.");
			}

			if (FlxG.keys.justPressed.ENTER)
			{
                		if (optionShit[curSelected] == 'story_mode' || optionShit[curSelected] == 'mods' || optionShit[curSelected] == 'credits' || optionShit[curSelected] == 'options') 
				{
					Main.toast.create('Hey!', 0xFFFFFF00, 'These are not done yet! Come back later!');
				}
                		else
                		{
				    	selectedSomethin = true;
				    	FlxG.sound.play(Paths.sound('confirmMenu'));

				    	FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				    	menuItems.forEach(function(spr:FlxSprite)
				    	{
					    	if (curSelected != spr.ID)
					    	{
						    	FlxTween.tween(spr, {alpha: 0}, 0.4, {
							    	ease: FlxEase.quadOut,
							    	onComplete: function(twn:FlxTween)
							    	{
								    	spr.kill();
							    	}
						    	});
					    	}
					    	else
					    	{
						    	FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						    	{
							    	var daChoice:String = optionShit[curSelected];

							    	switch (daChoice)
							    	{
								    	case 'freeplay':
									    	MusicBeatState.switchState(new states.PlayState());
							    	}
						    	});
					    	}
				    	});
                		}
			}
		}

		super.update(elapsed);

		menuItems.forEach((spr:FlxSprite) ->
		{
			spr.screenCenter(X);
		});
    	}

    	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				spr.centerOffsets();
			}
		});
	}
}
