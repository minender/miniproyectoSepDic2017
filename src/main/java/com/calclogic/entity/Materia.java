package com.calclogic.entity;


import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;
import java.io.Serializable;

/**
 * @author alejandro
 */
@Entity
public class Materia implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "materia_id_seq")
  @SequenceGenerator(name = "materia_id_seq", sequenceName = "materia_id_seq", allocationSize = 1)
  private int id;

  @Column(nullable = false)
  private String nombre;

  @OneToMany(mappedBy = "materia", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Usuario> usuarios;

  public Materia() {}

  public Materia(int id, String nombre) {
    this.id = id;
    this.nombre = nombre;
  }

  public Materia(int id, String nombre, Set usuarios) {
    this.id = id;
    this.nombre = nombre;
    this.usuarios = usuarios;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getNombre() {
    return this.nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  public Set getUsuarios() {
    return this.usuarios;
  }

  public void setUsuarios(Set usuarios) {
    this.usuarios = usuarios;
  }
}