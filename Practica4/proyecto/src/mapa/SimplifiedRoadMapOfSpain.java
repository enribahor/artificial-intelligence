package mapa;
import aima.core.environment.map.ExtendableMap;


/**
 * Represents a simplified road map of Spain. The initialization method is
 * declared static. So it can also be used to initialize other specialized
 * subclasses of {@link ExtendableMap} with road map data from Spain. The
 * data was extracted from a class developed by Felix Knittel.
 * 
 * @author Ruediger Lunde, Enrique Ballesteros and Iker Prado
 */
public class SimplifiedRoadMapOfSpain extends ExtendableMap {

	public SimplifiedRoadMapOfSpain() {
		initMap(this);
	}

	// Locations
	public static final String MADRID = "Madrid";
	public static final String TOLEDO = "Toledo";
	public static final String GUADALAJARA = "Guadalajara";
	public static final String CUENCA = "Cuenca";
	public static final String ALBACETE = "Albacete";
	public static final String CIUDAD_REAL = "Ciudad Real";
	public static final String SORIA = "Soria";
	public static final String PALENCIA = "Palencia";
	public static final String SEGOVIA = "Segovia";
	public static final String VALLADOLID = "Valladolid";
	public static final String SALAMANCA = "Salamanca";
	public static final String BURGOS = "Burgos";
	public static final String ZAMORA = "Zamora";
	public static final String AVILA = "Avila";
	public static final String TOMELLOSO = "Tomelloso";
	
	//public static final String CACERES = "Caceres";
	//public static final String BARCELONA = "Barcelona";
	/**
	 * Initializes a map with a simplified road map of Australia.
	 */
	public static void initMap(ExtendableMap map) {
		map.clear();
		// Add links
		// Distances from http://maps.google.com
		map.addBidirectionalLink(MADRID, AVILA, 108.0);
		map.addBidirectionalLink(MADRID, SEGOVIA, 93.0);
		map.addBidirectionalLink(MADRID, GUADALAJARA, 60.0);
		map.addBidirectionalLink(MADRID, TOLEDO, 72.0);
		map.addBidirectionalLink(MADRID, CUENCA, 170.0);
		map.addBidirectionalLink(AVILA, SALAMANCA, 110.0);
		map.addBidirectionalLink(SALAMANCA, ZAMORA, 65.0);
		map.addBidirectionalLink(ZAMORA, VALLADOLID, 100.0);
		map.addBidirectionalLink(VALLADOLID, SEGOVIA, 120.0);
		map.addBidirectionalLink(VALLADOLID, PALENCIA, 50.0);
		map.addBidirectionalLink(PALENCIA, BURGOS, 90.0);
		map.addBidirectionalLink(SORIA, BURGOS, 140.0);
		map.addBidirectionalLink(GUADALAJARA, SORIA, 170.0);
		map.addBidirectionalLink(CUENCA, ALBACETE, 160.0);
		map.addBidirectionalLink(TOLEDO, CIUDAD_REAL, 120.0);
		map.addBidirectionalLink(CIUDAD_REAL, TOMELLOSO, 90.0);
		map.addBidirectionalLink(ALBACETE, TOMELLOSO, 130.0);
		// Locations coordinates
		// Madrid is taken as central point with coordinates (0|0)
		// Therefore x and y coordinates refer to Madrid. Note that
		// the coordinates are not very precise and partly modified to
		// get a more real shape of Australia.
		
		map.setPosition(MADRID, 0, 0);
		map.setPosition(TOLEDO, -30, 60);
		map.setPosition(GUADALAJARA, 45, -25);
		map.setPosition(CUENCA, 130, 40);
		map.setPosition(ALBACETE, 160, 160);
		map.setPosition(CIUDAD_REAL, -20, 160);
		map.setPosition(SORIA, 100, -150);
		map.setPosition(PALENCIA, -70, -175);
		map.setPosition(SEGOVIA, -40, -60);
		map.setPosition(VALLADOLID, -85, -135);
		map.setPosition(SALAMANCA, -165, -65);
		map.setPosition(BURGOS, 0, -215);
		map.setPosition(ZAMORA, -170, -125);
		map.setPosition(AVILA, -85, -25);
		map.setPosition(TOMELLOSO, 60, 145);
	}
}
