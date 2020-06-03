package com.howtodoinjava.entity;
// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import com.howtodoinjava.lambdacalculo.Term;

import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.springframework.util.SerializationUtils;




/**
 * Predicado generated by hbm2java
 */
public class Predicado extends notacionOwner implements java.io.Serializable {


     private PredicadoId id;
     private Usuario usuario;
     private String predicado;
     private String alias;
     private byte[] predserializado;
     private String argumentos;
     private String aliases;
     private String notacion;
     private Term term;
     

    public Predicado() {
    }

    public Predicado(PredicadoId id, Usuario usuario, String predicado, String alias, byte[] predserializado, String argumentos, String aliases, String notacion) {
       this.id = id;
       this.usuario = usuario;
       this.predicado = predicado;
       this.alias = alias;
       this.predserializado = predserializado;
       this.argumentos = argumentos;
       this.aliases = aliases;
       setNotacion(notacion);
    }
   
    public PredicadoId getId() {
        return this.id;
    }
    
    public void setId(PredicadoId id) {
        this.id = id;
    }
    public Usuario getUsuario() {
        return this.usuario;
    }
    
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    public String getPredicado() {
        return this.predicado;
    }
    
    public void setPredicado(String predicado) {
        this.predicado = predicado;
    }
    public String getAlias() {
        return this.alias;
    }
    
    public void setAlias(String alias) {
        this.alias = alias;
    }
    public byte[] getPredserializado() {
        return this.predserializado;
    }
    
    public void setPredserializado(Term t) {
        this.predserializado= SerializationUtils.serialize(t);
    }
    
    public void setPredserializado(byte[] predserializado) {
        this.predserializado = predserializado;
    }
    public String getArgumentos() {
        return this.argumentos;
    }
    
    public void setArgumentos(String argumentos) {
        this.argumentos = argumentos;
    }
    
    public void setTerm(Term t) {
        term = t;
    }
    
    public Term getTerm() {
        return term;
    }
    
    public String getAliases() {
		return aliases;
	}

	public void setAliases(String aliases) {
		this.aliases = aliases;
	}

	public String getNotacion() {
		return notacion;
	}

	public void setNotacion(String notacion) {
		
		if(notacion == null || notacion.equals("")) {
			this.notacion = defaultNotacion();
		}else {
			this.notacion = notacion;
		}
	}
	
	
	/**
	 * This function will return a notation of the form Alias(%(an1),%(an2),...)
	 * based on this object's notacion
	 * @return a String defaultNotacion
	 */
	public String defaultNotacion() {
		
		
		StringBuilder defaultNotacion = new StringBuilder(this.id.getAlias() + '(');
		
		int args = this.argumentos.split(",").length;
		
		String currentVar;
		for(int i = 1; i< args + 1; i++) {
			currentVar = "%(an" + String.valueOf(i) + "),";
			defaultNotacion.append(currentVar);
		}
		// Delete the extra , 
		if(args > 0) {
			defaultNotacion.deleteCharAt(defaultNotacion.length() - 1);
		}
		defaultNotacion.append(')');
		
		return defaultNotacion.toString();
	}




}


