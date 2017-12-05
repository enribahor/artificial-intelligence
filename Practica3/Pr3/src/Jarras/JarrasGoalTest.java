package Jarras;

import aima.core.search.framework.GoalTest;

public class JarrasGoalTest implements GoalTest{
	
	@Override
	public boolean isGoalState(Object estadoJarras) {
		EstadoJarras otroEstado = (EstadoJarras) estadoJarras;
		if(otroEstado.getJ4() == 2)
			return true;
		else
			return false;
	}
	
}
