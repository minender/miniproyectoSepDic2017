/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.parse.TermUtilities;
import java.util.List;

/**
 *
 * @author federico
 */
public class TypedA extends Const implements TypedTerm{
    
    private final Term type_;
    private final String variables_;
    
    public TypedA(Term type)
    {
        super("A");
        type_ = type;
        variables_ = "q";
    }
    
    @Override
    public Term type()
    {
        List<Var> li = TermUtilities.arguments(variables_);
        li.addAll(li);
        return type_.evaluar(li);
    }
}