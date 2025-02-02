package com.calclogic.entity;

// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import com.calclogic.lambdacalculo.Term;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * @author alejandro
 */
@Entity
public class Metateorema implements Serializable {

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "metateorema_id_seq")
  @SequenceGenerator(
      name = "metateorema_id_seq",
      sequenceName = "metateorema_id_seq",
      allocationSize = 1)
  private int id;

  private Term teoTerm;

  private String enunciado;

  private byte[] metateoserializado;

  @OneToMany(mappedBy = "metateorema", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Dispone> dispones;

  public Term getTeoTerm() {
    return teoTerm;
  }

  public void setTeoTerm(Term teoTerm) {
    this.teoTerm = teoTerm;
  }

  public Metateorema() {}

  public Metateorema(int id, String enunciado, byte[] metateoserializado) {
    this.id = id;
    this.enunciado = enunciado;
    this.metateoserializado = metateoserializado;
  }

  public Metateorema(String enunciado, byte[] metateoserializado) {
    this.enunciado = enunciado;
    this.metateoserializado = metateoserializado;
  }

  public byte[] getMetateoserializado() {
    return metateoserializado;
  }

  public void setMetateoserializado(byte[] metateoserializado) {
    this.metateoserializado = metateoserializado;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getEnunciado() {
    return this.enunciado;
  }

  public void setEnunciado(String enunciado) {
    this.enunciado = enunciado;
  }

  public Set getDispones() {
    return this.dispones;
  }

  public void setDispones(Set dispones) {
    this.dispones = dispones;
  }
}
