package com.calclogic.entity;

// Generated Feb 27, 2019 12:50:11 PM by Hibernate Tools 3.2.1.GA

import com.calclogic.lambdacalculo.TypeVerificationException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.*;
import java.io.Serializable;

import org.antlr.v4.parse.ANTLRParser.throwsSpec_return;
import org.apache.commons.lang3.StringUtils;

// import org.apache.naming.java.javaURLContextFactory;

/**
 * Simbolo generated by hbm2java
 *
 * <p>This table has all the operators and constants along with their respective LaTeX notations.
 */
@Entity
@Table(name = "Simbolo")
public class Simbolo extends notacionOwner implements Serializable {

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "simbolo_id_seq")
  @SequenceGenerator(name = "simbolo_id_seq", sequenceName = "simbolo_id_seq", allocationSize = 1)
  private int id;

  @Column(nullable = false)
  private String notacion_latex;

  @Column(nullable = false)
  private int argumentos;

  @Column(nullable = false)
  private boolean esInfijo;

  @Column(nullable = false)
  private int asociatividad;

  @Column(nullable = false)
  private int precedencia;

  @Column(nullable = false)
  private String notacion;

  @Column(nullable = false)
  private String tipo;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "teoriaid", nullable = false)
  private Teoria teoria;

  public Simbolo(
      String notacion_latex,
      boolean esInfijo,
      int precedencia,
      String notacion,
      Teoria teoria,
      String tipo) {
    this.notacion_latex = notacion_latex;
    this.esInfijo = esInfijo;
    this.precedencia = precedencia;
    this.notacion = notacion;
    this.teoria = teoria;
    this.tipo = tipo;
  }

  public Simbolo(
      String notacion_latex,
      int argumentos,
      boolean esInfijo,
      int precedencia,
      String notacion,
      Teoria teoria,
      String tipo) {
    this.notacion_latex = notacion_latex;
    this.argumentos = argumentos;
    this.esInfijo = esInfijo;
    this.precedencia = precedencia;
    this.notacion = notacion;
    this.teoria = teoria;
    this.tipo = tipo;
  }

  public Simbolo(
      String notacion_latex,
      boolean esInfijo,
      int asociatividad,
      int precedencia,
      String notacion,
      Teoria teoria,
      String tipo) {
    this.notacion_latex = notacion_latex;
    this.esInfijo = esInfijo;
    this.asociatividad = asociatividad;
    this.precedencia = precedencia;
    this.notacion = notacion;
    this.teoria = teoria;
    this.tipo = tipo;
  }

  public Simbolo(
      String notacion_latex,
      int argumentos,
      boolean esInfijo,
      int asociatividad,
      int precedencia,
      String notacion,
      Teoria teoria,
      String tipo) {
    this.notacion_latex = notacion_latex;
    this.argumentos = argumentos;
    this.esInfijo = esInfijo;
    this.asociatividad = asociatividad;
    this.precedencia = precedencia;
    this.notacion = notacion;
    this.teoria = teoria;
    this.tipo = tipo;
  }

  public Simbolo() {}

  public int getId() {
    return id;
  }

  public String getNotacion_latex() {
    return notacion_latex;
  }

  public int getArgumentos() {
    return argumentos;
  }

  @Override
  public int getArgs() {
    return this.getArgumentos();
  }

  public boolean isEsInfijo() {
    return esInfijo;
  }

  public boolean isInf() {
    return esInfijo;
  }

  public int getAsociatividad() {
    return asociatividad;
  }

  public int getAs() {
    return asociatividad;
  }

  public int getPrecedencia() {
    return precedencia;
  }

  public int getPr() {
    return precedencia;
  }

  public String getNotacion() {
    return notacion;
  }

  public String getTipo() {
    return tipo;
  }

  public Teoria getTeoria() {
    return teoria;
  }

  public boolean isQuantifier() {
    return notacion.contains("v");
  }

  public int getArgumentosQuantifier() {
    return argumentos + StringUtils.countMatches(notacion, "v");
  }

  public void setId(int id) {
    this.id = id;
  }

  public void setNotacion_latex(String notacion_latex) {
    this.notacion_latex = notacion_latex;
  }

  public void setArgumentos(int argumentos) {
    this.argumentos = argumentos;
  }

  public void setEsInfijo(boolean esInfijo) {
    this.esInfijo = esInfijo;
  }

  public void setAsociatividad(int asociatividad) {
    this.asociatividad = asociatividad;
  }

  public void setPrecedencia(int precedencia) {
    this.precedencia = precedencia;
  }

  public void setNotacion(String notacion) {
    this.notacion = notacion;
  }

  public void setTipo(String tipo) {
    this.tipo = tipo;
  }

  public void setTeoria(Teoria teoria) {
    this.teoria = teoria;
  }

  public static String[] splitTipo(String tipo) throws TypeVerificationException {
    String[] arr = new String[1];
    List<String> tipos = new ArrayList<>();
    int parOpen = 0;
    int expBegin = 0;
    int expEnd = 0;
    for (int i = 0; i < tipo.length(); i++) {
      char c = tipo.charAt(i);
      if (c == '(') parOpen++;
      else if (c == ')') parOpen--;
      if (parOpen < 0) throw new TypeVerificationException();

      if (c == '-' && parOpen == 0) {
        expEnd = i;
        if (tipo.charAt(expBegin) == '(') {
          expBegin++;
          expEnd--;
        }
        tipos.add(tipo.substring(expBegin, expEnd));
      }

      if (i == tipo.length() - 1) {
        if (parOpen != 0) throw new TypeVerificationException();
        else {
          expEnd = i + 1;
          if (tipo.charAt(expBegin) == '(') {
            expBegin++;
            expEnd--;
          }
          tipos.add(tipo.substring(expBegin, expEnd));
        }
      }
      if (c == '>' && parOpen == 0) expBegin = i + 1;
    }

    return tipos.toArray(new String[tipos.size()]);
  }

  public static String joinTipo(String[] tipos) {
    String tipo = "";
    for (String t : tipos) {
      if (t.length() > 1) t = '(' + t + ')';
      if (tipo.length() == 0) tipo = t;
      else tipo += "->" + t;
    }
    return tipo;
  }

  public static String matchTipo(String tipo1, String tipo2) throws TypeVerificationException {
    if (tipo1.equals("*")) return tipo2;
    else if (tipo2.equals("*")) return tipo1;
    else if (tipo1.equals(tipo2)) return tipo1;
    else if (tipo1.length() == 1 && tipo1.length() == 1 && !tipo1.equals(tipo2))
      throw new TypeVerificationException();
    String[] t1 = splitTipo(tipo1);
    String[] t2 = splitTipo(tipo2);
    return matchTipo(t1, t2);
  }

  public static String matchTipo(String[] tipo1, String[] tipo2) throws TypeVerificationException {
    if (tipo1.length != tipo2.length) {
      throw new TypeVerificationException();
    }
    List<String> tipos = new ArrayList<>();
    for (int i = 0; i < tipo1.length; i++) {
      tipos.add(matchTipo(tipo1[i], tipo2[i]));
    }
    return joinTipo(tipos.toArray(new String[tipos.size()]));
  }
}