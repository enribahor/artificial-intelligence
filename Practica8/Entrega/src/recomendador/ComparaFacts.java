package recomendador;

import java.util.Comparator;

import jess.Fact;
import jess.JessException;

public class ComparaFacts implements Comparator<Fact>{
	//Podemos ordenar por lo que queramos. Acualmente es un orden lexicográfico descendente.
	@Override
	public int compare(Fact o1, Fact o2){
		try {
			return (o2.getSlotValue("ciudad").toString()).compareToIgnoreCase(o1.getSlotValue("ciudad").toString());
		} catch (JessException e) {
			e.printStackTrace();
		}
		return 0;
		
	}
}
