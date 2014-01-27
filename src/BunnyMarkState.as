package {

import flash.utils.getTimer;

import org.flixel.FlxButton;
import org.flixel.FlxG;

import org.flixel.FlxGroup;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTileblock;

public class BunnyMarkState extends FlxState {

	private var numBunnies:int;
	private var incBunnies:int;
	private var bgSize:int;
	public static var minX:int;
	public static var minY:int;
	public static var maxX:int;
	public static var maxY:int;
	private var times:Array;

	private var gravity:Number;
	private var bunnies:FlxGroup;
	private var pirate:FlxSprite;

	private var bg:FlxTileblock;
	private var addBunniesBtn:FlxButton;

	private var removeBunniesBtn:FlxButton;
	private var bunnyCounter:FlxText;
	private var fpsCounter:FlxText;

	[Embed(source="/assets/pirate.png")]
	public var PirateAsset:Class;

	[Embed(source="/assets/grass.png")]
	public var GrassAsset:Class;
	private var removeBunnies:Boolean;


	public function BunnyMarkState()
	{
		removeBunnies = false;
		gravity = 5;
		incBunnies = 50;
		numBunnies = incBunnies;

		bgSize = 32;

		minX = minY = 0;
		maxX = FlxG.width;
		maxY = FlxG.height;
		
		super();

	}


	override public function create():void
	{

		FlxG.framerate = 30;
		FlxG.flashFramerate = 30;

		var bgWidth:int = Math.ceil(FlxG.width / bgSize) * bgSize;
		var bgHeight:int = Math.ceil(FlxG.height / bgSize) * bgSize;

		bg = new FlxTileblock(0, 0, bgWidth, bgHeight);
		bg.loadTiles(GrassAsset);

		pirate = new FlxSprite();
		pirate.loadGraphic(PirateAsset);

		addBunniesBtn = new FlxButton(FlxG.width - 80 - 20, 20, "Add Bunnies", onAddBunnies);

		removeBunniesBtn = new FlxButton(20, 20, "Remove", onRemoveBunnies);

		bunnyCounter = new FlxText(0, 10, FlxG.width, "Bunnies: " + numBunnies);
		bunnyCounter.setFormat(null, 22, 0x000000, "center");

		fpsCounter = new FlxText(0, bunnyCounter.y + bunnyCounter.height + 10, FlxG.width, "FPS: " + 30);
		fpsCounter.setFormat(null, 22, 0x000000, "center");

		bunnies = new FlxGroup();

		add(bg);
		add(bunnies);
		add(bunnyCounter);
		add(pirate);
		//todo
//		add(removeBunniesBtn);
		add(addBunniesBtn);
		add(fpsCounter);

		addBunnies(numBunnies);

		times = [];
		
		FlxG.mouse.show();

	}


	private function addBunnies(numToAdd:int, x:Number = 0, y:Number = 0):void
	{
		for (var i:int = 0; i < numToAdd; i++) {
				var bunny = new Bunny(gravity,x,y);
				bunnies.add(bunny);
			}
	}

	private function onAddBunnies():void
	{
		addBunnies(incBunnies);
	}

	private function onRemoveBunnies():void
	{
		removeBunnies = true;
		RemoveBunnies(incBunnies);
		removeBunnies = false;
	}

	private function RemoveBunnies(numToRemove:int):void
	{
	        var thing = bunnies.members;
	        if ( bunnies.members!=null ) {
	            if ( thing.length >=1 ) 
	            {
					for (var i:int = 0; i < numToRemove; i++) {
	                {
	                    var bunny = bunnies.getFirstExtant();
	                    if ( bunny != null ) {
	                        bunnies.remove(bunny,true);
	                        bunny.kill();
	                        bunny.destroy();
	                        bunny = null;
	                    }
	                }
	            }
	        }
			}
	}


	override public function update():void
	{
		super.update();

	        if (FlxG.mouse.justReleased() ){
				if (!removeBunnies)
	            	addBunnies(incBunnies,FlxG.mouse.x,FlxG.mouse.y);
	        }

			var t = flash.utils.getTimer();
			pirate.x = int((FlxG.width - pirate.width) * (0.5 + 0.5 * Math.sin(t / 3000)));
			pirate.y = int(FlxG.height - 1.3 * pirate.height + 70 - 30 * Math.sin(t / 100));
			var now:Number = t / 1000;
			times.push(now);
			while(times[0] < now - 1)
			{
				times.shift();
			}

		fpsCounter.text = FlxG.width + "x" + FlxG.height + "\nFPS: " + times.length + "/" + FlxG.stage.frameRate;
		bunnyCounter.text = "Bunnies: " + bunnies.length;

	}


}
}
