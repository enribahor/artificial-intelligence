package Jarras;

import aima.core.agent.Action;
import aima.core.agent.impl.DynamicAction;

public class EstadoJarras {
	
	public EstadoJarras(){
		this(0,0);
	}
	
	public EstadoJarras(EstadoJarras ej){
		this(ej.getJ4(), ej.getJ3());		
	}
	
	public EstadoJarras(int j4, int j3){
		this.setJ4(j4);
		this.setJ3(j3);
	}
	 
	public int getJ4() {
		return j4;
	}

	public void setJ4(int j4) {
		this.j4 = j4;
	}

	public int getJ3() {
		return j3;
	}

	public void setJ3(int j3) {
		this.j3 = j3;
	}

	public void llenarJ4(){
		this.j4 = TAM_JARRA_4;
	}
	
	public void llenarJ3(){
		this.j3 = TAM_JARRA_3;
	}
	
	public void vaciarJ4(){
		this.j4 = 0;
	}
	
	public void vaciarJ3(){
		this.j3 = 0;
	}
	
	public void verterJ4(){
		if((this.j4 + this.j3) <= TAM_JARRA_3) {
			this.j3 = this.j3 + this.j4;
			this.j4 = 0;
		} else {
			this.j4 = this.j4 - (TAM_JARRA_3 - this.j3);
			this.j3 = TAM_JARRA_3;
		}
	}
	
	public void verterJ3(){
		if((this.j3 + this.j4) <= TAM_JARRA_4) {
			this.j4 = this.j4 + this.j3;
			this.j3 = 0;
		} else {
			this.j3 = this.j3 - (TAM_JARRA_4 - this.j4);
			this.j4 = TAM_JARRA_4;
		}
	}
	
	public boolean movimientoValido(Action accion){
		boolean valido = false;
		if(accion.equals(LL4)){
			if(this.j4 < TAM_JARRA_4) {
				return true;
			} else
				return false;
		} else if (accion.equals(LL3)){
			if(this.j3 < TAM_JARRA_3) {
				return true;
			} else
				return false;			
		}else if(accion.equals(VA4)){
			if(this.j4 > 0) {
				return true;
			} else
				return false;
		} else if(accion.equals(VA3)){
			if(this.j3 > 0) {
				return true;
			} else
				return false;
		} else if(accion.equals(VE4)){
			if(this.j4 > 0 && this.j3 < TAM_JARRA_3)
				return true;
			else 
				return false;
		} else if (accion.equals(VE3)){
			if(this.j3 > 0 && this.j4 < TAM_JARRA_4)
				return true;
			else 
				return false;
		} else {
			;
		}
		
		return valido;
	}
	
	public boolean equals(Object o) { 
		if (this == o)
			return true; 
		if ((o == null) || (this.getClass() != o.getClass()))
			return false;
		EstadoJarras otroEstado = (EstadoJarras) o;
		if (this.getJ4() == otroEstado.getJ4() && 
			this.getJ3() == otroEstado.getJ3()) {
			return true;
		} else {
			return false;
		}	 
	}
	
	public int hashCode() {
		return (10 * this.j4) + this.j3;
	}
	

	public static Action LL4 = new DynamicAction("Llenar jarra 4");
	public static Action LL3 = new DynamicAction("Llenar jarra 3");
	public static Action VA4 = new DynamicAction("Vaciar jarra 4");
	public static Action VA3 = new DynamicAction("Vaciar jarra 3");
	public static Action VE4 = new DynamicAction("Verter jarra 4");
	public static Action VE3 = new DynamicAction("Verter jarra 3");
	
	
	private int j4;
	private int j3;
	private static int TAM_JARRA_3 = 3;
	private static int TAM_JARRA_4 = 4;
}
