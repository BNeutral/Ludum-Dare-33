import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.Scene;
import com.haxepunk.HXP;

class MainScene extends Scene
{
	public override function begin()
	{
		addGraphic(new Text("@", HXP.halfWidth, HXP.halfHeight));
	}
}