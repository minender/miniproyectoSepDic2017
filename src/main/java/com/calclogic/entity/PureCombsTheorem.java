/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.entity;

import com.calclogic.lambdacalculo.Term;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

/**
 * @author alejandro
 */
@Entity
@Table(name = "purecombstheorems")
public class PureCombsTheorem implements Serializable {

  @Id
  @Column(name = "id")
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "purecombstheorems_id_seq")
  @SequenceGenerator(
      name = "purecombstheorems_id_seq",
      sequenceName = "purecombstheorems_id_seq",
      allocationSize = 1)
  private int id;

  @Column(nullable = false, columnDefinition = "TEXT")
  private String statement;

  private Term statementTerm;

  @OneToMany(mappedBy = "pureCombsTheorem", cascade = CascadeType.ALL, orphanRemoval = true)
  private Set<Teorema> teoremas;

  public PureCombsTheorem() {}

  public PureCombsTheorem(String statement) {
    this.statement = statement;
  }

  public int getId() {
    return id;
  }

  public String getStatement() {
    return statement;
  }

  public Term getStatementTerm() {
    return statementTerm;
  }

  public Set<Teorema> getTeoremas() {
    return this.teoremas;
  }

  public void setId(int id) {
    this.id = id;
  }

  public void setStatement(String statement) {
    this.statement = statement;
  }

  public void setStatementTerm(Term statementTerm) {
    this.statementTerm = statementTerm;
  }

  public void setTeoremas(Set teoremas) {
    this.teoremas = teoremas;
  }
}
