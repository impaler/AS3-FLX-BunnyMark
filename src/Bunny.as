/**
 * Date: 9/12/12
 * Time: 9:42 PM
 */
package {
import flashx.textLayout.formats.Float;

import org.flixel.FlxSprite;

public class Bunny extends FlxSprite {
	
	[Embed(source="/assets/wabbit_alpha.png")]
	public var BunnyAsset:Class;
	
	public function Bunny(gravity:Number = 0,x:Number=0,y:Number=0)
	{
		super(x,y);
		
		loadGraphic(BunnyAsset);
		velocity.x = 50 * (Math.random() * 5) * (Math.random() < 0.5 ? 1 : -1);
		velocity.y = 50 * ((Math.random() * 5) - 2.5) * (Math.random() < 0.5 ? 1 : -1);
		
		acceleration.y = gravity;
			
		angle = 15 - Math.random() * 30;
		angularVelocity = 30 * (Math.random() * 5) * (Math.random() < 0.5 ? 1 : -1);
		
	}
	
	override public function update():void 
		{
			super.update();
			
			//bottleneck for flash software rendering
//			alpha = 0.3 + 0.7 * y / BunnyMarkState.maxY;
			
			if (x > BunnyMarkState.maxX)
			{
				velocity.x *= -1;
				x = BunnyMarkState.maxX;
			}
			else if (x < BunnyMarkState.minX)
			{
				velocity.x *= -1;
				x = BunnyMarkState.minX;
			}
			if (y > BunnyMarkState.maxY)
			{
				velocity.y *= -0.8;
				y = BunnyMarkState.maxY;
				if (Math.random() > 0.5) velocity.y -= 3 + Math.random() * 4;
			}
			else if (y < BunnyMarkState.minY)
			{
				velocity.y *= -0.8;
				y = BunnyMarkState.minY;
			}
		}
}
}
