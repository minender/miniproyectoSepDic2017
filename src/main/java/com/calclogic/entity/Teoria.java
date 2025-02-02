package com.calclogic.entity;

// Generated Feb 27, 2019 12:50:11 PM by Hibernate Tools 3.2.1.GA

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

/**
 * @author alejandro
 */
@Entity
public class Teoria implements Serializable {

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "teoria_id_seq")
  @SequenceGenerator(name = "teoria_id_seq", sequenceName = "teoria_id_seq", allocationSize = 1)
  private int id;

  @Column(nullable = false)
  private String nombre;

  public Teoria() {}

  public Teoria(String nombre) {
    this.nombre = nombre;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getNombre() {
    return nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }
}
