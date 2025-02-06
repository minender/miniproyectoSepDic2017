package com.calclogic.entity;

// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author alejandro
 */
@Entity
public class Dispone implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "dispone_id_seq")
  @SequenceGenerator(name = "dispone_id_seq", sequenceName = "dispone_id_seq", allocationSize = 1)
  private int id;

  private String numerometateorema;
  private boolean resuelto;

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "loginusuario", nullable = false)
  private Usuario usuario;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name ="metateoremaid", nullable = false)
  private Metateorema metateorema;

  public Dispone() {}

  public Dispone(
      int id,
      Usuario usuario,
      Metateorema metateorema,
      String numerometateorema,
      boolean resuelto) {
    this.id = id;
    this.usuario = usuario;
    this.metateorema = metateorema;
    this.numerometateorema = numerometateorema;
    this.resuelto = resuelto;
  }

  public Dispone(
      Usuario usuario, Metateorema metateorema, String numerometateorema, boolean resuelto) {
    this.usuario = usuario;
    this.metateorema = metateorema;
    this.numerometateorema = numerometateorema;
    this.resuelto = resuelto;
  }

  public Dispone(Usuario usuario, Metateorema metateorema, boolean resuelto) {
    this.usuario = usuario;
    this.metateorema = metateorema;
    //    this.numerometateorema = numerometateorema;
    this.resuelto = resuelto;
  }

  public Dispone(int id, Usuario usuario, Metateorema metateorema, boolean resuelto) {
    this.id = id;
    this.usuario = usuario;
    this.metateorema = metateorema;
    this.resuelto = resuelto;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public Usuario getUsuario() {
    return this.usuario;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  public Metateorema getMetateorema() {
    return this.metateorema;
  }

  public void setMetateorema(Metateorema metateorema) {
    this.metateorema = metateorema;
  }

  public String getNumerometateorema() {
    return this.numerometateorema;
  }

  public void setNumerometateorema(String numerometateorema) {
    this.numerometateorema = numerometateorema;
  }

  public boolean isResuelto() {
    return this.resuelto;
  }

  public void setResuelto(boolean resuelto) {
    this.resuelto = resuelto;
  }
}
