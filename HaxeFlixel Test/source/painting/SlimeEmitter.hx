package painting;

import characters.Player;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

/**
 * Emits slime
 */
class SlimeEmitter extends FlxEmitter
{
	private var player : Player;
	
	public function new(player : Player) 
	{
		this.player = player;
		super(0, 0, 2);
		
		for (i in 0...100)
		{
			var particle : FlxParticle = new FlxParticle();
			particle.makeGraphic(2, 2, 0xff00ff00);
			particle.exists = false;
			emitter.add(particle);
		}
		
	}
	
}