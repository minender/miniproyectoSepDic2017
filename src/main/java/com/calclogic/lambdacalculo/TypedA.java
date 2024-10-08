/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.entity.Resuelve;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import java.util.List;

/**
 *
 * @author federico
 */
public class TypedA extends Const implements TypedTerm{
    
    //protected final Term type_;
    protected String variables_;
    protected final String nSt_;
    protected final String combDBType_;
    private static ResuelveManager rm_;
    public static SimboloManager sm_;
    
    public static void setResuelveManager(ResuelveManager rm, SimboloManager s) {
        rm_ = rm;
        sm_ = s;
    }
    
    public TypedA(Term type, String variables, String nSt, String combDBType) {
        super("A");
        type_ = type;
        variables_ = variables;
        nSt_ = nSt;
        combDBType_ = combDBType;
    }
    
    public TypedA(Term type)
    {
        super("A");
        variables_ = type.stFreeVars();
        type_ = type.abstractEq(null);
        combDBType_ = type_.traducBD().toString();
        nSt_ = "";
    }
    
    public TypedA(Term type, String user)
    {
        super("A");
        type_ = type;
        combDBType_ = type.toString();
        Resuelve r = rm_.getResuelveByUserAndTeorema(user, combDBType_,true);
        if (r != null) {
           variables_ = r.getVariables();
           nSt_ = r.getNumeroteorema();
        }
        else {
           variables_ = "";
           nSt_ = "";
        }
    }
    
    public TypedA(String nTeo, String user)
    {
        super("A");
        Resuelve r = rm_.getResuelveByUserAndTeoNum(user, nTeo,true,sm_);
        type_ = r.getTeorema().getTeoTerm();
        combDBType_ = type_.toString();
        if (r != null) {
           variables_ = r.getVariables();
           nSt_ = r.getNumeroteorema();
        }
        else {
           variables_ = "";
           nSt_ = "";
        }
    }

    public TypedA(Term type, String comb, String user)
    {
        super("A");
        Resuelve r = rm_.getResuelveByUserAndTeorema(user, comb, true);
        type_ = type;
        combDBType_ = comb;
        if (r != null) {
           variables_ = r.getVariables();
           nSt_ = r.getNumeroteorema();
        }
        else {
           variables_ = "";
           nSt_ = "";
        }
    }
    
    public TypedA(int idTeo, String user)
    {
        super("A");
        Resuelve r = rm_.getResuelveByUserAndTeorema(user, idTeo,true,sm_);
        type_ = r.getTeorema().getTeoTerm();
        combDBType_ = type_.toString();
        if (r != null) {
           variables_ = r.getVariables();
           nSt_ = r.getNumeroteorema();
        }
        else {
           variables_ = "";
           nSt_ = "";
        }
    }
    
    @Override
    public Term type()
    {
        if (variables_ != null && !variables_.equals("")) {
           return type_.evaluar(variables_);
        } else {
           return type_.evaluar();
        }
    }
    
    public String getCombDBType() {
        return combDBType_;
    }
    
    public String getNSt() {
        return nSt_;
    }
    
    public String getVariables() {
        return variables_;
    }
}