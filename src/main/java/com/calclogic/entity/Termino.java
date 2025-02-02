package com.calclogic.entity;

import com.calclogic.lambdacalculo.Term;
import javax.persistence.*;
import java.io.Serializable;
import org.springframework.util.SerializationUtils;

/**
 * @author alejandro
 */
@Entity
public class Termino implements Serializable {

  @EmbeddedId private TerminoId id;

  @Column(nullable = false)
  private String combinador;

  @Column(nullable = false)
  private byte[] serializado;

  private Term termobject;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "login", insertable = false, updatable = false, nullable = false)
  private Usuario usuario;

  public Termino() {}

  public Termino(TerminoId id, Usuario usuario, String combinador, byte[] serializado) {
    this.id = id;
    this.usuario = usuario;
    this.combinador = combinador;
    this.serializado = serializado;
  }

  public Termino(
      TerminoId id, Usuario usuario, String combinador, byte[] serializado, Term termobject) {
    this.id = id;
    this.usuario = usuario;
    this.combinador = combinador;
    this.serializado = serializado;
    this.termobject = termobject;
  }

  public TerminoId getId() {
    return this.id;
  }

  public void setId(TerminoId id) {
    this.id = id;
  }

  public Usuario getUsuario() {
    return this.usuario;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  public String getCombinador() {
    return this.combinador;
  }

  public void setCombinador(String combinador) {
    this.combinador = combinador;
  }

  public byte[] getSerializado() {
    return this.serializado;
  }

  public void setSerializado(byte[] serializado) {
    this.serializado = serializado;
  }

  public Term getTermObject() {
    return this.termobject;
  }

  public void setTermObject(Term t) {
    this.termobject = t;
    this.serializado = SerializationUtils.serialize(t);
  }

  @Override
  public String toString() {
    return this.termobject.toString();
  }
}
