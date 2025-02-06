package com.calclogic.entity;

// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Term;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Comparator;
import javax.persistence.*;

/**
 * Resuelve generated by hbm2java
 *
 * <p>This table implements the relation between the users and the theorems, indicating if the user
 * has solved their respective demonstrations or not.
 */
@Entity
public class Resuelve implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "resuelve_id_seq")
  @SequenceGenerator(
      name = "resuelve_id_seq",
      sequenceName = "resuelve_id_seq",
      allocationSize = 1)
  private int id;

  @Column(nullable = false)
  private String nombreteorema;

  @Column(nullable = false)
  private String numeroteorema;

  @Column(nullable = false)
  private boolean resuelto;

  @Column(nullable = false)
  private boolean esAxioma;

  @Column(nullable = false)
  private String variables;

  @Column(name = "demopendiente", nullable = false)
  private int demopendiente;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "loginusuario", nullable = false)
  private Usuario usuario;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "teoremaid", nullable = false)
  private Teorema teorema;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "categoriaid", nullable = false)
  private Categoria categoria;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "teoriaid", nullable = false)
  private Teoria teoria;

  @OneToMany(mappedBy = "resuelve", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Solucion> solucions;

  public Categoria getCategoria() {
    return categoria;
  }

  public void setCategoria(Categoria categoria) {
    this.categoria = categoria;
  }

  public void setVariables(String variables) {
    this.variables = variables;
  }

  public String getVariables() {
    return this.variables;
  }

  public String getVarAndTypes() {
    Term type = ((App) teorema.getTeoTerm()).q.type();
    if (!(type instanceof Const)) {
      String st = this.variables.split(";")[1];
      String[] vars = st.split(",");
      st = "";
      Term aux = type;
      int i = 0;
      while (i < vars.length) {
        st = st + (i == 0 ? "" : ", ") + vars[i] + ":" + ((App) aux).q;
        aux = ((App) ((App) aux).p).q;
        i++;
      }
      return st;
    } else return "";
  }

  public boolean isEsAxioma() {
    return esAxioma;
  }

  public void setEsAxioma(boolean esAxioma) {
    this.esAxioma = esAxioma;
  }

  public Resuelve() {}

  public void setDemopendiente(int demopendiete) {
    this.demopendiente = demopendiete;
  }

  public int getDemopendiente() {
    return this.demopendiente;
  }

  public Resuelve(
      Usuario usuario,
      Teorema teorema,
      String nombreteorema,
      String numeroteorema,
      Categoria categoria,
      String variables,
      Teoria teoria) {
    this.usuario = usuario;
    this.teorema = teorema;
    this.nombreteorema = nombreteorema;
    this.numeroteorema = numeroteorema;
    this.resuelto = false;
    this.demopendiente = -1;
    this.categoria = categoria;
    this.variables = variables;
    this.teoria = teoria;
  }

  public Resuelve(
      Usuario usuario,
      Teorema teorema,
      String nombreteorema,
      String numeroteorema,
      boolean resuelto,
      Categoria categoria,
      String variables,
      Teoria teoria) {
    this.usuario = usuario;
    this.teorema = teorema;
    this.nombreteorema = nombreteorema;
    this.numeroteorema = numeroteorema;
    this.resuelto = resuelto;
    this.demopendiente = -1;
    this.categoria = categoria;
    this.variables = variables;
    this.teoria = teoria;
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

  public Teorema getTeorema() {
    return this.teorema;
  }

  public void setTeorema(Teorema teorema) {
    this.teorema = teorema;
  }

  public Teoria getTeoria() {
    return this.teoria;
  }

  public void setTeoria(Teoria teoria) {
    this.teoria = teoria;
  }

  public String getNombreteorema() {
    return this.nombreteorema;
  }

  public void setNombreteorema(String nombreteorema) {
    this.nombreteorema = nombreteorema;
  }

  public String getNumeroteorema() {
    return this.numeroteorema;
  }

  public void setNumeroteorema(String numeroteorema) {
    this.numeroteorema = numeroteorema;
  }

  public boolean isResuelto() {
    return this.resuelto;
  }

  public void setResuelto(boolean resuelto) {
    this.resuelto = resuelto;
  }

  public Set getSolucions() {
    return this.solucions;
  }

  public void setSolucions(Set solucions) {
    this.solucions = solucions;
  }

  // This allows a list of Resuelves to be ordered according to the id of the theorems
  // The instruction will be: "Collections.sort(<list>, Resuelve.CompareByTheoremId)"
  public static Comparator<Resuelve> CompareByTheoremId =
      new Comparator<Resuelve>() {
        public int compare(Resuelve r1, Resuelve r2) {
          int teo1 = r1.getTeorema().getId();
          int teo2 = r2.getTeorema().getId();

          // return teo2 - teo1; // For descending order
          return teo1 - teo2; // For ascending order
        }
      };
}
