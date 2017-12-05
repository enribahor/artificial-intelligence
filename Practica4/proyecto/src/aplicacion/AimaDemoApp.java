package aplicacion;
import mapa.RouteFindingAgentApp;



/**
 * The all-in-one demo application. Shows everything within one frame.
 * 
 * @author Ruediger Lunde
 */
public class AimaDemoApp {

	/** Registers agent applications and console program demos. */
	public static void registerDemos(AimaDemoFrame frame) {
		frame.addApp(RouteFindingAgentApp.class);
	}

	/** Starts the demo. */
	public static void main(String[] args) {
		AimaDemoFrame frame = new AimaDemoFrame();
		registerDemos(frame);
		frame.setSize(800, 600);
		frame.setVisible(true);
	}
}
