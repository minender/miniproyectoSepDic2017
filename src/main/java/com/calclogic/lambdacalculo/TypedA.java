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
    private final String variables_;
    private final String nSt_;
    private final String combDBType_;
    private static ResuelveManager rm_;
    
    public static void setResuelveManager(ResuelveManager rm) {
        rm_ = rm;
    }
    
    public TypedA(Term type)
    {
        super("A");
        type_ = type;
        combDBType_ = type.toStringFinal();
        variables_ = type.stFreeVars();
        nSt_ = "";
    }
    
    public TypedA(Term type, String user)
    {
        super("A");
        type_ = type;
        combDBType_ = type.toStringFinal();
        Resuelve r = rm_.getResuelveByUserAndTeorema(user, combDBType_);
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
        if (!variables_.equals("")) {
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