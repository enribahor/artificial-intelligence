import aima.core.search.framework.HeuristicFunction;


public class JarrasHeuristicFunction implements HeuristicFunction {

	@Override
	public double h(Object state) {
		EstadoJarras actualState = (EstadoJarras) state;
		
		//Calculamos la diferencia del agua de la jarra 4 con el valor buscado(2).
		double valor = abs(actualState.getJarra4()-2);
		
		//Calculamos la diferencia del agua de la jarra 3 con el valor buscado más 
		//los dos pasos necesarios para llevar el agua a la jarra 4
		double valor2 = abs(actualState.getJarra3()-2)+2;
		
		return Math.max(valor, valor2);
	}

	private double abs(int i) {
		if(i>0)
			return i;
		else return -i;
	}


}
