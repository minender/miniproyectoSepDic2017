/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.controller;

import static com.calclogic.controller.PerfilController.simboloDictionaryCode;
import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.Simbolo;
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
        //Term t = CombUtilities.getTerm("(M_{6} (A^{= (\\Phi_{K} (\\Phi_{K} (\\Phi_{K} T))) (\\Phi_{(cccbb,b)} c_{2} \\Phi_{b(bb,cb)} c_{5} (\\Phi_{c(ccbbb,)} c_{3}) c_{3} c_{3})}))", null, TypedA.sm_);
        //System.out.println(t);
        
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
