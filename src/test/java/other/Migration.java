/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package other;

import com.calclogic.lambdacalculo.StaticContextInitializer;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.parse.CombUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.ResuelveManagerImpl;

/**
 *
 * @author feder
 */
public class Migration {
    
    public static void main(String[] args) {
        String stTerm = "= (\\Phi_{bcb} (\\Phi_{cb} c_{6}) c_{6} \\Phi_{cbcb}) (\\Phi_{cb} c_{6} (\\Phi_{cbcb} c_{6} \\Phi_{cb}))";
        Term comb = CombUtilities.getTerm(stTerm,null,null);
        TypedA term = new TypedA(comb, "AdminTeoremas");
        System.out.println(term.type());
    }
}
