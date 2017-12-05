import aima.core.search.framework.GoalTest;


public class JarrasGoalTest implements GoalTest {
	EstadoJarras goal = new EstadoJarras(0, 2);
	EstadoJarras goal1 = new EstadoJarras(1, 2);
	EstadoJarras goal2 = new EstadoJarras(2, 2);
	EstadoJarras goal3 = new EstadoJarras(3, 2);
	public boolean isGoalState(Object state) {
		EstadoJarras actualState = (EstadoJarras) state;
		if (actualState.equals(goal))
			return true;
		else if(actualState.equals(goal1))
			return true;
		else if(actualState.equals(goal2))
			return true;
		else if(actualState.equals(goal3))
			return true;
		else
			return false;
		/*
		 * Una alternativa es sencillamente hacer:
		 * return (actualState.getJarra4() == 2);
		*/
		
	}
}
