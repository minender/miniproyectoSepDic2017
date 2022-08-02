package com.calclogic.proof;

import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedS;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ronald
 */
public class MetaTheorem {
    /**
     * This method will return the typedTerm that represents the metaTheorem teo == true
     * @param teo: theorem to be turned into teo == true
     * @return new Theorem for the given template meta theorem, null if the argument isn't valid
     */
    public static TypedApp metaTheorem(Term teo) {
        Term A1 = new TypedA( new App(new App(new Const(1,"c_{1}"), new App(new App(new Const(1,"c_{1}"),new Var(112)),new Var(113)) ), new App(new App(new Const(1,"c_{1}"),new Var(113)),new Var(112))) );
        Term A2 = new TypedA( new App(new App(new Const(1,"c_{1}"),new Var(113)),
                                     new App(new App(new Const(1,"c_{1}"),new Var(113)),
                                                               new Const(8,"c_{8}"))));
        Term A3 = new TypedA(teo);
        List<Var> list1 = new ArrayList<>();
        list1.add(new Var(112));
        list1.add(new Var(113));
        List<Term> list2 = new ArrayList<>();
        list2.add(teo);
        list2.add(new Const(8,"c_{8}"));
        Term I1 = new TypedI(new Sust(list1,list2));
        
        List<Var> lis1 = new ArrayList<>();
        lis1.add(new Var(113));
        List<Term> lis2 = new ArrayList<>();
        lis2.add(teo);
        Term I2 = new TypedI(new Sust(lis1,lis2));
        
        TypedApp typedTerm = null;
        try {
          typedTerm = new TypedApp(new TypedApp(I1,A1), new TypedApp(I2,A2));
          typedTerm = new TypedApp(new TypedApp(new TypedS(typedTerm.type()), typedTerm),A3);
          return typedTerm;
        }
        catch (TypeVerificationException e){
            Logger.getLogger(MetaTheorem.class.getName()).log(Level.SEVERE, null, e);
            return null;
        }
    }
    
    /**
     * This method will return the typedTerm that represents the metaTheorem true == teo. 
     * This method use the proof of teo instead the statement of teo.
     * 
     * @param proof: proof of theorem teo to be turned into true == teo 
     * @return new theorem for the given meta theorem template, null if the argument isn't valid
     */
    public static TypedApp metaTheoTrueLeft(Term proof) {
    
        Term A2 = new TypedA( new App(new App(new Const(1,"c_{1}"),new Var(113)),
                                     new App(new App(new Const(1,"c_{1}"),new Var(113)),
                                                               new Const(8,"c_{8}"))));
        
        List<Var> lis1 = new ArrayList<>();
        lis1.add(new Var(113));
        List<Term> lis2 = new ArrayList<>();
        lis2.add(proof.type());
        Term I2 = new TypedI(new Sust(lis1,lis2));
        
        TypedApp typedTerm = null;
        try {
          typedTerm = new TypedApp(I2,A2);
          typedTerm = new TypedApp(new TypedApp(new TypedS(typedTerm.type()), typedTerm),proof);
          return typedTerm;
        }
        catch (TypeVerificationException e){
            Logger.getLogger(MetaTheorem.class.getName()).log(Level.SEVERE, null, e);
            return null;
        }
    }
}