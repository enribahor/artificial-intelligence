package recomendador;

import jess.JessException;
import jess.RU;
import jess.Value;
import jess.ValueVector;

public enum Intereses {
			OCIO, FIESTA, GASTRONOMIA, TURISMO;
			public static boolean isInterest(String interes){
				if (interes.compareToIgnoreCase("OCIO")==0)
					return true;
				else if (interes.compareToIgnoreCase("FIESTA")==0)
					return true;
				else if (interes.compareToIgnoreCase("GASTRONOMIA")==0)
					return true;
				else if (interes.compareToIgnoreCase("TURISMO")==0)
					return true;
				
				else return false;				
			}
			
			public static void nuevoInteres(ValueVector vv){
				try {
					if(!vv.contains(new Value("ocio", RU.SYMBOL)))
						vv.add(new Value("ocio", RU.SYMBOL) );
					else if(!vv.contains(new Value("fiesta", RU.SYMBOL)))
						vv.add(new Value("fiesta", RU.SYMBOL));
					else if(!vv.contains(new Value("gastronomia", RU.SYMBOL)))
						vv.add(new Value("gastronomia", RU.SYMBOL));
					else if(!vv.contains(new Value("turismo", RU.SYMBOL)))	
						vv.add(new Value("turismo", RU.SYMBOL));
				} catch (JessException e) {
					e.printStackTrace();
				}
				
			}
			//indica si queda algún interés que se pueda añadir
			public static boolean quedanIntereses(ValueVector vv){
				try {
					if(!vv.contains(new Value("ocio", RU.SYMBOL)))
						return true;
					else if(!vv.contains(new Value("fiesta", RU.SYMBOL)))
						return true;
					else if(!vv.contains(new Value("gastronomia", RU.SYMBOL)))
						return true;
					else if(!vv.contains(new Value("turismo", RU.SYMBOL)))	
						return true;
					else return false;
				} catch (JessException e) {
					e.printStackTrace();
				}
				return false;
				
			}
}
