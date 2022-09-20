/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.entity.Resuelve;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.ResuelveManager;
import java.util.List;

/**
 *
 * @author federico
 */
public class TypedA extends Const implements TypedTerm{
    
    private final Term type_;
    protected final String variables_;
    protected final String nSt_;
    protected final String combDBType_;
    private static ResuelveManager rm_;
    
    public static void setResuelveManager(ResuelveManager rm) {
        rm_ = rm;
    }
    
    protected TypedA(Term type, String variables, String nSt, String combDBType) {
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
        type_ = type.abstractEq();
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
           variables_ = "p,q,r";
           nSt_ = "";
        }
    }
    
    public TypedA(String nTeo, String user)
    {
        super("A");
        Resuelve r = rm_.getResuelveByUserAndTeoNum(user, nTeo,true);
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

    public TypedA(int idTeo, String user)
    {
        super("A");
        Resuelve r = rm_.getResuelveByUserAndTeorema(user, idTeo,true);
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
           List<Var> li = TermUtilities.arguments(variables_);
           li.addAll(li);
           return type_.evaluar(li);
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
}