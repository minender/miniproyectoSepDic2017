/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.controller;

import static com.calclogic.controller.PerfilController.simboloDictionaryCode;
import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.TerminoId;
import com.calclogic.entity.Usuario;
import com.calclogic.forms.AgregarTeorema;
import com.calclogic.forms.InsertFormula;
import com.calclogic.forms.InsertarEvaluar;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Corrida;
import com.calclogic.lambdacalculo.Equation;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.Tripla;
import com.calclogic.parse.TermLexer;
import com.calclogic.parse.TermParser;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedM;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombLexer;
import com.calclogic.parse.CombParser;
import com.calclogic.parse.CombUtilities;
import com.calclogic.service.CategoriaManager;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.MetateoremaManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.service.SolucionManager;
import com.calclogic.service.TeoremaManager;
import com.calclogic.service.TerminoManager;
import com.calclogic.service.UsuarioManager;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;
import com.calclogic.parse.TermLexer;
import com.calclogic.parse.TermParser;
import com.calclogic.parse.IsNotInDBException;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.parse.TermUtilities;
import com.calclogic.parse.ThrowingErrorListener;
import com.calclogic.parse.TypeUtilities;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.SimboloManager;
import org.antlr.v4.runtime.misc.ParseCancellationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author federico
 */
@Controller
@RequestMapping(value = "/eval")
public class EvaluarController {


    @Autowired
    private UsuarioManager usuarioManager;
    @Autowired
    private TerminoManager terminoManager;
    @Autowired
    private PredicadoManager predicadoManager;
    @Autowired
    private SimboloManager simboloManager;
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private DisponeManager disponeManager;
    @Autowired
    private TeoremaManager teoremaManager;
    @Autowired
    private MetateoremaManager metateoremaManager;
    @Autowired
    private CategoriaManager categoriaManager;
    @Autowired
    private SolucionManager solucionManager;
    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/{username}/applicativeToLatex", method = RequestMethod.GET)
    public String pruebaPredicadoView(@PathVariable String username, ModelMap map) {
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{44}) (c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{44}) (c_{54} c_{45} c_{46})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} c_{43} c_{45}) (c_{54} (c_{54} c_{45} c_{46}) c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} (c_{54} c_{44} c_{44}) c_{46}) (c_{54} (c_{54} c_{45} c_{46}) c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{46}) (c_{54} (c_{54} (c_{54} c_{45} c_{46}) c_{43}) c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} c_{43} c_{46}) (c_{54} (c_{54} (c_{54} c_{45} c_{46}) c_{43}) c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} (c_{54} c_{43} c_{46}) c_{44}) (c_{54} (c_{54} (c_{54} c_{45} c_{46}) c_{43}) c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} (c_{54} (c_{54} c_{43} c_{46}) c_{44}) c_{44}) (c_{54} (c_{54} (c_{54} c_{45} c_{46}) c_{43}) c_{43})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} c_{43} c_{45}) (c_{54} (c_{54} c_{45} c_{46}) c_{51})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} c_{43} c_{45}) (c_{54} (c_{54} c_{45} c_{51}) c_{51})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} c_{43} c_{45}) (c_{54} (c_{54} c_{51} c_{51}) c_{51})})", "federico", TypedA.sm_);
        //Term t = CombUtilities.getTerm("M_{9}^{1} (A^{c_{55} (c_{54} c_{51} c_{45}) (c_{54} (c_{54} c_{51} c_{51}) c_{51})})", "federico", TypedA.sm_);
        //S (L^{\\lambda x_{122}.c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.x_{122}) (\\lambda x_{120}.x_{80} x_{120})} (I^{[x_{112} := (c_{15} x_{101} x_{120})]} (M_{3} (A^{= (\\Phi_{K} T) (\\Phi_{(bb,)} c_{4} c_{7})})))) (I^{[x_{81},x_{82} := (\\lambda x_{120}.c_{7} (c_{15} x_{101} x_{120})),(\\lambda x_{120}.c_{15} x_{101} x_{120})]} A^{= (\\Phi_{ccbbb} \\Phi_{b} \\Phi_{b} (\\Phi_{cc(bbbb,b)} \\Phi_{b} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{bcbb} c_{5}) (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{b}) (\\Phi_{cccbb} \\Phi_{b} \\Phi_{cbb} (c_{62} (\\Phi_{bb} \\Phi_{b} c_{5})) \\Phi_{ccbb} (\\Phi_{(bb,b)} c_{4}))}) (L^{\\lambda x_{122}.c_{5} (c_{62} (\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121}) (\\lambda x_{120}.c_{7} (c_{15} x_{101} x_{120})) (\\lambda x_{120}.x_{80} x_{120})) x_{122}} (I^{[x_{69},x_{115} := x_{101},(\\lambda x_{120}.\\lambda x_{121}.c_{5} x_{120} x_{121})]} A^{= (\\Phi_{b} (\\Phi_{bb} \\Phi_{K})) (\\Phi_{ccbbb} c_{15} \\Phi_{b} (\\Phi_{cbbb} c_{62}) \\Phi_{ccb} \\Phi_{b})}))
        //Term t = CombUtilities.getTerm("\\Phi_{(bbc(cbc,),cbbb(c,bc(cbc,)))}", "AdminTeoremas", TypedA.sm_);
        //Term t = CombUtilities.getTerm("(I^{[x_{69},x_{101},x_{102} := (\\lambda x_{-126}.c_{2} (c_{2} (x_{80} x_{120}) (x_{82} x_{120})) x_{-126}),(c_{62} c_{5} (\\lambda x_{120}.x_{82} x_{120}) (\\lambda x_{120}.x_{80} x_{120})),(c_{62} c_{5} (\\lambda x_{120}.c_{8}) (\\lambda x_{120}.c_{2} (x_{80} x_{120}) (x_{82} x_{120})))]} A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(ccb,)} c_{2} (\\Phi_{(bbb,cb)} c_{2}) (\\Phi_{c(cbbb,)} c_{1}))}) (M_{1}^{1} (A^{= (\\Phi_{bb} (\\Phi_{bb} (c_{62} c_{5} (\\Phi_{K} c_{8}))) (\\Phi_{(bb,b)} c_{2})) (\\Phi_{ccbb} \\Phi_{b} (c_{62} c_{5}) \\Phi_{cbb} \\Phi_{b})}))", "AdminTeoremas", TypedA.sm_);
        //Term t = CombUtilities.getTerm("= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(c(cc(cccc(cc(bb,b),b),b),),)} c_{2} c_{2} (\\Phi_{(b(b(bbc,cbb),(bbc,bb)),(bbb,cbb))} c_{2} c_{2} c_{2}) (c_{62} c_{5}) \\Phi_{b} c_{2} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{1} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{cccccccc((cccc(bbb,),bb),)} \\Phi_{b} (c_{62} c_{5})) \\Phi_{b} (\\Phi_{(bb,b)} c_{2}) (\\Phi_{(bb,b)} c_{2}) \\Phi_{b})", "AdminTeoremas", TypedA.sm_);  
        //Term t = CombUtilities.getTerm("\\Phi_{(c(cc(cccc(cc(bb,b),b),b),),)} c_{2} c_{2} (\\Phi_{(b(b(bbc,cbb),(bbc,bb)),(bbb,cbb))} c_{2} c_{2} c_{2}) (c_{62} c_{5}) \\Phi_{b} c_{2} (c_{62} c_{5} (\\Phi_{K} c_{8})) c_{1} (c_{62} c_{5} (\\Phi_{K} c_{8})) (\\Phi_{cccccccc((cccc(bbb,),bb),)} \\Phi_{b} (c_{62} c_{5})) \\Phi_{b} (\\Phi_{(bb,b)} c_{2}) (\\Phi_{(bb,b)} c_{2}) \\Phi_{b})", "AdminTeoremas", TypedA.sm_);
        
        //System.out.println(t.type());
//      1          2          3     4         5          6      7
//(x6->x4->x7)->(x5->x6)->(x1->x5)->x3->(x2->x3->x4)->(x1->x2)->x1->x7
//x1(x2(x3x7))(x5(x6x7)x4)
//x14->x13->x12->x11->x10->x9->x8->x7->x6->(x5->x4->x6->x7->x3->x8->x9->x10->x11->x2->x12->x13->x1->x14->x1->x15)->(x1->x5)->(x1->x4)->(x1->x3)->(x1->x2)->x1->x15
//x10(x11z)(x12z)x9x8(x13z)x7x6x5x4(x14z)x3x2zx1z
//        1               2                3             4       5   6        7                  8                 9            10      11    12        13         14           15        16      17      18            19              20                                                                                                                                                                         
//(x19->x7->x20)->(x18->x12->x19)->(x17->x15->x18)->(x10->x17)->x1->x14->(x13->x14->x15)->((x1->x10)->x13)->(x11->x9->x12)->(x10->x11)->x1->(x8->x9)->(x1->x8)->(x6->x4->x7)->(x5->x6)->(x1->x5)->x3->(x2->x3->x4)->((x1->x10)->x2)->(x1->x10)->x20
//        1               2                3             4       5   6        7                  8                 9            10      11    12          13              14            15          16          17      18              19            20            
//(x19->x7->x20)->(x18->x12->x19)->(x17->x15->x18)->(x10->x17)->x1->x14->(x13->x14->x15)->((x1->x10)->x13)->(x11->x9->x12)->(x10->x11)->x1->(x8->x9)->((x1->x10)->x8)->(x6->x4->x7)->(x5->x6)->((x1->x10)->x5)->x3->(x2->x3->x4)->((x1->x10)->x2)->(x1->x10)->x20
//x1(x2(x3(x4(x20x5))(x7(x8x20)x6))(x9(x10(x20x11))(x12(x13x20))))(x14(x15(x16x20))(x18(x19x20)x17))
        
//x17->x16->x15->x14->x13->x12->x11->x10->x9->x8->x7->x6->(x5->x1->x6->x7->x8->x9->x3->x1->x10->x11->x12->x13->x14->x15->x16->x17->x18)->(x4->x5)->(x1->x4)->(x2->x3)->(x1->x2)->x1->x18
//x13(x14(x15x18))x18x12x11x10x9(x16(x17x18))x18x8x7x6x5x4x3x2x1x19
        map.addAttribute("insertFormula",new InsertFormula());

        return "insertFormula";
    }

    @RequestMapping(value = "/{username}/applicativeToLatex", method = RequestMethod.POST)
    public String pruebaPredicado(@Valid InsertFormula insertFormula, BindingResult bindingResult,
                                  @PathVariable String username, ModelMap map) {
            
        if (bindingResult.hasErrors()) {
            map.addAttribute("mensaje", "");
            map.addAttribute("termino", insertFormula.getAlgorithm());

            return "insertFormula";
        }
        // Feed the argument to the parser
	CharStream in = CharStreams.fromString(insertFormula.getAlgorithm());
		
	// Define the lexer for the input and edit its way of catching error
	CombLexer lexer = new CombLexer(in);
	lexer.removeErrorListeners();
	lexer.addErrorListener(ThrowingErrorListener.INSTANCE);
		
	// Generate tokens for the parser
	CommonTokenStream tokens = new CommonTokenStream(lexer);
		
	// Define the parser for the tokens and edit its way of catching error
	CombParser parser = new CombParser(tokens);
	parser.removeErrorListeners();
	parser.addErrorListener(ThrowingErrorListener.INSTANCE);
		
	// get the value of the parser 
                
	Term t = null;
        try {
           t = parser.start_rule(username,simboloManager).value;
           if (t.nPhi() > 0)
               t = new TypedA(t,"AdminTeoremas").type();
           map.addAttribute("predicado", "$"+t.toStringLaTeX(simboloManager, "", null)+"$");
        }catch (ParseCancellationException e) {
           map.addAttribute("mensaje", e.getMessage());
           return "insertFormula";
        }
        map.addAttribute("titulo","Su f&oacute;rmula en $\\LaTeX$ es:");
        map.addAttribute("url","applicativeToLatex");
        
        return "PagParaVerPredicado";
    }

    @RequestMapping(value = "/{username}/latexToApplicative", method = RequestMethod.GET)
    public String laTeXToApplicativeView(@PathVariable String username, ModelMap map) {
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
        map.addAttribute("teorema","");
        map.addAttribute("mensaje", "");
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        
        map.addAttribute("insertFormula",new InsertFormula());
        
        return "latexToApplicative";
    }
    
    @RequestMapping(value = "/{username}/latexToApplicative", method = RequestMethod.POST)
    public String laTeXToApplicative(@Valid InsertFormula insertFormula, BindingResult bindingResult, 
                                     @PathVariable String username, ModelMap map) {
        if (bindingResult.hasErrors()) {
           Usuario usr = usuarioManager.getUsuario(username);
           List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
           List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
           predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
           String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
           map.addAttribute("teorema","");
           map.addAttribute("mensaje", "");
           map.addAttribute("simboloList", simboloList);
           map.addAttribute("predicadoList", predicadoList);
           map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
           map.addAttribute("mensaje", "");

           return "latexToApplicative";
        }
        
        PredicadoId predicadoid = new PredicadoId();
        predicadoid.setLogin(username);
        String formula = insertFormula.getAlgorithm();
        map.addAttribute("predicado", ""+TermUtilities.getTerm(formula, predicadoid, 
                                                            predicadoManager, simboloManager) );
        map.addAttribute("titulo","Su f&oacute;rmula en notaci&oacute;n aplicativa es:");
        map.addAttribute("url","latexToApplicative");
        
        return "PagParaVerPredicado";
    }
    
    @RequestMapping(value = "/{username}", method = RequestMethod.POST)
    public String evaluarPasoAPasoView(@Valid InsertarEvaluar insertarEvaluar, BindingResult bindingResult, @PathVariable String username, ModelMap map) {
        if ((Usuario) session.getAttribute("user") == null || !((Usuario) session.getAttribute("user")).getLogin().equals(username)) {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        if (bindingResult.hasErrors()) {
            map.addAttribute("usuario", usr);
            map.addAttribute("mensaje", "");
            map.addAttribute("termino", insertarEvaluar.getAlgoritmo());
            map.addAttribute("nombre", insertarEvaluar.getNombre());
            map.addAttribute("guardarMenu", "");
            map.addAttribute("admin", "admin");
            map.addAttribute("listarTerminosMenu", "");
            map.addAttribute("verTerminosPublicosMenu", "");
            map.addAttribute("misPublicacionesMenu", "");
            map.addAttribute("computarMenu", "class=\"active\"");
            map.addAttribute("perfilMenu", "");
            map.addAttribute("hrefAMiMismo", "href=../../eval/" + username + "#!");
            map.addAttribute("overflow", "hidden");
            map.addAttribute("anchuraDiv", "1100px");
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));

            return "insertarEvaluar";
        }

        String programa = insertarEvaluar.getAlgoritmo();
        PredicadoId predicadoid = new PredicadoId();
        predicadoid.setLogin(username);

        //Hay que construir un Term aqui con el String termino.combinador
        //para luego traducir, hace falta construir un parse   
        CharStream in = CharStreams.fromString(programa);
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        Term term;
        try //si la sintanxis no es correcta ocurre una Exception
        {
            String[] boundVars = {""};
            term = parser.start_rule(predicadoid, predicadoManager, simboloManager, boundVars).value;
//            term.setAlias(0);

        } /*catch (IsNotInDBException e) {
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            map.addAttribute("insertarEvaluar", new InsertarEvaluar());
            map.addAttribute("mensaje", hdr + ((IsNotInDBException) e).message);
            map.addAttribute("nombre", insertarEvaluar.getNombre());
            map.addAttribute("termino", programa);
            map.addAttribute("admin", "admin");
            map.addAttribute("guardarMenu", "");
            map.addAttribute("listarTerminosMenu", "");
            map.addAttribute("verTerminosPublicosMenu", "");
            map.addAttribute("misPublicacionesMenu", "");
            map.addAttribute("computarMenu", "class=\"active\"");
            map.addAttribute("perfilMenu", "");
            map.addAttribute("hrefAMiMismo", "href=../../eval/" + username + "#!");
            map.addAttribute("overflow", "hidden");
            map.addAttribute("anchuraDiv", "1100px");
            return "insertarEvaluar";
        } */catch (RecognitionException e) {
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("usuario", usr);
            map.addAttribute("insertarEvaluar", new InsertarEvaluar());
            map.addAttribute("mensaje", hdr + " " + msg);
            map.addAttribute("nombre", insertarEvaluar.getNombre());
            map.addAttribute("termino", programa);
            map.addAttribute("guardarMenu", "");
            map.addAttribute("admin", "admin");
            map.addAttribute("listarTerminosMenu", "");
            map.addAttribute("verTerminosPublicosMenu", "");
            map.addAttribute("misPublicacionesMenu", "");
            map.addAttribute("computarMenu", "class=\"active\"");
            map.addAttribute("perfilMenu", "");
            map.addAttribute("hrefAMiMismo", "href=../../eval/" + username + "#!");
            map.addAttribute("overflow", "hidden");
            map.addAttribute("anchuraDiv", "1100px");
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));

            return "insertarEvaluar";
        }

        Tripla tripla = term.toStringAbrvFinal();
        List<String> alias = tripla.alias;
        List<String> valores = tripla.valores;
        Corrida corr = term.evaluarFinal();
        corr.operations.add(new Integer(7));//agrego cualquier cosa

        //corr.terminos.set(0, tripla.term.replace("\\", "\\\\"));

        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("nReducciones", new Float(((float) corr.reducciones / (float) (corr.reducciones + corr.traducciones)) * 100));
        map.addAttribute("nTraduc", new Float(((float) corr.traducciones / (float) (corr.reducciones + corr.traducciones)) * 100));
        map.addAttribute("nTerms", new Integer(corr.terminos.size() - 1));
        map.addAttribute("nTermsPuros", new Integer(corr.lambdaTerms.size() - 1));
        map.addAttribute("terminos", corr.terminos);
        map.addAttribute("operations", corr.operations);
        map.addAttribute("termPuros", corr.lambdaTerms);
        if (alias.size() != 0) {
            map.addAttribute("nAlias", new Integer(alias.size() - 1));
        } else {
            map.addAttribute("nAlias", new Integer(0));
            alias.add("");
            valores.add("");
        }
        map.addAttribute("alias", alias);
        map.addAttribute("valores", valores);
        return "evaluar";
    }

    public void setUsuarioManager(UsuarioManager usuarioManager) {
        this.usuarioManager = usuarioManager;
    }

    public void setTerminoManager(TerminoManager terminoManager) {
        this.terminoManager = terminoManager;
    }
}
