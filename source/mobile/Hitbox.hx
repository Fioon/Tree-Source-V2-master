#if mobileC
package mobile;

import flixel.graphics.FlxGraphic;
import flixel.addons.ui.FlxButtonPlus;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets;
import flixel.util.FlxDestroyUtil;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.ui.FlxVirtualPad;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.display.BitmapData;
import openfl.display.Shape;
import mobile.flixel.FlxButton;

// copyed from flxvirtualpad
class Hitbox extends FlxSpriteGroup
{
    public var hitbox:FlxSpriteGroup;

    var sizex:Int = 320;

    var screensizey:Int = 720;

    public var buttonLeft:FlxButton;
    public var buttonDown:FlxButton;
    public var buttonUp:FlxButton;
    public var buttonRight:FlxButton;

    public function new(?widghtScreen:Int)
    {
        super();

        /*if (widghtScreen == null)
            widghtScreen = FlxG.width;

        sizex = widghtScreen != null ? Std.int(widghtScreen / 4) : 320;


        //add graphic
        hitbox = new FlxSpriteGroup();
        hitbox.scrollFactor.set();

        var hitbox_hint:FlxSprite = new FlxSprite(0, 0).loadGraphic('assets/shared/images/hitbox/hitbox_hint.png');

        hitbox_hint.alpha = 0.2;

        add(hitbox_hint);


        hitbox.add(add(buttonLeft = createhitbox(0, "left")));

        hitbox.add(add(buttonDown = createhitbox(sizex, "down")));

        hitbox.add(add(buttonUp = createhitbox(sizex * 2, "up")));

        hitbox.add(add(buttonRight = createhitbox(sizex * 3, "right")));*/


        
        add(buttonLeft = createHint(0, 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), 0xFF00FF));
		add(buttonDown = createHint(FlxG.width / 4, 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), 0x00FFFF));
		add(buttonUp = createHint(FlxG.width / 2, 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), 0x00FF00));
		add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, Std.int(FlxG.width / 4), Std.int(FlxG.height * 1), 0xFF0000));
        scrollFactor.set();
    }
    
    private function createHintGraphic(Width:Int, Height:Int, Color:Int = 0xFFFFFF):BitmapData
	{
		var shape:Shape = new Shape();
		shape.graphics.beginFill(Color);
		shape.graphics.lineStyle(10, Color, 1);
		shape.graphics.drawRect(0, 0, Width, Height);
		shape.graphics.endFill();

		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);
		return bitmap;
	}

	private function createHint(X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFF):FlxButton
	{
		var hint:FlxButton = new FlxButton(X, Y);
		hint.loadGraphic(createHintGraphic(Width, Height, Color));
		hint.solid = false;
		hint.immovable = true;
		hint.scrollFactor.set();
		hint.alpha = 0.00001;
		hint.onDown.callback = hint.onOver.callback = function()
		{
			if (hint.alpha != 0.2)
				hint.alpha = 0.2;
		}
		hint.onUp.callback = hint.onOut.callback = function()
		{
			if (hint.alpha != 0.00001)
				hint.alpha = 0.00001;
		}
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}


    
    public function createhitbox(X:Float, framestring:String) {
        var button = new FlxButton(X, 0);
        var frames = FlxAtlasFrames.fromSparrow('assets/shared/images/hitbox/hitbox.png', 'assets/shared/images/hitbox/hitbox.xml');

        var graphic:FlxGraphic = FlxGraphic.fromFrame(frames.getByName(framestring));

        button.loadGraphic(graphic);

        button.alpha = 0;


        button.onDown.callback = function (){
            FlxTween.num(0, 0.75, .075, {ease: FlxEase.circInOut}, function (a:Float) { button.alpha = a; });
        };

        button.onUp.callback = function (){
            FlxTween.num(0.75, 0, .1, {ease: FlxEase.circInOut}, function (a:Float) { button.alpha = a; });
        }

        button.onOut.callback = function (){
            FlxTween.num(button.alpha, 0, .2, {ease: FlxEase.circInOut}, function (a:Float) { button.alpha = a; });
        }

        return button;
    }

    override public function destroy():Void
        {
            super.destroy();

            buttonLeft = null;
            buttonDown = null;
            buttonUp = null;
            buttonRight = null;
        }
} 
#end
