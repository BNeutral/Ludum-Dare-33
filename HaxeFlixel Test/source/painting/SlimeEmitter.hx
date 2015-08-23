package painting;

import characters.Player;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;

/**
 * Emits slime
 */
class SlimeEmitter extends FlxEmitter
{
	private var player : Player;
	
	public function new(player : Player, map : FlxTilemap, canvas : SlimeCanvas) 
	{
		this.player = player;
		super(0, 0, 20);
		
		for (i in 0...20)
		{
			var particle : FlxParticle = new SlimeParticle(canvas, map);
			particle.makeGraphic(2, 2, 0xff00ff00);
			particle.exists = false;
			add(particle);
		}
		
		set_gravity(Constants.gravity);
		
		updatePos();
		
		start(false, 4, 0.02, 0, 2);
		
	}
	
	override public function update():Void 
	{
		updatePos();
		checkPlayerStatus();
		super.update();				
	}
	
	/**
	 * Checks what the player is doing and decides on the direction
	 */
	private function checkPlayerStatus() : Void
	{
		if (!player.wasMoving)
		{
			this.on = false;
		}
		else
		{
			this.on = true;
			if (player.wasTouchingCeil)
			{
				xVelocity.min = -100;
				xVelocity.max = 100;
				yVelocity.min = -600;
				yVelocity.max = -500;
			}
			else if (player.wasTouchingLeft)
			{
				xVelocity.min = -200;
				xVelocity.max = -100;
				yVelocity.min = -400;
				yVelocity.max = -200;
			}
			else if (player.wasTouchingRight)
			{
				xVelocity.min = 100;
				xVelocity.max = 200;
				yVelocity.min = -400;
				yVelocity.max = -200;
			}
			else if (player.wasTouchingFloor)
			{
				xVelocity.min = -100;
				xVelocity.max = 100;
				yVelocity.min = 200;
				yVelocity.max = 100;
			}
		}
	}
	
	/**
	 * Updates the position of this thing
	 */
	private function updatePos()
	{
		this.x = player.x + player.width/2;
		this.y = player.y + player.height/2;
	}
}