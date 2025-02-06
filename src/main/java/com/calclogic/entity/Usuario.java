package com.calclogic.entity;
// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Usuario generated by hbm2java
 *
 * This table has all the users who have registered in the system,
 * including their logins, encrypted passwords and a boolean that
 * indicates if the user activated the "automatic substitution".
 */
@Entity
public class Usuario  implements Serializable {

  @Id
  @Column(nullable = false, unique = true)
  @NotEmpty(message = "You must not leave this field empty")
  private String login;

  @Column(nullable = false)
  private String nombre;

  @Column(nullable = false)
  private String apellido;

  @Column(nullable = false)
  private String correo;

  @Column(nullable = false)
  private String password;

  @Column(name = "admin", nullable = false)
  private boolean admin;

  @Column(name = "autosust", nullable = false)
  private boolean autosust;

  @ManyToOne
  @JoinColumn(name = "materiaid", nullable = false)
  private Materia materia;

  @ManyToOne
  @JoinColumn(name = "teoriaid", nullable = false)
  private Teoria teoria;

  @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Predicado> predicados;

  @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Termino> terminos;

  @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Dispone> dispones;

  @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Resuelve> resuelves;

  public Usuario() {}

  public Usuario(
      String login,
      String nombre,
      String apellido,
      String correo,
      String password,
      boolean admin,
      Teoria teoria) {
    this.login = login;
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.password = password;
    this.admin = admin;
    this.autosust = false;
    this.teoria = teoria;
  }

  public Usuario(
      String login,
      String nombre,
      String apellido,
      String correo,
      String password,
      Materia materia,
      boolean admin,
      Teoria teoria) {
    this.login = login;
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.password = password;
    this.materia = materia;
    this.admin = admin;
    this.autosust = false;
    this.teoria = teoria;
  }

  public Usuario(
      String login,
      String nombre,
      String apellido,
      String correo,
      String password,
      Materia materia,
      boolean admin,
      Set predicados,
      Set terminos,
      Set dispones,
      Set resuelves,
      Teoria teoria) {
    this.login = login;
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.password = password;
    this.materia = materia;
    this.admin = admin;
    this.predicados = predicados;
    this.terminos = terminos;
    this.dispones = dispones;
    this.resuelves = resuelves;
    this.autosust = false;
    this.teoria = teoria;
  }

//  public Long getId() {
//    return this.id;
//  }
//
//  public void setId(int id) {
//    this.id = id;
//  }

  public String getLogin() {
    return this.login;
  }

  public void setLogin(String login) {
    this.login = login;
  }

  public String getNombre() {
    return this.nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  public String getApellido() {
    return this.apellido;
  }

  public void setApellido(String apellido) {
    this.apellido = apellido;
  }

  public String getCorreo() {
    return this.correo;
  }

  public void setCorreo(String correo) {
    this.correo = correo;
  }

  public String getPassword() {
    return this.password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Materia getMateria() {
    return this.materia;
  }

  public void setMateria(Materia materia) {
    this.materia = materia;
  }

  public Teoria getTeoria() {
    return this.teoria;
  }

  public void setTeoria(Teoria teoria) {
    this.teoria = teoria;
  }

  public boolean isAdmin() {
    return this.admin;
  }

  public void setAdmin(boolean admin) {
    this.admin = admin;
  }

  public boolean isAutosust() {
    return this.autosust;
  }

  public void setAutosust(boolean autosust) {
    this.autosust = autosust;
  }

  public Set getPredicados() {
    return this.predicados;
  }

  public void setPredicados(Set predicados) {
    this.predicados = predicados;
  }

  public Set getTerminos() {
    return this.terminos;
  }

  public void setTerminos(Set terminos) {
    this.terminos = terminos;
  }

  public Set getDispones() {
    return this.dispones;
  }

  public void setDispones(Set dispones) {
    this.dispones = dispones;
  }

  public Set getResuelves() {
    return this.resuelves;
  }

  public void setResuelves(Set resuelves) {
    this.resuelves = resuelves;
  }
}

