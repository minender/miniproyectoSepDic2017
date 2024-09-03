/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.entity;

import com.calclogic.lambdacalculo.Term;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

/**
 *
 * @author feder
 */
public class PureCombsTheorem implements java.io.Serializable {
    
    @Id
    @Column(name="id")
    @GeneratedValue( strategy= GenerationType.SEQUENCE, generator="purecombstheorems_id_seq")
    @SequenceGenerator(name="purecombstheorems_id_seq", sequenceName="purecombstheorems_id_seq")
    private int id;
    private String statement;
    private Term statementTerm;
    private Set<Teorema> teoremas = new HashSet<Teorema>(0);
    
    public PureCombsTheorem (){
    }
    
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
