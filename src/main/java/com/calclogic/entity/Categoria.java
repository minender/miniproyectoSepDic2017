package com.calclogic.entity;

// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import java.io.Serializable;
import java.util.Set;
import javax.persistence.*;

@Entity
public class Categoria implements Serializable {

  @Id
  @GeneratedValue(
      strategy = GenerationType.SEQUENCE,
      generator = "categoria_id_seq")
  @SequenceGenerator(
      name = "categoria_id_seq",
      sequenceName = "categoria_id_seq",
      allocationSize = 1)
  private int id;

  @Column(nullable = false, unique = true)
  private String nombre;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "teoriaid", nullable = false)
  private Teoria teoria;

  @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
  @JoinColumn(name = "categoriaid")
  private Set<Teorema> teoremas;

  @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
  @JoinColumn(name = "categoriaid", nullable = false)
  private Set<Metateorema> metateoremas;

  public Categoria() {}

  public Categoria(String nombre, Teoria teoria) {
    this.nombre = nombre;
    this.teoria = teoria;
  }

  public Categoria(int id, String nombre, Teoria teoria) {
    this.id = id;
    this.nombre = nombre;
    this.teoria = teoria;
  }

  public Categoria(int id, String nombre, Set teoremas, Set metateoremas, Teoria teoria) {
    this.id = id;
    this.nombre = nombre;
    this.teoremas = teoremas;
    this.metateoremas = metateoremas;
    this.teoria = teoria;
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

  public Set getTeoremas() {
    return this.teoremas;
  }

  public void setTeoremas(Set teoremas) {
    this.teoremas = teoremas;
  }

  public Set getMetateoremas() {
    return this.metateoremas;
  }

  public void setMetateoremas(Set metateoremas) {
    this.metateoremas = metateoremas;
  }

  public Teoria getTeoria() {
    return this.teoria;
  }

  public void setTeoria(Teoria teoria) {
    this.teoria = teoria;
  }

  @Override
  public boolean equals(Object object) {
    boolean isEqual = false;

    if (object != null && object instanceof Categoria) {
      Categoria categoria2 = (Categoria) object;
      if (categoria2.getId() == this.getId()) {
        isEqual = true;
      }
    }

    return isEqual;
  }

  @Override
  public int hashCode() {
    return this.getId();
  }
}
