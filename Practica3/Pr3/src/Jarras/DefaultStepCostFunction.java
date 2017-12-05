package Jarras;

import aima.core.agent.Action;
import aima.core.search.framework.StepCostFunction;


public class DefaultStepCostFunction implements StepCostFunction{
	public double c(Object stateFrom, Action action, Object stateTo){
		return 1;
	}
}