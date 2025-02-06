package com.calclogic.entity;

// Generated 27/06/2014 08:05:40 PM by Hibernate Tools 3.2.1.GA

import java.io.Serializable;
import javax.persistence.*;

/**
 * @author alejandro
 */
@Entity
public class Publicacion implements Serializable {

  @EmbeddedId private PublicacionId id;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "login", insertable = false, updatable = false)
  private Usuario usuario;

  private Termino termino;

  public Publicacion() {}

  public Publicacion(PublicacionId id, Usuario usuario) {
    this.id = id;
    this.usuario = usuario;
  }

  public PublicacionId getId() {
    return this.id;
  }

  public void setId(PublicacionId id) {
    this.id = id;
  }

  public Usuario getUsuario() {
    return this.usuario;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  public Termino getTermino() {
    return this.termino;
  }

  public void setTermino(Termino termino) {
    this.termino = termino;
  }
}
