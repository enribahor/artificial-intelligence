package Jarras;

import java.util.LinkedHashSet;
import java.util.Set;

import aima.core.agent.Action;
import aima.core.search.framework.ActionsFunction;
import aima.core.search.framework.ResultFunction;

public class JarrasFunctionFactory{
	
	private static ActionsFunction _actionsFunction = null;
	private static ResultFunction _resultFunction = null;
	
	public static ActionsFunction getActionsFunction() {
		if (null == _actionsFunction) {
			_actionsFunction = new JarrasActionsFunction();
		}
	return _actionsFunction;
	}
	
	public static ResultFunction getResultFunction() {
		if (null == _resultFunction) {
			_resultFunction = new JarrasResultFunction();
		}
		return _resultFunction;
	}
	private static class JarrasActionsFunction implements ActionsFunction {
	
		@Override
		public Set<Action> actions(Object state) {
			EstadoJarras actualState = (EstadoJarras) state;
			// lista de acciones posibles
			Set<Action> actions = new LinkedHashSet<Action>();
			// si se cumplen las precondiciones y no se va a un estado de peligro entonces
			// se a??ade la accion a la lista de acciones posibles
			if (actualState.movimientoValido(EstadoJarras.LL3))
				actions.add(EstadoJarras.LL3);
			if (actualState.movimientoValido(EstadoJarras.VA3))
				actions.add(EstadoJarras.VA3);
			if (actualState.movimientoValido(EstadoJarras.VE3))
				actions.add(EstadoJarras.VE3);
			if (actualState.movimientoValido(EstadoJarras.LL4))
				actions.add(EstadoJarras.LL4);
			if (actualState.movimientoValido(EstadoJarras.VA4))
				actions.add(EstadoJarras.VA4);
			if (actualState.movimientoValido(EstadoJarras.VE4))
				actions.add(EstadoJarras.VE4);
	
			return actions;
		}
	}
		
	private static class JarrasResultFunction implements ResultFunction {
		public Object result(Object state, Action action) {
				EstadoJarras estado = (EstadoJarras) state;
			if (EstadoJarras.LL3.equals(action)) {
				EstadoJarras nuevoEstado = new EstadoJarras(estado);
				nuevoEstado.llenarJ3();
				return nuevoEstado;
			}else if(EstadoJarras.VA3.equals(action)) {
				EstadoJarras nuevoEstado = new EstadoJarras(estado);
				nuevoEstado.vaciarJ3();
				return nuevoEstado;
			}else if(EstadoJarras.VE3.equals(action)) {
				EstadoJarras nuevoEstado = new EstadoJarras(estado);
				nuevoEstado.verterJ3();
				return nuevoEstado;
			}else if(EstadoJarras.LL4.equals(action)) {
				EstadoJarras nuevoEstado = new EstadoJarras(estado);
				nuevoEstado.llenarJ4();
				return nuevoEstado;
			}else if(EstadoJarras.VA4.equals(action)) {
				EstadoJarras nuevoEstado = new EstadoJarras(estado);
				nuevoEstado.vaciarJ4();
				return nuevoEstado;
			}else if(EstadoJarras.VE4.equals(action)) {
				EstadoJarras nuevoEstado = new EstadoJarras(estado);
				nuevoEstado.verterJ4();
				return nuevoEstado;
			}			
			return state;
			
		}
	}
}
