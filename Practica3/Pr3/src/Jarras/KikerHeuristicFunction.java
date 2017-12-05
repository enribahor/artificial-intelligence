package Jarras;

import aima.core.search.framework.HeuristicFunction;


public class KikerHeuristicFunction implements HeuristicFunction{

	@Override
	public double h(Object state) {
		EstadoJarras actualState = (EstadoJarras) state;
		double valor = abs(actualState.getJ4()-2);
		return valor;
	}

	private double abs(int i) {
		if(i>0)
			return i;
		else return -i;
	}

}
