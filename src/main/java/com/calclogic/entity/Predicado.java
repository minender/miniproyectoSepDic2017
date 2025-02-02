package com.calclogic.entity;
// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import com.calclogic.lambdacalculo.Term;
import javax.persistence.*;
import java.io.Serializable;

//import org.eclipse.jdt.internal.compiler.ast.ThisReference;
import org.springframework.util.SerializationUtils;


/**
 * @author alejandro
 */
@Entity
public final class Predicado extends notacionOwner implements Serializable {

  @EmbeddedId private PredicadoId id;

  @Column(nullable = false)
  private String predicado;

  @Column(nullable = false)
  private String argumentos;

  @Column(nullable = false)
  private String aliases;

  @Column(nullable = false)
  private String notacion;

  private Term term;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "login", insertable = false, updatable = false)
  private Usuario usuario;

  public Predicado() {}

  public Predicado(
      PredicadoId id,
      Usuario usuario,
      String predicado,
      String alias,
      String argumentos,
      String aliases,
      String notacion) {
    this.id = id;
    this.usuario = usuario;
    this.predicado = predicado;
//    this.alias = alias;
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

//  public String getAlias() {
//    return this.alias;
//  }

//  public void setAlias(String alias) {
//    this.alias = alias;
//  }

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

  @Override
  public String getNotacion() {
    return notacion;
  }

  @Override
  public void setNotacion(String notacion) {

    if (notacion == null || notacion.equals("")) {
      this.notacion = defaultNotacion();
    } else {
      this.notacion = notacion;
    }
  }

  /**
   * This function will return a notation of the form Alias(%(an1),%(an2),...) based on this
   * object's notacion
   *
   * @return a String defaultNotacion
   */
  public String defaultNotacion() {

    StringBuilder defaultNotacion = new StringBuilder(this.id.getAlias() + '(');

    int args = this.argumentos.split(",").length;

    String currentVar;
    for (int i = 1; i < args + 1; i++) {
      currentVar = "%(an" + String.valueOf(i) + "),";
      defaultNotacion.append(currentVar);
    }
    // Delete the extra ,
    if (args > 0) {
      defaultNotacion.deleteCharAt(defaultNotacion.length() - 1);
    }
    defaultNotacion.append(')');

    return defaultNotacion.toString();
  }
}


