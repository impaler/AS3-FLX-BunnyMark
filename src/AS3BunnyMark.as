/**
 * Date: 9/12/12
 * Time: 7:08 PM
 */
package {

import org.flixel.FlxGame;

[SWF(width='640',height='480',backgroundColor='#ffffff',frameRate='30')]

public class AS3BunnyMark extends FlxGame{
	
	public function AS3BunnyMark()
	{
		super(640,480,BunnyMarkState,1,60,30);
	}
	
}
}
