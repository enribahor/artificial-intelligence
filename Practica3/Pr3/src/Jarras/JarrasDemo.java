package Jarras;

import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import aima.core.agent.Action;
import aima.core.search.framework.GraphSearch;
import aima.core.search.framework.Problem;
import aima.core.search.framework.Search;
import aima.core.search.framework.SearchAgent;
import aima.core.search.informed.AStarSearch;
import aima.core.search.uninformed.BreadthFirstSearch;
import aima.core.search.uninformed.DepthFirstSearch;
import aima.core.search.uninformed.DepthLimitedSearch;


public class JarrasDemo {
	 
	public static void main(String[] args) {
		JarrasBFSDemo();
		JarrasDLSDemo();
		JarrasDFSDemo();
		JarrasAStarDemo();
		JarrasAStarDemo2();
	}
	
	private static void JarrasBFSDemo() {
		System.out.println("\nJarrasBFSDemo-->"); 
		try {
			// Crear un objeto Problem con la representacion de estados y operadores
			Problem problem = new Problem(estadoInicial, 
					JarrasFunctionFactory.getActionsFunction(), 
					JarrasFunctionFactory.getResultFunction(),
					new JarrasGoalTest(), 
					new DefaultStepCostFunction()); // como no hay funcion de coste en el constructor se usa el coste por defecto 
			// indicar el tipo de busqueda
			Search search = new BreadthFirstSearch(); // busqueda en anchura
			// crear un agente que realice la busqueda sobre el problema
			SearchAgent agent = new SearchAgent(problem, search);
			// escribir la solucion encontrada (operadores aplicados) e informacion sobre los recursos utilizados 
			printActions(agent.getActions());
			printInstrumentation(agent.getInstrumentation());
		}
		catch(Exception e) { 
			e.printStackTrace();
		}
	}
	
	private static void JarrasDLSDemo(){
		System.out.println("\nJarrasDLSDemo(Profundidad limitada(9))-->");
		try{
			// Crear un objeto Problem con la representacion de estados y operadores
			Problem problem = new Problem(estadoInicial, 
				JarrasFunctionFactory.getActionsFunction(), 
				JarrasFunctionFactory.getResultFunction(),
				new JarrasGoalTest(), 
				new DefaultStepCostFunction());
			
			// Busqueda en anchura
			Search search = new DepthLimitedSearch(9);;
			
			// Creamos el agente de busqueda
			SearchAgent agent = new SearchAgent(problem, search);
			
			// Escribimos la solucion encontrada (operadores aplicados).
			printActions(agent.getActions());
			
			// Informamos sobre los recursos utilizados.
			printInstrumentation(agent.getInstrumentation());
		}catch (Exception exception){
			exception.printStackTrace(); 
		}
	}
	private static void JarrasDFSDemo(){
		System.out.println("\nJarrasDFSDemo(Profundidad)-->");
		try{
			// Crear un objeto Problem con la representacion de estados y operadores
			Problem problem = new Problem(estadoInicial, 
				JarrasFunctionFactory.getActionsFunction(), 
				JarrasFunctionFactory.getResultFunction(),
				new JarrasGoalTest(), 
				new DefaultStepCostFunction());
			
			// Busqueda en anchura
			Search search = new DepthFirstSearch(new GraphSearch());;
			
			// Creamos el agente de busqueda
			SearchAgent agent = new SearchAgent(problem, search);
			
			// Escribimos la solucion encontrada (operadores aplicados).
			printActions(agent.getActions());
			
			// Informamos sobre los recursos utilizados.
			printInstrumentation(agent.getInstrumentation());
		}catch (Exception exception){
			exception.printStackTrace(); 
		}
	}
	private static void JarrasAStarDemo(){
		System.out.println("\nJarrasAStarDemo(Kiker heuristic)-->");
		try{
			// Crear un objeto Problem con la representacion de estados y operadores
			Problem problem = new Problem(estadoInicial, 
				JarrasFunctionFactory.getActionsFunction(), 
				JarrasFunctionFactory.getResultFunction(),
				new JarrasGoalTest(), 
				new DefaultStepCostFunction());
			
			// Busqueda en anchura
			Search search = new AStarSearch(new GraphSearch(),
					new KikerHeuristicFunction());
			//Esta heuristica no es admisible.
			
			// Creamos el agente de busqueda
			SearchAgent agent = new SearchAgent(problem, search);
			
			// Escribimos la solucion encontrada (operadores aplicados).
			printActions(agent.getActions());
			
			// Informamos sobre los recursos utilizados.
			printInstrumentation(agent.getInstrumentation());
		}catch (Exception exception){
			exception.printStackTrace(); 
		}
	}
	private static void JarrasAStarDemo2(){
		System.out.println("\nJarrasAStarDemo2(Jarras heuristic)-->");
		try{
			// Crear un objeto Problem con la representacion de estados y operadores
			Problem problem = new Problem(estadoInicial, 
				JarrasFunctionFactory.getActionsFunction(), 
				JarrasFunctionFactory.getResultFunction(),
				new JarrasGoalTest(), 
				new DefaultStepCostFunction());
			
			// Busqueda en anchura
			Search search = new AStarSearch(new GraphSearch(),
					new JarrasHeuristicFunction());
			
			// Creamos el agente de busqueda
			SearchAgent agent = new SearchAgent(problem, search);
			
			// Escribimos la solucion encontrada (operadores aplicados).
			printActions(agent.getActions());
			
			// Informamos sobre los recursos utilizados.
			printInstrumentation(agent.getInstrumentation());
		}catch (Exception exception){
			exception.printStackTrace(); 
		}
	}
	
	private static void printInstrumentation(Properties properties) {
		Iterator<Object> keys = properties.keySet().iterator();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			String property = properties.getProperty(key);
			System.out.println(key + " : " + property);
		}

	}

	private static void printActions(List<Action> actions) {
		for (int i = 0; i < actions.size(); i++) {
			String action = actions.get(i).toString();
			System.out.println(action);
		}
	}
	
	private static EstadoJarras estadoInicial = new EstadoJarras();
}
