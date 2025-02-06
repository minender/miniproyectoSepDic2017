package com.calclogic.entity;


import com.fasterxml.jackson.databind.deser.std.StringArrayDeserializer;
import com.calclogic.lambdacalculo.Term;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;
import java.io.Serializable;
import org.springframework.util.SerializationUtils;
import org.stringtemplate.v4.compiler.CodeGenerator.includeExpr_return;

/**
 * @author alejandro
 */
@Entity
public class Teorema implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "teorema_id_seq")
  @SequenceGenerator(name = "teorema_id_seq", sequenceName = "teorema_id_seq", allocationSize = 1)
  private int id;
  
  @Column(nullable = false, columnDefinition = "TEXT")
  private String
      enunciado; // Is the formula of the theorem, expressed with the application notation
  
  private Term teoTerm; // Is the formula but parsed in order that it is seen as a tree.
  
  private Term metateoTerm;
  
  private boolean esquema;
  
  @Column(nullable = false)
  private String aliases;
  
  private String constlist;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "purecombstheoid", nullable = false)
  private PureCombsTheorem pureCombsTheorem;

  @OneToMany(mappedBy = "teorema", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Resuelve> resuelves;

  public Teorema() {}

  public Teorema(String enunciado, Term teoTerm, boolean esquema, String aliases) {
    this.enunciado = enunciado;
    this.teoTerm = teoTerm;
    this.esquema = esquema;
    this.aliases = aliases;
  }

  public void setMetateoTerm(Term metateoTerm) {
    this.metateoTerm = metateoTerm;
  }

  public Term getMetateoTerm() {
    return metateoTerm;
  }

  public void setPureCombsTheorem(PureCombsTheorem pct) {
    pureCombsTheorem = pct;
  }

  public void setTeoTerm(Term teoTerm) {

    // Get the aliases list
    String aliasesString = this.getAliases();
    String[] aliases = aliasesString.split(",\\s");

    // In case the list is empty in the database we must make it also an empty array
    if (aliases[0].equals("")) {
      aliases = new String[0];
    }

    // Set the alias name of each alias node

    String[] aliasPosition;
    Term aliasTerm;
    for (String alias : aliases) {

      // Get the position and name of the alias
      aliasPosition = alias.split(":");

      // Find the alias term node by its position
      if (aliasPosition.length == 2) { // if we have a not empty position
        aliasTerm = teoTerm.subterm(aliasPosition[1]);
      } else { // if the potition is empty it means the root is an alias
        aliasTerm = teoTerm.subterm("");
      }

      // Set the proper name of that node
      aliasTerm.alias = aliasPosition[0];
    }
    this.teoTerm = teoTerm;
  }

  public PureCombsTheorem getPureCombsTheorem() {
    return pureCombsTheorem;
  }

  public Term getTeoTerm() {
    return teoTerm;
  }

  public int getId() {
    return this.id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public void setEnunciado(String enunciado) {
    this.enunciado = enunciado;
  }

  public String getEnunciado() {
    return this.enunciado;
  }

  public void setResuelves(Set resuelves) {
    this.resuelves = resuelves;
  }

  public Set getResuelves() {
    return resuelves;
  }

  public void setConstlist(String constlist) {
    this.constlist = constlist;
  }

  public String getConstlist() {
    return constlist;
  }

  public boolean isEsquema() {
    return esquema;
  }

  public void setEsquema(boolean esquema) {
    this.esquema = esquema;
  }

  public String getAliases() {
    return aliases;
  }

  public void setAliases(String aliases) {
    this.aliases = aliases;
  }
}

