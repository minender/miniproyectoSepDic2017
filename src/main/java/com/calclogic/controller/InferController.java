package com.calclogic.controller;

import com.google.gson.TypeAdapter;
import com.calclogic.entity.Categoria;
import com.calclogic.entity.Dispone;
import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.PlantillaTeorema;
import com.calclogic.entity.Predicado;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import com.calclogic.entity.TerminoId;
import com.calclogic.entity.Usuario;
import com.calclogic.forms.AutoSustResponse;
import com.calclogic.forms.InferResponse;
import com.calclogic.forms.InfersForm;
import com.calclogic.forms.InstResponse;
import com.calclogic.forms.SubstResponse;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Bracket;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Equation;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedL;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.TypedTerm;
import com.calclogic.lambdacalculo.TypedU;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.parse.StaticCombUtilities;
import com.calclogic.parse.TermLexer;
import com.calclogic.parse.TermParser;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SolucionManager;
import com.calclogic.service.TerminoManager;
import com.calclogic.service.UsuarioManager;
import com.calclogic.service.CategoriaManager;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.MetateoremaManager;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.MostrarCategoriaManager;
import com.calclogic.service.PlantillaTeoremaManager;
import com.calclogic.service.SimboloManager;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.Stack;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

import org.antlr.v4.parse.ANTLRParser.throwsSpec_return;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;
//import org.apache.jasper.tagplugins.jstl.core.If;
import org.hibernate.classic.Validatable;
//import org.omg.CORBA.PRIVATE_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author shamuel
 */
@Controller
@RequestMapping(value="/infer")
public class InferController {
      
    @Autowired
    private UsuarioManager usuarioManager;
    @Autowired
    private TerminoManager terminoManager;
    @Autowired
    private PredicadoManager predicadoManager;
    @Autowired
    private SimboloManager simboloManager;
    @Autowired
    private SolucionManager solucionManager;
    @Autowired
    private PlantillaTeoremaManager plantillaTeoremaManager;
    @Autowired
    private MetateoremaManager metateoremaManager;
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private HttpSession session;
    @Autowired
    private CategoriaManager categoriaManager;
    @Autowired
    private DisponeManager disponeManager;
    @Autowired
    private MostrarCategoriaManager mostrarCategoriaManager;
    @Autowired
    private CombUtilities combUtilities;
    @Autowired
    private TermUtilities termUtilities;
    
    @RequestMapping(value="/{username}", method=RequestMethod.GET)
    public String selectTeoView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),t.getTeoTerm()));
        }
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("usuario",usr);
        InfersForm infersForm = new InfersForm();
        List <Categoria> showCategorias = new LinkedList<Categoria>();
        List<MostrarCategoria> mostrarCategoria = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(usr);
        for (int i = 0; i < mostrarCategoria.size(); i++ ){
            showCategorias.add(mostrarCategoria.get(i).getCategoria());
        }
        
        List<Simbolo> simboloList = simboloManager.getAllSimbolo();
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = PerfilController.simboloDictionaryCode(simboloList, predicadoList);
        
        map.addAttribute("usuario",usr);
        map.addAttribute("infer",infersForm);
        map.addAttribute("mensaje","");
        map.addAttribute("nStatement","");
        map.addAttribute("instanciacion","");
        map.addAttribute("leibniz","");
        map.addAttribute("formula","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("selecTeo",true);
        map.addAttribute("nTeo","");
        map.addAttribute("admin","admin");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("proveMenu","active");
        map.addAttribute("perfilMenu","");
        //map.addAttribute("hrefAMiMismo","href=../../eval/"+username+"#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","100%");
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        //map.addAttribute("makeTerm",new MakeTerm());
        return "infer";
    }

    @RequestMapping(value="/{username}/{nTeo:.+}", method=RequestMethod.GET)
    public String inferView(@PathVariable String username, @PathVariable String nTeo, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formula = resuel.getTeorema().getTeoTerm();
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSolWithoutAxiom(username,nTeo);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            Term term = t.getTeoTerm();
            if(r.isResuelto()==true){ // || r.getNumeroteorema().equals(nTeo)){
                
                /*try
                {
                  t.setTeoTerm(new App(new App(new Const(1,"\\cssId{click@"+r.getNumeroteorema()+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{"+((Const)((App)((App)term).p).p).getCon()+"}}}",((Const)((App)((App)term).p).p).getFunNotation(),((Const)((App)((App)term).p).p).getPreced(),((Const)((App)((App)term).p).p).getAsociat()),((App)((App)term).p).q),((App)term).q));
                }
                catch (java.lang.ClassCastException e)
                {*/
                    t.setTeoTerm(term);
                //}
                t.setMetateoTerm(new App(new App(new Const(1,"\\cssId{clickmeta@"+r.getNumeroteorema()+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{\\equiv}}}",false,1,1),new Const("true ")), term));
            }
            else{
                ;
                /*try
                {
                  t.setTeoTerm(new App(new App(new Const(((Const)((App)((App)term).p).p).getCon(),false,1,1),((App)((App)term).p).q),((App)term).q));
                }
                catch (java.lang.ClassCastException e)
                {
                    t.setTeoTerm(term);
                }
                t.setMetateoTerm(new App(new App(new Const("{\\equiv}}",false,1,1),new Const("true ")), term));*/
            }
            
        }
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("usuario", usr);
        InfersForm infersForm = new InfersForm();
        infersForm.setSolucionId(0);
        
        map.addAttribute("infer",infersForm);
        map.addAttribute("mensaje","");
        map.addAttribute("nStatement","");
        map.addAttribute("instanciacion","");
        map.addAttribute("leibniz","");
        if (solId.equals("new")){
            map.addAttribute("formula","Theorem "+nTeo+":<br> <center>$"+formula.toStringInf(simboloManager,"")+"$</center> Proof:");
            map.addAttribute("elegirMetodo","1");
            map.addAttribute("teoInicial", "");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(resuel.getDemopendiente());
            infersForm.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula.toStringInf(simboloManager,"")+"$</center> Proof:");  
            InferResponse response = new InferResponse();
            Term typedTerm = solucion.getTypedTerm();

            response.generarHistorial(
                username,
                formula, 
                nTeo, 
                typedTerm, 
                true,
                true,
                (solucion.getMetodo().equals("")?null:ProofMethodUtilities.getTerm(solucion.getMetodo())), 
                resuelveManager, 
                disponeManager,
                simboloManager
            );

            Boolean hasInnerMethodSelected = !solucion.getMetodo().equals("");;

            // If it is an And Introduction proof
            if (solucion.getMetodo().startsWith("And Introduction(")) {
                String[] methodAndPath = solucion.getMetodo().split("-");
                String[] methods = methodAndPath[0].substring(
                                       17,
                                       methodAndPath[0].length() - 1
                                   ).split(";");
                String currentMethod;
                String path = methodAndPath[1];
    
                // TODO: we have to create a parser to identify the recursive
                // case.
                if (path.equals("p")) {
                    currentMethod = methods[0];
                } else {
                    currentMethod = methods[1];
                }

                // If no method has been selected, we should show the method 
                // selector 
                if (currentMethod.equals("null")) {
                    hasInnerMethodSelected = false;
                }

            }

            if (typedTerm == null && !hasInnerMethodSelected) 
                map.addAttribute("elegirMetodo","1");
            else if (typedTerm == null && hasInnerMethodSelected)
                map.addAttribute("elegirMetodo","2");
            else
                map.addAttribute("elegirMetodo","0");

            map.addAttribute("formula",response.getHistorial());

            // TODO: preguntarle a Flaviani sobre este caso borde
            // Term type = null;//typedTerm.type();
            // String teoInicial;
            // Resuelve res = null;
            // if (typedTerm!=null && (type = typedTerm.type()) == null)
            // {
            //     teoInicial = solucion.getTypedTerm().toStringFinal();
            //     res = resuelveManager.getResuelveByUserAndTeorema(username, teoInicial);
            // }
            // else if (typedTerm!=null)
            // {
            //   teoInicial = ((App)type).q.toStringFinal();
            //   res = resuelveManager.getResuelveByUserAndTeorema(username, teoInicial);
            // }
            // if (res != null)
            //    map.addAttribute("teoInicial", res.getNumeroteorema());
            // else
            //    map.addAttribute("teoInicial", "");
        }
        List <Categoria> showCategorias = new LinkedList<Categoria>();
        List<MostrarCategoria> mostrarCategoria = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(usr);
        for (int i = 0; i < mostrarCategoria.size(); i++ ){
            showCategorias.add(mostrarCategoria.get(i).getCategoria());
        }
        
        List<Simbolo> simboloList = simboloManager.getAllSimbolo();
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = PerfilController.simboloDictionaryCode(simboloList, predicadoList);
        
        if (usr.isAutosust())
            map.addAttribute("autoSust","true");
        else
            map.addAttribute("autoSust","false");
        
        map.addAttribute("usuario",usr);
        map.addAttribute("guardarMenu","");
        map.addAttribute("selecTeo",false);
        map.addAttribute("nSol",solId);
        map.addAttribute("nTeo",nTeo);
        map.addAttribute("admin","admin");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("proveMenu","active");
        map.addAttribute("perfilMenu","");
        //map.addAttribute("hrefAMiMismo","href=../../eval/"+username+"#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));

        //map.addAttribute("makeTerm",new MakeTerm());
        return "infer";
    }
    
    /**
     * Controller for show a instantiation of a statement to a user.
     * 
     * @param initialExpr: Term that represents A
     * @param teoremProved: The teorem the user is trying to prove
     * @param finalExpr: Term that represents F
     * @param proof: The proof tree so far
     * @param username: name of the user doing the prove
     * @return new proof if finished, else return the same proof
     */
    @RequestMapping(value="/{username}/inst", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody InstResponse instantiate(@RequestParam(value="nStatement") String nStatement, 
                           @RequestParam(value="instanciacion") String instanciacion, @PathVariable String username) 
    {
        InstResponse response = new InstResponse();
        PredicadoId predicadoid=new PredicadoId();
        predicadoid.setLogin(username);
        
        Term statementTerm = null;
        if (nStatement.length() >= 4) {
            // FIND THE THEOREM BEING USED IN THE HINT
            String tipoTeo = nStatement.substring(0, 2);
            String numeroTeo = nStatement.substring(3, nStatement.length());
        
            if (tipoTeo.equals("ST")){
                Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
            }
            else if(tipoTeo.equals("MT")){
                Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
            }
            else {    
                response.setError("statement format error");
                return response;
            }
            if (statementTerm == null) {
                response.setError("The statement doesn't exists");
                return response;
            }
        }
        else {
            response.setError("statement format error");
            return response;
        }
       
        // CREATE THE INSTANTIATION
       ArrayList<Object> arr = null;
        if (!instanciacion.equals("")){
          arr=termUtilities.instanciate(instanciacion, predicadoid, predicadoManager, simboloManager);
        }
        
        if (arr == null)
            response.setInstantiation(statementTerm.toStringInf(simboloManager, ""));
        else
            response.setInstantiation(statementTerm.sustParall((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1)).toStringInf(simboloManager, ""));
        return response;
    }

    @RequestMapping(value="/{username}/auto", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody AutoSustResponse setAutoSust(@PathVariable String username) 
    {
        Usuario usuario = usuarioManager.getUsuario(username);
        AutoSustResponse response = new AutoSustResponse();
        if (usuario != null) {
            if (usuario.isAutosust()) {
                usuario.setAutosust(false);
                usuarioManager.updateUsuario(usuario);
                response.setAuto(false);
            }
            else {
                usuario.setAutosust(true);
                usuarioManager.updateUsuario(usuario);
                response.setAuto(true);
            }

        }else {
            response.setError("user doesn't exists");
        }
        
        return response;
    }
    
    /**
     * Controller for automatic instantiation of a statement to a user.
     * 
     * @param initialExpr: Term that represents A
     * @param teoremProved: The teorem the user is trying to prove
     * @param finalExpr: Term that represents F
     * @param proof: The proof tree so far
     * @param username: name of the user doing the prove
     * @return new proof if finished, else return the same proof
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/auto", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody SubstResponse autoSubst(@RequestParam(value="nStatement") String nStatement, 
                           @RequestParam(value="leibniz") String leibniz, @RequestParam(value="freeV") String freeV, 
                           @PathVariable String username, @PathVariable String nSol) 
    {
        SubstResponse response = new SubstResponse();
        PredicadoId predicadoid=new PredicadoId();
        predicadoid.setLogin(username);
        
        Term statementTerm = null;
        if (nStatement.length() >= 4) {
            // FIND THE THEOREM BEING USED IN THE HINT
            String tipoTeo = nStatement.substring(0, 2);
            String numeroTeo = nStatement.substring(3, nStatement.length());
        
            if (tipoTeo.equals("ST")){
                Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
            }
            else if(tipoTeo.equals("MT")){
                Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
            }
            else {    
                response.setError("statement format error");
                return response;
            }
            if (statementTerm == null) {
                response.setError("The statement doesn't exists");
                return response;
            }
        }
        else {
            response.setError("statement format error");
            return response;
        }

        // String freeV = statementTerm.freeVars();
        if (!freeV.equals("")) {
            String[] freeVars = freeV.split(",");
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));

            String metodo = solucion.getMetodo();
            Term typedTerm = solucion.getTypedTerm();

            // Get the tree on which you're making  proof.
            if (metodo.startsWith("And Introduction(")) {

                // Get the path string
                String[] methodAndPath = metodo.split("-");
                metodo = methodAndPath[0];
                char[] path = methodAndPath[1].toCharArray();
    
                String[] subMethods;
    
                // Iterate over the path to get the correct subtree.
                for (char c : path) {
                    subMethods = metodo.substring(17,metodo.length()-1).split(";");
    
                    if (c == 'p') {
                        metodo = subMethods[0];
                        typedTerm = ((App)(((App)typedTerm).p)).q;
                    } else if (c == 'q') {
                        if (subMethods[1].equals("null")) {
                            metodo = subMethods[0];
                        } else {
                            metodo = subMethods[1];
                        }
                        typedTerm = ((App)typedTerm).q;
                    }
                }
            }

         Term lastLine = typedTerm.type();
         if (lastLine == null)
            lastLine = typedTerm;
         else
            lastLine = ((App)((App)lastLine).p).q;
         Term leibnizTerm = null;
         // CREATE THE INSTANTIATION
         Sust sust = null;
         Equation eq;
         boolean zUnifiable = true;
         if (!leibniz.equals("")){
           leibnizTerm =termUtilities.getTerm(leibniz, predicadoid, predicadoManager, simboloManager);
           eq = new Equation(leibnizTerm,lastLine);
           sust = eq.mgu(simboloManager);
           if (sust != null) // si z no es de tipo atomico, no se puede unificar en primer orden
            leibnizTerm = eq.mgu(simboloManager).getTerms().get(0);
           else
            zUnifiable = false;
         }
         else 
           leibnizTerm = lastLine;
         if (zUnifiable)  {
            eq = new Equation(((App)statementTerm).q,leibnizTerm);
            sust = eq.mgu(simboloManager);
            if (sust == null) {
                eq = new Equation(((App)((App)statementTerm).p).q,leibnizTerm);
                sust = eq.mgu(simboloManager);
            }
         }
         
         if (sust != null) {
            String[] sustVars = sust.getVars().toString().replaceAll("[\\s\\[\\]]", "").split(",");
            String[] sustFormatC = new String[freeVars.length];
            String[] sustLatex = new String[freeVars.length];
            for (int i=0; i<freeVars.length; i++) {
                int j = sust.getVars().indexOf(new Var(freeVars[i].toCharArray()[0]));
                if (j != -1) {
                    sustFormatC[i] = sust.getTerms().get(j).toStringFormatC(simboloManager,"",0,"substitutionButtonsId."+freeVars[i]);
                    sustLatex[i] = sust.getTerms().get(j).toStringWithInputs(simboloManager,"","substitutionButtonsId."+freeVars[i]);
                }
                else {
                    sustFormatC[i] = "";
                    sustLatex[i] = "";
                }
            }

            response.setSustFormatC(sustFormatC);
            response.setSustLatex(sustLatex);
            return response;
         }
         else {
           response.setSustFormatC(null);
           response.setSustLatex(null);
           return response;  
         }
       }
       else {
           response.setSustFormatC(null);
           response.setSustLatex(null);
           return response;
       }
    }
    
    /**
     * This function will only be correct if called when using DirectMethod
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the DirectMethod. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved A == ... == F
     * @param initialExpr: Term that represents A
     * @param teoremProved: The teorem the user is trying to prove
     * @param finalExpr: Term that represents F
     * @param proof: The proof tree so far
     * @param username: name of the user doing the prove
     * @return new proof if finished, else return the same proof
     */
    private Term finishedDirectMethodProve(Term teoremProved, Term proof, String username) {
        Term expr = proof.type();
    	Term initialExpr = ((App)expr).q;
    	Term finalExpr = ((App)((App)expr).p).q;
    	// Case when the direct method started from the teorem being proved
    	if(teoremProved.equals(initialExpr)) {
    		// List of teorems solved by the user
    		List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserResuelto(username);
    		Term teorem;
    		Term mt;
    		for(Resuelve resu: resuelves){
    			teorem = resu.getTeorema().getTeoTerm();
    			mt = new App(new App(new Const("c_{1}"),new Const("true")),teorem);
    			// If the current teorem or teorem==true matches the final expression (and this teorem is not the one being proved) 
    			if(!teorem.equals(teoremProved) && (teorem.equals(finalExpr) || mt.equals(finalExpr))) {
    				try {
    					return new TypedApp(new TypedApp(new TypedS(proof.type()), proof),new TypedA(finalExpr)); 
    				}catch (TypeVerificationException e) {
    					 Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
					}
    			}	
    		}
                
    		
    		// If the prove hasnt finished
    		return proof;
    	}
    	
    	// Case when the direct method started from another teorem
    	
    	// Finished
    	if(finalExpr.equals(teoremProved)) {
    		try {
				return new TypedApp(proof, new TypedA(initialExpr));
			}catch (TypeVerificationException e) {
				 Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
			}
    	}
    	
    	// If the prove hasnt finished
    	return proof;
    }
   
    /**
     * This function will only be correct if called when using Starting from one side method
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the One side method. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved A == ... == F
     * @param initialExpr: Term that represents A
     * @param finalExpr: Term that represents F
     * @param teoremProved: The teorem the user is trying to prove (even if the original is of the form H => A == B 
     * in this case H /\ A ==  H /\ B must be given instead)
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
    private Term finishedOneSideProve(Term initialExpr, Term finalExpr, Term teoremProved, Term proof) {

    	// If the one side prove started from the right side
    	if(initialExpr.equals(((App)((App)teoremProved).p).q) && finalExpr.equals(((App)teoremProved).q)){
    		try {
				 return new TypedApp(new TypedS(proof.type()), proof);
			}catch (TypeVerificationException e) {
				 Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
			} 
    	}
    	
    	// If the prove hasnt finished
    	return proof;
    }

    private Term finishedTransProve(Term expr, Term teoremProved, Term proof) {
     try {
            // if at least one opInference was made an reach the goal
            if(wsFirstOpInferIndex(proof) != 0 && ((App)((App)expr).p).q.equals(teoremProved) )
              return new TypedApp(proof,new TypedA(new Const("c_{8}")));
        }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
        }
     return proof;
    }
    
    /**
     * Check if the two arguments are of the form p op q and q op^{-1} p
     * 
     * @param t1: Term that represent a formula
     * @param t2: Term that represent a formula
     * @return true if and only if t1 and t2 are of the form p op q and q op^{-1} p respectively
     */    
    public static boolean isInverseImpl(Term t1, Term t2) {
        if ( !(t1 instanceof App) || !(((App)t1).p instanceof App)) {
            return false;
        }
        String op1 = ((App)((App)t1).p).p.toStringFinal();
        return (op1.equals("c_{2}") || op1.equals("c_{3}")) && 
                t2 instanceof App && ((App)t2).p instanceof App &&
                ((App)t1).q.equals(((App)((App)t2).p).q) && 
               ((App)((App)t1).p).q.equals(((App)t2).q) && 
               ((App)((App)t2).p).p.toString().equals((op1.equals("c_{2}")?"c_{3}":"c_{2}"));
    }
    
    /**
     * This function will only be correct if called when using Weakening method
     * This function will return a new prove tree in case it finds out that the last infer of prove
     * caused the whole prove to be correct under the Weakenig method. In other case it will return 
     * the proof given as argument.
     * 
     * Do the last equanimity and simetry of => steps to finish a Weakening proof
     * @param expr: root of the proof tree
     * @param teoremProved: The theorem the user is trying to prove 
     * @param proof: The proof tree so far
     * @return proof of theoremProved if finished, else return the same proof
     */
    private Term finishedWeakProve(Term expr, Term teoremProved, Term proof) {
     try {
    	// If the statement is A=>B
        if ( ((App)((App)teoremProved).p).p.toStringFinal().equals("c_{2}") ) {
            // if at least one opInference was made an reach the goal
            if(wsFirstOpInferIndex(proof) != 0 && ((App)((App)expr).p).q.equals(teoremProved) )
              return new TypedApp(proof,new TypedA(new Const("c_{8}")));
        }
        else if ( ((App)((App)teoremProved).p).p.toStringFinal().equals("c_{3}") ) {
            if (wsFirstOpInferIndex(proof)!=0 && isInverseImpl(expr,teoremProved) ) {
                TypedA ax = new TypedA(combUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)combUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)expr).p).q+", "+((App)expr).q+"]"));
                return new TypedApp(new TypedApp(inst,ax),proof);
            }
            if(wsFirstOpInferIndex(proof)!=0 && isInverseImpl(((App)((App)expr).p).q,teoremProved) ) {
                TypedA ax = new TypedA(combUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)combUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)((App)expr).p).q).p).q+", "+((App)((App)((App)expr).p).q).q+"]"));
                Term aux = new TypedApp(inst,ax);
                return new TypedApp(new TypedApp(new TypedS(aux.type()),aux),new TypedApp(proof,new TypedA(new Const("c_{8}"))));
            }
        }
      }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
      }	
    	// If the prove hasnt finished
    	return proof;
    }
    
    /**
     * This function will only be correct if called when using Strengthening method
     * This function will return a new prove tree in case it finds out that the last infer of prove
     * caused the whole prove to be correct under Strengthening method. In other case it will return 
     * the proof given as argument.
     * 
     * Do the last equanimity and simetry of => steps to finish a Weakening proof
     * @param expr: root of the proof tree
     * @param teoremProved: The theorem the user is trying to prove 
     * @param proof: The proof tree so far
     * @return proof of theoremProved if finished, else return the same proof
     */
    private Term finishedStrengProve(Term expr, Term teoremProved, Term proof) {
     try {
    	// If the statement is A=>B
        if ( ((App)((App)teoremProved).p).p.toStringFinal().equals("c_{3}") ) {
            // if at least one opInference was made an reach the goal
            if(wsFirstOpInferIndex(proof) != 0 && ((App)((App)expr).p).q.equals(teoremProved) )
              return new TypedApp(proof,new TypedA(new Const("c_{8}")));
        }
        else if ( ((App)((App)teoremProved).p).p.toStringFinal().equals("c_{2}") ) {
            if (wsFirstOpInferIndex(proof)!=0 && isInverseImpl(expr,teoremProved) ) {
                TypedA ax = new TypedA(combUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)combUtilities.getTerm("[x_{112}, x_{113} := "+((App)expr).q+", "+((App)((App)expr).p).q+"]"));
                return new TypedApp(new TypedApp(inst,ax),proof);
            }
            if(wsFirstOpInferIndex(proof)!=0 && isInverseImpl(((App)((App)expr).p).q,teoremProved) ) {
                TypedA ax = new TypedA(combUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)combUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)expr).p).q).q+", "+((App)((App)((App)((App)expr).p).q).p).q+"]"));
                return new TypedApp(new TypedApp(inst,ax),new TypedApp(proof,new TypedA(new Const("c_{8}"))));
            }
        }
      }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
      }	
    	// If the prove hasnt finished
    	return proof;
    }    
    
    private Term finishedCounterRecProve(Term teoremProved, Term proof) {
       if (!proof.type().equals(teoremProved)) 
       {
           try {
             String str = "c_{1} (c_{2} (c_{7} x_{112}) (c_{7} x_{113})) (c_{2} x_{113} x_{112})";
             Term st = combUtilities.getTerm(str);
             List<Var> vars = new ArrayList<Var>();
             List<Term> terms = new ArrayList<Term>();
             vars.add(0, new Var(112));
             vars.add(0, new Var(113));
             terms.add(0, ((App)((App)((App)teoremProved).p).q).q);
             terms.add(0, ((App)((App)teoremProved).q).q);
             Sust sus = new Sust(vars, terms);
             TypedA A = new TypedA(st);
             TypedI I = new TypedI(sus);
           
             return new TypedApp(new TypedApp(new TypedS(),new TypedApp(I,A)),proof);
             
           }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
           }
       }
       
       return proof;
    }
    
    /**
     * This function will only be correct if called when using Starting from one side method with natural deduction
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the One side natural deduction method. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved  H /\ Bi == ... == H /\ Bn
     * @param initialExpr: Term that represents H /\ Bi
     * @param finalExpr: Term that represents H /\ Bn
     * @param teoremProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
    private Term finishedDeductionOneSideProve(Term initialExpr, Term finalExpr, Term teoremProved, Term proof) {
    	
    	try {
        /* Jean
        Term expr = proof.type();
+       Term initialExpr = ((App)expr).q;
+       Term finalExpr = ((App)((App)expr).p).q;*/
            
    	initialExpr = ((App)((App)initialExpr).p).q;
    	finalExpr = ((App)((App)finalExpr).p).q;
    	
    	Term b1 = ((App)((App)((App)teoremProved).p).q).q;
    	Term bf = ((App)((App)((App)((App)teoremProved).p).q).p).q;
    	Term H = ((App)teoremProved).q;
    	
    	
    	Boolean finishedFromRight = initialExpr.equals(bf) && finalExpr.equals(b1);
    	// If didnt finish
        if( !(initialExpr.equals(b1) && finalExpr.equals(bf))  && !finishedFromRight){
        	return proof;
        }
       
        // If here then finished
        
        
        TypedApp newProof = (TypedApp)proof;
        
        // If started from the right 
        if (finishedFromRight) {
        	newProof = new TypedApp(new TypedS(proof.type()),proof);
        }
        
        // (p => ( q == r)) == p /\ q == p /\ r
        TypedA A = new TypedA(new App(new App(new Const("c_{1}"), 
        		new App( new App(new Const("c_{1}"),new App(new App(new Const("c_{5}"),new Var('r')),new Var('p'))),new App(new App(new Const("c_{5}"),new Var('q')),new Var('p')))),
        		new App(new App(new Const("c_{2}"),new App(new App(new Const("c_{1}"),new Var('r')),new Var('q'))), new Var('p'))));
        
        // p,q,q := H,B1,Bn
		ArrayList<Var> vars = new ArrayList<Var>();
		vars.add(new Var('p')); 
		vars.add(new Var('q'));   
		vars.add(new Var('r'));  
		ArrayList<Term> terms = new ArrayList<Term>();
		terms.add(H);
		terms.add(b1);
		terms.add(bf);
		Sust instantiation = new Sust(vars, terms);
		TypedI I = new TypedI(instantiation);
		
		TypedApp left = new TypedApp(I, A);
		left = new TypedApp(new TypedS(left.type()),left);
		
		newProof = new TypedApp(left, newProof);
		
		return newProof;
		
    	}catch (Exception e) {
    		Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
			return proof;
		}
        
    }
    
    /**
     * This function will only be correct if called when using Direct method with natural deduction
     * This function will return a new prove tree in case it finds out that the last hint of proof
     * caused the whole prove to be correct under the Direct natural deduction method. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved (H == H /\ B1) == ... == (H == H /\ Bn)
     * @param initialExpr: Term that represents (H == H /\ B1)
     * @param finalExpr: Term that represents (H == H /\ Bn)
     * @param teoremProved: The teorem the user is trying to prove
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
    private Term finishedDeductionDirectProve(Term initialExpr, Term teoremProved,Term finalExpr, Term proof, String username) {
    	
        /*Jean
        Term expr = proof.type();
+       Term initialExpr = ((App)expr).q;
+       Term finalExpr = ((App)((App)expr).p).q;*/

        
    	// Take away H == H /\
    	finalExpr = ((App)((App)((App)((App)finalExpr).p).q).p).q;
    	Term H = ((App)teoremProved).q;	
    	// Take away H from H => B
    	teoremProved = ((App)((App)teoremProved).p).q;
    	
    	if(initialExpr.equals(new Const("c_{8}"))) {// Started with another theorem
    		
    		if(finalExpr.equals(teoremProved)) {// if finished
    			
    			try {
    			// HINT (H => B) == (H == H /\ B) 
    			
    			// p,q := H,B
    			ArrayList<Var> vars = new ArrayList<Var>();
    			vars.add(new Var('p')); 
    			vars.add(new Var('q'));   
    			ArrayList<Term> terms = new ArrayList<Term>();
    			terms.add(H);
    			terms.add(finalExpr);
    			Sust instantiation = new Sust(vars, terms);
    			TypedI I = new TypedI(instantiation);
    			
    			// p => q == (p == p /\ q)
    			
    			TypedA A = new TypedA(new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"),new Var('q')),new Var('p'))), new Var('p'))),
    					new App(new App(new Const("c_{2}"), new Var('q')), new Var('p'))));
    			
    			TypedApp hint = new TypedApp(I, A);
    			hint = new TypedApp(new TypedS(hint.type()), hint);
    			
    			TypedApp newProof = new TypedApp(proof, hint);
    			
    			// Need to add equanimity since proved true == H => B
    			newProof = new TypedApp(newProof, new TypedA(new Const("c_{8}")));
    			return newProof;
    			
    			
    			}catch (TypeVerificationException e) {
    				Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
					return proof;
				}
    			
    			
    			
    		}
    		
    	}else {// Started with the theorem being proved
    		
    		
    		// CHECK IF ANY TEHEOREM MATCHES THE FINAL EXPR
    		List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserResuelto(username);
    		Term teorem;
    		Term mt;
    		for(Resuelve resu: resuelves){
    			teorem = resu.getTeorema().getTeoTerm();
    			mt = new App(new App(new Const("c_{1}"),new Const("true")),teorem);
    			
    			// If the current teorem or teorem==true matches the final expression (and this teorem is not the one being proved) 
    			if(!teorem.equals(teoremProved) && (teorem.equals(finalExpr) || mt.equals(finalExpr))) {
    				try {
    					// HINT 1
    	    			
    	    			// H = H ^ z
    	    			Bracket leib = new Bracket(new Var('z'), new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), new Var('z')), H)), H));
    	    			TypedL L = new TypedL(leib);
    	    			// Create teorema == true
    	    			TypedApp metaTheorem= metaTheorem(teorem);
    	    			
    	    			TypedApp hint1 = new TypedApp(L, metaTheorem);
    	    			
    	    			// HINT 2
    	    			
    	    			// H == z
    	    			leib = new Bracket(new Var('z'), new App(new App(new Const("c_{1}"), new Var('z')), H));
    	    			L = new TypedL(leib);
    	    			
    	    			// p := H
    	    			ArrayList<Var> vars = new ArrayList<Var>();
    	    			vars.add(new Var('p'));   
    	    			ArrayList<Term> terms = new ArrayList<Term>();
    	    			terms.add(H);
    	    			Sust instantiation = new Sust(vars, terms);
    	    			TypedI I = new TypedI(instantiation);
    	    			
    	    			// p /\ true == p
    	    			TypedA A = new TypedA(new App( new App( new Const("c_{1}") ,new Var('p')), new App(new App(new Const("c_{5}"), new Const("c_{8}")), new Var('p'))));
    	    			
    	    			TypedApp hint2 = new TypedApp(I, A);
    	    			hint2 = new TypedApp(L, hint2);
    	    			
    	    			// HINT 3
    	    			
    	    			// need  true == (q == q) gotta prove it with associativity and true == q == q
    	    			
    	    			// true == (q == q)
    	    			A = new TypedA(new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"), new Var('q')),new Var('q'))),new Const("c_{8}")));
    	    			
    	    			// q := H
    	    			vars = new ArrayList<Var>();
    	    			vars.add(new Var('q'));   
    	    			instantiation = new Sust(vars, terms);
    	    			I = new TypedI(instantiation);
    	    			
    	    			TypedApp hint3 = new TypedApp(I,A);
    	    			
    	    			TypedS S = new TypedS(hint3.type());
    	    			
    	    			hint3 = new TypedApp(S, hint3);
    	    			
    	    			
    	    			// BUILD THE NEW PROOF
    	    			
    	    			TypedApp newProof = new TypedApp(proof, hint1);
    	    			newProof = new TypedApp(newProof, hint2);
    	    			newProof = new TypedApp(newProof, hint3);
    	    			
    	    			
    	    			// Need to add equanimity since proved H => B == true
    	    			newProof = new TypedApp(new TypedApp(new TypedS(newProof.type()), newProof),new TypedA(new Const("c_{8}")));
    	    			return newProof;
    	    			
    				}catch (TypeVerificationException e) {
    					 Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
    					 return proof;
					}
    			}	
    		}
    	
    	}
    	
    	// If the proof hasnt finished
		return proof;
    	
    }
    
    /**
     * This function will create a hint for the direct method given the hint's elements
     * In case the elements dont make sense it will return null
     * @param teorem: teorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents leibniz on the hint
     * @param leibnizString: string that was used to parse leibniz
     * @return a hint for the direct method
     */
    private Term createDirectMethodInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString ) 
                 throws TypeVerificationException
    {
    	
    	Term hint = null;
    	//try {
        	if (instantiationString.equals("") && leibnizString.equals(""))
        		hint = new TypedA(teorem);
        	else if (instantiationString.equals(""))
        	{
        		TypedA A = new TypedA(teorem);
        		TypedL L = new TypedL(leibniz);
        		hint = new TypedApp(L,A);
        	}
        	else if (leibnizString.equals(""))
        	{
        		TypedA A = new TypedA(teorem);
        		TypedI I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
        		hint = new TypedApp(I,A);
        	}
        	else
        	{
        		TypedA A = new TypedA(teorem);
        		TypedI I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
        		TypedL L = new TypedL((Bracket)leibniz);
        		hint = new TypedApp(L,new TypedApp(I,A));
        	} 
        /*}catch(TypeVerificationException e) { // If something went wrong return null
        	e.printStackTrace();
        	return null;
        } */
        
        /*Jean
        if (instantiationString.equals("") && leibnizString.equals(""))
+               hint = new TypedA(teorem);
+       else if (instantiationString.equals(""))
+       {
+               TypedA A = new TypedA(teorem);
+               TypedL L = new TypedL(leibniz);
+               hint = new TypedApp(L,A);
+       }
+       else if (leibnizString.equals(""))
+       {
+               TypedA A = new TypedA(teorem);
+               TypedI I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
+               hint = new TypedApp(I,A);
+       }
+       else
+       {
+               TypedA A = new TypedA(teorem);
+               TypedI I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
+               TypedL L = new TypedL((Bracket)leibniz);
+               hint = new TypedApp(L,new TypedApp(I,A));
+       }
        */
    	
    	return hint;
    }
    
    /**
     * This function will create a hint for the one side method given the hint's elements
     * In case the elements dont make sense it will return null
     * @param teorem: teorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents leibniz on the hint
     * @param leibnizString: string that was used to parse leibniz
     * @return a hint for the one side method
     */
    private Term createOneSideInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString) 
                 throws TypeVerificationException
    {
    	return createDirectMethodInfer(teorem, instantiation, instantiationString, leibniz, leibnizString);
    }
    
    private Term createWSInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString) 
                 throws TypeVerificationException {
        Term infer;
    	
        	if (instantiationString.equals("") && leibnizString.equals(""))
        		infer = new TypedA(teorem);
        	else if (instantiationString.equals(""))
        	{
                    TypedA A = new TypedA(teorem);
                    Term c;
                    if ( teorem instanceof App && ((App)teorem).p instanceof App &&
                         (c=((App)(((App)teorem).p)).p) != null && c instanceof Const &&
                         (((Const)c).getId() == 2 || ((Const)c).getId() == 3) 
                       )
                        infer = parityLeibniz(leibniz, A);
                    else {
                        TypedL L = new TypedL(leibniz);
                        infer = new TypedApp(L,A);    
                    }
        	}
        	else if (leibnizString.equals(""))
        	{
                    TypedA A = new TypedA(teorem);
                    TypedI I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
                    infer = new TypedApp(I,A);
        	}
        	else
        	{
                    TypedA A = new TypedA(teorem);
                    TypedI I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
                    Term c;
                    if ( teorem instanceof App && ((App)teorem).p instanceof App &&
                         (c=((App)((App)teorem).p).p) != null && c instanceof Const &&
                         (((Const)c).getId() == 2 || ((Const)c).getId() == 3 )
                       )
                        infer = parityLeibniz(leibniz,new TypedApp(I,A));
                    else {
                        TypedL L = new TypedL((Bracket)leibniz);
                        infer = new TypedApp(L,new TypedApp(I,A));    
                    }
        	} 

    	return infer;        
    }
    
    /**
     * This function will create a hint for the natural deduction one side method given the hint's elements
     * In case the elements dont make sense it will return null
     * @param teorem: teorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents leibniz on the hint
     * @param leibnizString: string that was used to parse leibniz
     * @param teoremProved: teorem that we are proving using this hint
     * @return a hint for the natural deduction one side method
     */
    private Term createDeductionOneSideInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString, Term teoremProved) 
                 throws TypeVerificationException
    {

//    	try {
    	
    	// First must check if we are dealing with a special modus ponens hint 
    	
    	// If its not a special hint (is not an implication) just return the same we would do with the direct method
    	if(!((App)((App)teorem).p).p.toStringInf(simboloManager, "").equals("\\Rightarrow")){
    		
            if( !leibnizString.equals("")) { // If there is a leibniz
    			// Add H to it 
    		leibniz = new Bracket(new Var('z'), new App(new App(new Const("c_{5}"), leibniz.t), ((App)teoremProved).q));
            }else {
    			// Use a leibniz that represents H /\ z
    		leibniz = new Bracket(new Var('z'), new App(new App(new Const("c_{5}"), new Var('z')), ((App)teoremProved).q));
    		leibnizString = "69";
            }
            return createDirectMethodInfer(teorem, instantiation, instantiationString, leibniz, leibnizString);
    	}
    	
    	// IF REACHED HERE WE NEED A MODUS PONENS HINT
    	
    	TypedI I = null;
    	String e = "\\Phi_{}"; // by default use empty phi which represents leibniz z
    	Term iaRighTerm = new TypedA(teorem);
    	
    	// Example of left IA
    	// I^{[A,B,C,E := \equiv true q,\equiv q q,\equiv true true, \Phi_{cb} true \equiv]}A^{\Rightarrow (\equiv (\wedge (E C) A) (\wedge (E B) A)) (\Rightarrow (\equiv C B) A)}
    	
    	// A,B and C are in the hint being used 
    	
    	Term cTerm = ((App)((App)((App)((App)teorem).p).q).p).q;
    	Term bTerm = ((App)((App)((App)teorem).p).q).q;
    	Term aTerm = ((App)teorem).q;
    
    	// If there is instantiation change a,b and c properly
    	if(!instantiationString.equals("")) {
    		I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
    		cTerm = (new TypedApp(I, new TypedA(cTerm))).type();
    		bTerm = (new TypedApp(I, new TypedA(bTerm))).type();
    		aTerm = (new TypedApp(I, new TypedA(aTerm))).type();
    		// Need to add I to the right side
    		iaRighTerm = new TypedApp(I, iaRighTerm);
    	}
    	
    	// If there is leibniz change e properly
    	if(!leibnizString.equals("")) {
    		Term phiLeibniz = leibniz.traducBD();
    		e = phiLeibniz.toStringFinal();
    	}
    	
    	String c = cTerm.toStringFinal();
    	String b = bTerm.toStringFinal();
    	String a = aTerm.toStringFinal();
    	
    	// Here is the left IA side of the modus ponens hint 
    	String iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{5} (x_{69} x_{67}) x_{65}) (c_{5} (x_{69} x_{66}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
    	Term iaLefTerm = combUtilities.getTerm(iaLeftString);
    	
    	//throw new TypeVerificationException();
    	return new TypedApp(iaLefTerm, iaRighTerm);
    	
    	
    	/*}catch(Exception e) { // If something goes wrong return null
    		e.printStackTrace();
    		return null;
    	}*/

    }
    
    /**
     * This function will create a hint for the natural deduction with direct method given the hint's elements
     * In case the elements dont make sense it will return null
     * @param teorem: teorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents leibniz on the hint
     * @param leibnizString: string that was used to parse leibniz
     * @param teoremProved: teorem that we are proving using this hint
     * @return a hint for the natural deduction with direct method
     */
    private Term createDeductionDirectInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString, Term teoremProved) 
                 throws TypeVerificationException
    {

//    	try {
    	
    	// First must check if we are dealing with a special modus ponens hint 
    	
    	// If its not modus ponens (is not an implication) just return the same we would do with the direct method
    	if(!((App)((App)teorem).p).p.toStringInf(simboloManager, "").equals("\\Rightarrow")){
    		
    		if( !leibnizString.equals("")) { // If there is a leibniz
    			// Add H == H /\ to it 
    			leibniz = new Bracket(new Var('z'),new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), leibniz.t), ((App)teoremProved).q)) ,((App)teoremProved).q));
    		}else {
    			// Use a leibniz that represents H /\ z
    			leibniz = new Bracket(new Var('z'),new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), new Var('z')), ((App)teoremProved).q)) ,((App)teoremProved).q));
    			leibnizString = "69";
    		}
    		return createDirectMethodInfer(teorem, instantiation, instantiationString, leibniz, leibnizString);
    	}
    	
    	// IF REACHED HERE WE NEED A MODUS PONENS HINT
    	
    	TypedI I = null;
    	String e = "\\Phi_{}"; // by default use empty phi which represents leibniz z
    	Term iaRighTerm = new TypedA(teorem);
    	
    	// Example of left IA
    	// I^{[A,B,C,E := \equiv true q,\equiv q q,\equiv true true, \Phi_{cb} true \equiv]}A^{\Rightarrow (\equiv (\wedge (E C) A) (\wedge (E B) A)) (\Rightarrow (\equiv C B) A)}
    	
    	// A,B and C are in the hint being used 
    	
    	Term cTerm = ((App)((App)((App)((App)teorem).p).q).p).q;
    	Term bTerm = ((App)((App)((App)teorem).p).q).q;
    	Term aTerm = ((App)teorem).q;
    
    	// If there is instantiation change a,b and c properly
    	if(!instantiationString.equals("")) {
    		I = new TypedI(new Sust((ArrayList<Var>)instantiation.get(0), (ArrayList<Term>)instantiation.get(1)));
    		cTerm = (new TypedApp(I, new TypedA(cTerm))).type();
    		bTerm = (new TypedApp(I, new TypedA(bTerm))).type();
    		aTerm = (new TypedApp(I, new TypedA(aTerm))).type();
    		// Need to add I to the right side
    		iaRighTerm = new TypedApp(I, iaRighTerm);
    	}
    	
    	// If there is leibniz change e properly
    	if(!leibnizString.equals("")) {
    		Term phiLeibniz = leibniz.traducBD();
    		e = phiLeibniz.toStringFinal();
    	}
    	
    	String c = cTerm.toStringFinal();
    	String b = bTerm.toStringFinal();
    	String a = aTerm.toStringFinal();
    	
    	// Here is the left IA side of the modus ponens hint                                                      
    	String iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{1}  (c_{5} (x_{69} x_{67}) x_{65}) x_{65}) (c_{1}  (c_{5} (x_{69} x_{66}) x_{65}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
    	/*Jean
        String iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{5} (x_{69} x_{67}) x_{65}) (c_{5} (x_{69} x_{66}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
        */   
        Term iaLefTerm = combUtilities.getTerm(iaLeftString);
    	
    	//throw new TypeVerificationException();
    	return new TypedApp(iaLefTerm, iaRighTerm);
    	
    	
    	/*}catch(Exception e) { // If something goes wrong return null
    		e.printStackTrace();
    		return null;
    	}*/
        
        /*Jean
        // need this L to make the hint fit for H == z
+       TypedL L = new TypedL(new Bracket(new Var('z'), new App(new App(new Const("c_{1}"),new Var('z')) ,aTerm)));
        
        return  new TypedApp(L, new TypedApp(iaLefTerm, iaRighTerm));
        */
    }
    
    /**
     * This method will return the typedTerm that represents the metaTheorem teo == true
     * @param teo: theorem to be turned into metaTheorem 
     * @return new metaTheorem for the given theorem, null if the argument isnt valid
     */
    public static TypedApp metaTheorem(Term teo) {
        Term A1 = new TypedA( new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"),new Var(112)),new Var(113)) ), new App(new App(new Const("c_{1}"),new Var(113)),new Var(112))) );
        Term A2 = new TypedA( new App(new App(new Const("c_{1}"),new Var(113)),
                                     new App(new App(new Const("c_{1}"),new Var(113)),
                                                               new Const("c_{8}"))));
        Term A3 = new TypedA(teo);
        List<Var> list1 = new ArrayList<Var>();
        list1.add(new Var(112));
        list1.add(new Var(113));
        List<Term> list2 = new ArrayList<Term>();
        list2.add(teo);
        list2.add(new Const("c_{8}"));
        Term I1 = new TypedI(new Sust(list1,list2));
        
        List<Var> lis1 = new ArrayList<Var>();
        lis1.add(new Var(113));
        List<Term> lis2 = new ArrayList<Term>();
        lis2.add(teo);
        Term I2 = new TypedI(new Sust(lis1,lis2));
        
        TypedApp typedTerm = null;
        try {
          typedTerm = new TypedApp(new TypedApp(I1,A1), new TypedApp(I2,A2));
          typedTerm = new TypedApp(new TypedApp(new TypedS(typedTerm.type()), typedTerm),A3);
          return typedTerm;
        }
        catch (TypeVerificationException e){
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
            return null;
        }
    }
    
    /**
     * This method will return the typedTerm that represents the metaTheorem teo == true
     * @param teo: theorem to be turned into metaTheorem 
     * @return new metaTheorem for the given theorem, null if the argument isnt valid
     */
    public static TypedApp metaTheoTrueLeft(Term proof) {
    
        Term A2 = new TypedA( new App(new App(new Const("c_{1}"),new Var(113)),
                                     new App(new App(new Const("c_{1}"),new Var(113)),
                                                               new Const("c_{8}"))));
        
        List<Var> lis1 = new ArrayList<Var>();
        lis1.add(new Var(113));
        List<Term> lis2 = new ArrayList<Term>();
        lis2.add(proof.type());
        Term I2 = new TypedI(new Sust(lis1,lis2));
        
        TypedApp typedTerm = null;
        try {
          typedTerm = new TypedApp(I2,A2);
          typedTerm = new TypedApp(new TypedApp(new TypedS(typedTerm.type()), typedTerm),proof);
          return typedTerm;
        }
        catch (TypeVerificationException e){
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
            return null;
        }
    }
    
    private Term neg(Term p, Term q, Const op) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String neg = "I^{[x_{112}, x_{113} := "+P+", "+Q+"]}A^{c_{1} ("+op2+" (c_{7} x_{113}) (c_{7} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return combUtilities.getTerm(neg);
    }
    
    private Term wsl1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsl1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{114} x_{113}) ("+op1+" x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return combUtilities.getTerm(wsl1);
    }
    
    private Term wsl2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsl2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{2} x_{114} x_{113}) (c_{2} x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return combUtilities.getTerm(wsl2);
    }
    
    private Term wsr1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsr1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{113} x_{114}) ("+op1+" x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return combUtilities.getTerm(wsr1);
    }
    
    private Term wsr2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsr2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{3} x_{113} x_{114}) (c_{3} x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return combUtilities.getTerm(wsr2);
    }
    
    /**
     * This method will return the typedTerm that represents the sub derivation
     * tree that infer de use on leibniz in weakening/stregthening 
     * @param leibniz: Term that represent de leibniz expresion 
     * @param nabla: derivation with root P op Q. The root is to be use as argument 
     *             for leibniz rule with op in {Rightarrow,Leftarrow}
     * @return new TypedTerm that represent a derivation with root 
     *         (lambda z.E)P op_2 (lambda z.E)Q with op_2 in {Rightarrow,Leftarrow}
     */
    private Term parityLeibniz(Term leibniz, Term nabla) throws TypeVerificationException {
        
        Term t = leibniz.traducBD();
        
        while (t instanceof App) {
            Term nabla2 = nabla; // si no entra en ninguna guardia aborta el TApp(nabla,nabla)
            if (((App)t).q instanceof Const && ((Const)((App)t).q).getId() == 7 ) {
                Term root = nabla.type();
                nabla2 = neg(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p);
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof App && ((App)((App)t).q).p instanceof Const) {
                if (((Const)((App)((App)t).q).p).getId() == 2 ) {
                    Term root = nabla.type();
                    nabla2 = wsl2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q);
                }
                else if ( (((Const)((App)((App)t).q).p).getId() != 1 ) ) {
                    Term root = nabla.type();
                    nabla2 = wsl1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).q).q,
                                             (Const)((App)((App)t).q).p);
                }
                t = ((App)t).p;
            }
            else if (((App)t).q instanceof Const && ((App)t).p instanceof App) {
                if ( ((Const)((App)t).q).getId()==3 ) {
                    Term root = nabla.type();
                    nabla2 = wsr2(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q);
                }
                else if (((Const)((App)t).q).getId() != 1) {
                    Term root = nabla.type();
                    nabla2 = wsr1(((App)root).q, ((App)((App)root).p).q, 
                                             (Const)((App)((App)root).p).p, ((App)((App)t).p).q,
                                             (Const)((App)t).q);
                }
                t = ((App)((App)t).p).p;
            }
            nabla = new TypedApp(nabla2,nabla);
        }
        
        return nabla;
    }
    
        /**
     * return the index (counting in reverse) of the first inference that is not a 
     * equiv or = in a Transitivity method
     * @param typedTerm derivation tree that code a Transitivity proof
     * @return index of the first no =inference
     */
    public static int wsFirstOpInferIndex(Term typedTerm) {
        Term iter;
        iter = typedTerm;
    	Term ultInf = null;
        int i = 0;
        int firstOpInf = 0;
        while (iter!=ultInf)
        {
            if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='t') {// TT
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)iter).p;   
            }
            else if (iter instanceof TypedApp && ((TypedApp)iter).inferType=='m' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='m' && 
                     ((TypedApp)((TypedApp)iter).p).p instanceof TypedApp &&
                     ((TypedApp)((TypedApp)((TypedApp)iter).p).p).inferType=='i'
                    ) { // ((IA)T)T
               ultInf = ((TypedApp)iter).q;
               iter = ((TypedApp)((TypedApp)iter).p).q;
            }
            else { // first inference
                if ( iter instanceof TypedApp && ((TypedApp)iter).inferType=='e' &&
                     ((TypedApp)iter).p instanceof TypedApp && 
                     ((TypedApp)((TypedApp)iter).p).inferType=='s'
                   ) 
                    iter = ((TypedApp)iter).q;
                ultInf = iter;
            }
            i++;
            Term ultInfType = ultInf.type();
            if (ultInfType instanceof App && ((App)ultInfType).p instanceof App &&
                   !(((App)((App)ultInfType).p).p.toStringFinal().equals("c_{1}") ||
                     ((App)((App)ultInfType).p).p.toStringFinal().equals("c_{20}")
                    )
               )
                firstOpInf = i;
        }
        return firstOpInf;
    }
    
    private Term addInferToWSProof(Term proof, Term infer) throws TypeVerificationException {
        Term type = proof.type();
        Term typeInf = infer.type();
        String op;
        String opInf;
        try {
            op = ((App)((App)type).p).p.toStringFinal();
            opInf = ((App)((App)typeInf).p).p.toStringFinal();
        }
        catch (ClassCastException e) {
            throw new TypeVerificationException();
        }
        if ( !op.equals("c_{1}") && !op.equals("c_{20}") ) {
            proof = metaTheoTrueLeft(proof);
            type = proof.type();
        }
        int index = wsFirstOpInferIndex(proof);
        boolean eqInf = opInf.equals("c_{1}") || opInf.equals("c_{20}");
        if ( index == 0 && eqInf) {
            return new TypedApp(proof, infer);
        }
        else if (index == 0 && !eqInf) {
            String eq = op;
            String st = "c_{2} (c_{2} (c_{1} (x_{69} x_{101}) c_{8}) (x_{69} x_{102})) ("+eq+" x_{102} x_{101})";
            String deriv = "";
            try {
            String E = "\\Phi_{b} ("+ ((App)infer.type()).p+")";
            deriv = 
            "I^{[x_{101}, x_{102}, x_{69} := "+((App)type).q+", "+((App)((App)type).p).q+", "+E+"]} A^{"+st+"}";
            }catch (ClassCastException e) {
                throw new TypeVerificationException();
            }
            return new TypedApp(new TypedApp(combUtilities.getTerm(deriv), proof), infer);
        }
        else if (index != 0 && !eqInf) {
            String st = "c_{2} (c_{2} (c_{1} ("+opInf+" x_{114} x_{112}) c_{8}) ("+opInf+" x_{114} x_{113}))  (c_{1} ("+opInf+" x_{113} x_{112}) c_{8})";
            String deriv = "";
            try {
            Term aux = (App)((App)((App)type).p).q;
            deriv = 
            "I^{[x_{112}, x_{113}, x_{114} := "+((App)aux).q+", "+((App)((App)aux).p).q+", "+((App)((App)typeInf).p).q+"]} A^{"+st+"}";
            }catch (ClassCastException e) {
                throw new TypeVerificationException();
            }
            return new TypedApp(new TypedApp(combUtilities.getTerm(deriv), proof), infer);
        }
        else {
            if ( infer instanceof TypedApp && ((TypedApp)infer).inferType=='l' ) {
                Term aux = ((App)((App)type).p).q;
                Term oldLeib = ((Bracket)((TypedApp)infer).p.type()).t;
                Bracket leibniz = new Bracket(new Var('z'),new App(new App(((App)((App)aux).p).p,oldLeib),((App)aux).q));
                infer = new TypedApp(new TypedL(leibniz),((TypedApp)infer).q);
                return new TypedApp(proof, infer);
            }
            else {
                Term aux = ((App)((App)type).p).q;
                Bracket leibniz = new Bracket(new Var('z'),new App(new App(((App)((App)aux).p).p,new Var('z')),((App)aux).q));
                infer = new TypedApp(new TypedL(leibniz),infer);
                return new TypedApp(proof, infer);
            }
        }
    }
    
    private Term addInferToProof(Term proof, Term infer) throws TypeVerificationException {
        return new TypedApp(proof, infer);
    }
    
    private boolean isWaitingMethod(Term method) throws TypeVerificationException {
        
        Term m1, m2 = null;
        if (method instanceof Const && 
            (
             ((Const)method).getCon().equals("DM") ||
             ((Const)method).getCon().equals("SS") ||   
             ((Const)method).getCon().equals("TR") ||
             ((Const)method).getCon().equals("WE") ||
             ((Const)method).getCon().equals("ST")    
            )
           ) 
        {
           return false;    
        }
        else if (method instanceof Const && 
                 (
                  ((Const)method).getCon().equals("ND") ||
                  ((Const)method).getCon().equals("CO") ||   
                  ((Const)method).getCon().equals("CR") ||
                  ((Const)method).getCon().equals("AI") ||
                  ((Const)method).getCon().equals("CA") ||
                  ((Const)method).getCon().equals("WI")
                 )
                ) 
        {
            return true;
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof Const &&
                 (
                  ((Const)m1).getCon().equals("ND") || 
                  ((Const)m1).getCon().equals("CO") || 
                  ((Const)m1).getCon().equals("CR") 
                 )
                ) 
        {
            return isWaitingMethod(((App)method).q);
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof Const &&
                 (
                  ((Const)m1).getCon().equals("AI") || 
                  ((Const)m1).getCon().equals("CA") 
                 )
                )
        {
            return true;
        }
        else if ( method instanceof App && (m1 = ((App)method).p) instanceof App &&
                  (m2 = ((App)m1).p) instanceof Const &&
                  (
                   ((Const)m2).getCon().equals("AI") || 
                   ((Const)m2).getCon().equals("CA") 
                  )
                )
        {
            return isWaitingMethod(((App)m1).q) || isWaitingMethod(((App)method).q);
        }
        else
            throw new TypeVerificationException();
    }
    
    private Term updateMethod(String currentMethod, String newMethod) {
        
        if (currentMethod.equals(""))
            return new Const(newMethod);
        else {
            Term methodTerm = ProofMethodUtilities.getTerm(currentMethod);
            Term t = methodTerm;
            Term aux = null;
            Term father = methodTerm;
            try {
                if (t instanceof App)
                   aux = ((App)t).q;  
                while (aux != null && !(aux instanceof Const) && isWaitingMethod(aux)) {
                   father = t;
                   t = aux;
                   aux = ((App)aux).q;
                }
                if (aux == null)
                   methodTerm = new App(methodTerm, new Const(newMethod));
                else if (aux instanceof Const && isWaitingMethod(aux)) 
                   ((App)t).q = new App(aux, new Const(newMethod));
                else { 
                    /*if (father == methodTerm && isWaitingMethod(t))
                      methodTerm = new App(methodTerm, new Const("DM"));
                    else */
                    if (father == t)
                        methodTerm = new App(methodTerm, new Const(newMethod));
                    else
                        ((App)father).q = new App(t, new Const(newMethod));
                }
                  
                return methodTerm;
            }
            catch (TypeVerificationException e) {
                e.printStackTrace();
                return new Const("error");
            }
        }
    }
    
    private Term eraseMethod(String currentMethod) {

        if (currentMethod.length() <= 3)
            return null;
        else {
            Term currMethodTerm = ProofMethodUtilities.getTerm(currentMethod);
            Term father = currMethodTerm;
            Term q = ((App)father).q;
            Term aux = null;
            if ( q instanceof Const)
               return ((App)father).p;
            else {
              aux = q;
              q = ((App)q).q;
            }
            while ( q instanceof App) {
                father = aux;
                aux = ((App)father).q;
                q = ((App)aux).q;
            }
            ((App)father).q = ((App)aux).p;
            
            return currMethodTerm;
        }
    }
    
    public static boolean isBaseMethod(Term method) {
        if (method instanceof App)
            return false;
        else if (((Const)method).getCon().equals("DM") || 
                 ((Const)method).getCon().equals("SS") ||
                 ((Const)method).getCon().equals("TR") ||
                 ((Const)method).getCon().equals("WE") ||
                 ((Const)method).getCon().equals("ST")
                )
            return true;
        else
            return false;
    }
   
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Inferir",headers="Accept=application/json", produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody InferResponse infer(@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion, @PathVariable String username, 
            @PathVariable String nTeo, @PathVariable String nSol, @RequestParam(value="nuevoMetodo") String nuevoMetodo/*, @RequestParam(value="teoremaInicial") String teoremaInicial, @RequestParam(value="nuevoMetodo") String nuevoMetodo */) 
    {
        InferResponse response = new InferResponse();
        PredicadoId predicadoid=new PredicadoId();
        predicadoid.setLogin(username);
        /* Jean
        // FIND THE THEOREM BEING USED IN THE HINT
+       String tipoTeo = nStatement.substring(0, 2);
+        String numeroTeo = nStatement.substring(3, nStatement.length());
        */
        Term statementTerm = null;
        if (nStatement.length() >= 4) {
            // FIND THE THEOREM BEING USED IN THE HINT
            String tipoTeo = nStatement.substring(0, 2);
            String numeroTeo = nStatement.substring(3, nStatement.length());
        
            if (tipoTeo.equals("ST")){
                Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
            }
            else if(tipoTeo.equals("MT")){
                Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
            }
            else {
                response.setErrorParser2("statement format error");
                return response;
            }
            if (statementTerm == null) {
                response.setErrorParser2("The statement doesn't exists");
                return response;
            }
        }
        /* Jean
        if (tipoTeo.equals("ST")){
+            Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
+            statementTerm = resuelve.getTeorema().getTeoTerm();
         }
        */
        else {
        /* Jean
        else if(tipoTeo.equals("MT")){
+            Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
+            statementTerm = dispone.getMetateorema().getTeoTerm();    
        */
            response.setErrorParser2("statement format error");
            return response;
        }
    	
        // CREATE THE INSTANTIATION
    	ArrayList<Object> arr = null;
        if (!instanciacion.equals("")){
          /*Jean solo esta linea CharStream in2 = CharStreams.fromString(instanciacion);
          TermLexer lexer2 = new TermLexer(in2);
          CommonTokenStream tokens2 = new CommonTokenStream(lexer2);
          TermParser parser2 = new TermParser(tokens2);
          try{*/
             //Jean el try descomentado solo con esta linea arr=parser2.instantiate(predicadoid,predicadoManager,simboloManager).value;
          arr=termUtilities.instanciate(instanciacion, predicadoid, predicadoManager, simboloManager);
          /*}
          catch(RecognitionException e){ // Wrong instantiation sent by the user
              String hdr = parser2.getErrorHeader(e);
              String msg = e.getMessage(); 
              response.setErrorParser2(hdr + " " + msg);
                
              return response;
          }*/
        }
        
        // CREATE LEIBNIZ
        Term leibnizTerm = null;
        if (!leibniz.equals("")){
            /*CharStream in3 = CharStreams.fromString(leibniz);
            TermLexer lexer3 = new TermLexer(in3);
            CommonTokenStream tokens3 = new CommonTokenStream(lexer3);
            TermParser parser3 = new TermParser(tokens3);
            try{*/
               //leibnizTerm =parser3.lambda(predicadoid,predicadoManager,simboloManager).value;
            leibnizTerm =termUtilities.lambda(leibniz, predicadoid, predicadoManager, simboloManager);
            if ( ((Bracket)leibnizTerm).isIdFunction()) {
                leibnizTerm = null;
                leibniz = "";
            }
            /*}
            catch(RecognitionException e) { // Wrong leibniz sent by the user
                String hdr = parser3.getErrorHeader(e);
                String msg = e.getMessage(); 
                response.setErrorParser3(hdr + " " + msg);
                
                return response;
            }*/
        }   
      
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
        Term typedTerm = solucion.getTypedTerm();
        Term formula = resuel.getTeorema().getTeoTerm();
        String metodo = solucion.getMetodo();
        Term methodTerm = ProofMethodUtilities.getTerm(metodo);
        Term methodTermIter = methodTerm;
    	Term teoremProved = initStatement(resuel.getTeorema().getTeoTerm(), methodTerm);

        // If the method is And Introduction, get the sub-tree that is being 
        // proved
        if (metodo.startsWith("And Introduction(")) {

            // Get the path string
            String[] methodAndPath = metodo.split("-");
            metodo = methodAndPath[0];
            char[] path = methodAndPath[1].toCharArray();

            String[] subMethods;
            
            // Iterate over the path to get the correct subtree.
            for (char c : path) {
                
                // TODO: we need to add a parser for recusive adoption of this 
                // method
                subMethods = metodo.substring(17,metodo.length()-1).split(";");
                if (c == 'p') {
                    teoremProved = ((App)teoremProved).q;
                    metodo = subMethods[0];
                    typedTerm = ((App)((App)typedTerm).p).q;
                } else if (c == 'q') {
                    teoremProved = ((App)(((App)teoremProved).p)).q;
                    if (subMethods[1].equals("null")) {
                        metodo = subMethods[0];
                    } else {
                        metodo = subMethods[1];
                    }
                    typedTerm = ((App)typedTerm).q;
                }
            }
        }
        
        Stack<Term> methodStack = new Stack<Term>();
        while (!(methodTermIter instanceof Const)) {
            methodStack.push(((App)methodTermIter).p);
            if (methodTermIter.toStringFinal().startsWith("CR"))
                methodTermIter = ((App)methodTermIter).q;
        }
        // CREATE THE NEW INFERENCE DEPENDING ON THE PROVE TYPE
        Term infer = null;
        try 
        {
            if(methodTermIter.toStringFinal().equals("DM")) {
        	infer = createDirectMethodInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
            } else if (methodTermIter.toStringFinal().equals("SS")) {
        	infer = createOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
            } else if (methodTermIter.toStringFinal().equals("WE") || 
                          methodTermIter.toStringFinal().equals("ST") || 
                          methodTermIter.toStringFinal().equals("TR")
                      ) {
                infer = createWSInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
            } else if (methodTermIter.toStringFinal().equals("Natural Deduction,one-sided")) {
        	infer = createDeductionOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
            } else if (methodTermIter.toStringFinal().equals("Natural Deduction,direct")) {
                infer = createDeductionDirectInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
            }
            /*
            if(metodo.equals("Direct method")) {
+                       infer = createDirectMethodInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
+               }else if(metodo.equals("Starting from one side")) {
+                       infer = createOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
+               }else if(metodo.equals("DWeakening")) {
+                       infer = createWSInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
+               }else if(metodo.equals("Natural Deduction,one-sided")) {
+                       infer = createDeductionOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
+               }else if(metodo.equals("Natural Deduction,direct")) {
+                       infer = createDeductionDirectInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
+               }
            */
        // If something went wrong building the new hint
        }catch(TypeVerificationException e) {
            response.generarHistorial(username,formula, nTeo,typedTerm,false,true, methodTerm,resuelveManager,disponeManager,simboloManager);
            return response;
        }

        // CREATE THE NEW PROOF TREE BY ADDING THE NEW HINT
        Term newProof =null;
        
        boolean onlyOneLine = typedTerm.type() == null;
        Term currentProof;
        if (onlyOneLine) // If the proof only has one line so far
            currentProof = new TypedA(new App(new App(new Const(1,"c_{1}",false,1,1),
                            typedTerm),typedTerm));
        else
            currentProof = typedTerm;
        int i, j;
        i = 0;
        j = 0;
        while (newProof == null && i < 2) {
            try {
                if (i == 1 && j == 0)
                    infer = new TypedApp(new TypedS(infer.type()), infer);
                if (methodTermIter.toStringFinal().equals("WE") || 
                    methodTermIter.toStringFinal().equals("ST") ||
                    methodTermIter.toStringFinal().equals("TR")    
                   ) 
                {
                    newProof=addInferToWSProof(currentProof, infer); // si no da excepcion cuando 
                                 // typedTerm.type()==null entonces la inferencia 
        			//es valida con respecto a la primera exp
                } 
                else {
                    newProof=addInferToProof(currentProof, infer);// si no da excepcion cuando 
                                 // typedTerm.type()==null entonces la inferencia 
        			//es valida con respecto a la primera exp
                }
                if (onlyOneLine) 
                    newProof=infer;
            }
            catch (TypeVerificationException e) {
                if ((i == 1 && !onlyOneLine) || (i == 1 && j == 1))
                {
                    response.generarHistorial(username,formula, nTeo,typedTerm,false,true,new Const(metodo),resuelveManager,disponeManager,simboloManager);
                    return response;
                }
                if (onlyOneLine && j == 0) {
                    currentProof = new TypedA(new App(new App(new Const(1,"c_{20}",false,1,1),
                            typedTerm),typedTerm));
                    j=1;
                }
                else if (onlyOneLine && j == 1) {
                    currentProof = new TypedA(new App(new App(new Const(1,"c_{1}",false,1,1),
                            typedTerm),typedTerm));
                    j=0;
                }
            }
            i = (j == 1?i:i+1);
        }
        
        // IF HERE THEN THE INFER WAS VALID
        
        response.setResuelto("0");
             
        Term proof = newProof;
        Term expr = proof.type();
    	Term initialExpr = ((App)expr).q;
    	Term finalExpr = ((App)((App)expr).p).q;
    	
    	// CHECK IF THE PROOF FINISHED
    	
    	Term finalProof = newProof;
    	
    	// Depending on the method we create a new proof if we finished
    	if(methodTermIter.toStringFinal().equals("DM")) {
    	    finalProof = finishedDirectMethodProve(teoremProved, proof, username);
    	}else if(methodTermIter.toStringFinal().equals("SS")) {
    	    finalProof = finishedOneSideProve(initialExpr, finalExpr, teoremProved, proof);
    	}else if(methodTermIter.toStringFinal().equals("Natural Deduction,one-sided")) {
            finalProof = finishedDeductionOneSideProve(initialExpr, finalExpr, teoremProved, proof);
        }else if(methodTermIter.toStringFinal().equals("Natural Deduction,direct")) {
            finalProof = finishedDeductionDirectProve(initialExpr, teoremProved, finalExpr, proof, username);	
        }else if(methodTermIter.toStringFinal().equals("WE")) {
            finalProof = finishedWeakProve(expr, teoremProved, proof);
        }else if(methodTermIter.toStringFinal().equals("ST")) {
            finalProof = finishedStrengProve(expr, teoremProved, proof);
        }else if (methodTermIter.toStringFinal().equals("TR")) {
            finalProof = finishedTransProve(expr, teoremProved, proof);
        }
        
        while (!methodStack.isEmpty()) {
            Term met = methodStack.pop();
            if (met.toStringFinal().equals("CR")) {
                finalProof = finishedCounterRecProve(teoremProved, proof);
            }
        }
        /* Jean
        newProof = finishedDeductionDirectProve(teoremProved, proof, username);
        */
    	
        // Get the complete the method to check if the proof was And 
        // Introduction
        String outerMethod = solucion.getMetodo();
        Term originalTerm = solucion.getTypedTerm();
        Term caseProof = null;

        // Check if the proof was an And Introduction
        if (outerMethod.startsWith("And Introduction(")) {

            // Get the path string
            String[] methodAndPath = outerMethod.split("-");
            metodo = methodAndPath[0];
            char[] path = methodAndPath[1].toCharArray();

            // TODO: check the path to the correct tree
            // We need to create a parse to apply this method recursively.
            try {
                //                      .
                //                     / \
                //         leftTreeTerm   caseqTerm
                //              /   \ 
                //          uTerm   casepTerm
                //
                // Append the new proof to the tree where it has to be.
                Term leftTreeTerm = ((App)originalTerm).p;

                System.out.println("leftTreeTerm: " + leftTreeTerm);

                Term uTerm = ((App)leftTreeTerm).p;
                Term caseqTerm =((App)originalTerm).q;
                
                // Store the proof of the case to check if it is final.
                caseProof = finalProof;

                // Check if it has to append the tree on the right or on the 
                // left
                if (path[0] == 'p') {
                    finalProof = new TypedApp(
                        new TypedApp(
                            uTerm,
                            finalProof
                        ),
                        caseqTerm
                    );
                } else {
                    finalProof = new TypedApp(
                        leftTreeTerm,
                        finalProof
                    );
                }

            } catch (TypeVerificationException e) {
                response.generarHistorial(username,formula, nTeo,finalProof,false,true, new Const(outerMethod),resuelveManager,disponeManager,simboloManager);
                return response;
            }
        } 

        System.out.println("caseProof: " + caseProof);

    	// newProve might or might not be different than pasoPostTerm
    	
    	// UPDATE SOLUCION 
    	solucion.setTypedTerm(finalProof);

        Boolean isFinalSolution = false;
        Boolean isCaseSolution = false;

        // We need to check if we're finishing a case or the whole proof if we're
        // on And Introduction method.
        if (outerMethod.startsWith("And Introduction(") ) {

            String[] methodAndPath = outerMethod.split("-");
            char[] path = methodAndPath[1].toCharArray();

            isCaseSolution = teoremProved.equals(caseProof.type()); 
            
            if (isCaseSolution) {
                // If it is a solution for the first case, chage the path to 
                // start the proof of q.
                if (path[0] == 'p') {
                    outerMethod = methodAndPath[0] + "-q";
                    solucion.setMetodo(outerMethod);
                    response.setEndCase(true);
                // If not, we're proving the 2nd and last case.
                } else {                    
                	Term originalTeo = resuel.getTeorema().getTeoTerm();
                    
                    Term pProof = ((App)(((App)originalTerm).p)).q;
                    Term qProof = caseProof;
                    Term pTeo = ((App)originalTeo).q;
                    Term qTeo = ((App)(((App)originalTeo).p)).q;

                    System.out.println("qProof: " + qProof);

                    Term joinedProof = finishAItemplates(pProof, qProof, pTeo, qTeo);
                    
                    solucion.setMetodo(methodAndPath[0]);
                    solucion.setTypedTerm(joinedProof);
                    isFinalSolution = originalTeo.equals(joinedProof.type());
                }
            }
        } 
        // If we don't have cases, we still need to check if it is a final
        // solution
        else {
            isFinalSolution = teoremProved.equals(finalProof.type());
        }
        
        // If finished mark solucion as solved
        if (isFinalSolution) {
        	response.setResuelto("1");
        	solucion.setResuelto(true);
        	resuel.setResuelto(true);
        	resuelveManager.updateResuelve(resuel);
        }

        solucionManager.updateSolucion(solucion);
        response.generarHistorial(
            username,
            formula, 
            nTeo,
            finalProof,
            true,
            true,
            methodTerm,
            resuelveManager,
            disponeManager,
            simboloManager
        );
        return response;
    }

    /**
     * Inserts formulas for each case on the templates to created a valid
     * proof for And Introduction
     * @param pProof Proof tree for left side case
     * @param qProof Proof tree for right side case
     * @param pTeo Theorem formula of left side case
     * @param qTeo Theorem formula of right side case
     * @return
     */
    private Term finishAItemplates(
        Term pProof, 
        Term qProof, 
        Term pTeo, 
        Term qTeo
    ) {
        // Extract templates for each of the cases from datavase
        String template1 = plantillaTeoremaManager.getPlantillaTeoremaById(1)
                            .getTemplate();
        
        String template2 = plantillaTeoremaManager.getPlantillaTeoremaById(2)
                            .getTemplate();

        // Apply basic template to both cases
        String template1p = template1.replace("%T1", pTeo.toString())
                              .replace("%T2", pProof.toString());
        String template1q = template1.replace("%T1", qTeo.toString())
                              .replace("%T2", qProof.toString());
        
        // Apply unification template
        String template2pq = template2.replace("%M1P", template1p)
                                      .replace("%P1", pTeo.toString())
                                      .replace("%M1Q", template1q);

        // Parse the new tree from its string.
        Term proof = combUtilities.getTerm(template2pq);

        return proof;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Retroceder",produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse retroceder( /*@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion,*/ @PathVariable String username, 
            @PathVariable String nTeo, @PathVariable String nSol)
    {   
        InferResponse response = new InferResponse();

        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Solucion solucion = solucionManager.getSolucion(resuelve.getDemopendiente());
        int respRetroceder;
        Term method = null;
        
        if(nSol.equals("new")){
            respRetroceder = 0;
        }
        else{
            if (solucion.getDemostracion().equals("") && !solucion.getMetodo().equals("")) 
                respRetroceder = 0;
            else
                respRetroceder = solucion.retrocederPaso();
            if (respRetroceder == 0) {
               method = eraseMethod(solucion.getMetodo());
               solucion.setMetodo((method == null?"":method.toStringFinal()));
            }
            else
               method = ProofMethodUtilities.getTerm(solucion.getMetodo());
            solucionManager.updateSolucion(solucion);
        }
        
        //List<PasoInferencia> inferencias = solucion.getArregloInferencias();
        Term formula = resuelve.getTeorema().getTeoTerm();

        response.generarHistorial(
               username,
               formula, 
               nTeo, 
               respRetroceder==0?null:solucion.getTypedTerm(), 
               true, 
               true, 
               method,
               resuelveManager, 
               disponeManager, 
               simboloManager);
        
        if(respRetroceder==0 && method != null){
            response.setCambiarMetodo("2");
        }
        else if(respRetroceder==0 && method == null){
            response.setCambiarMetodo("1");
        }
        else{
            response.setCambiarMetodo("0");
        }
        
        return response;
    }
        
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaClickeableMD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaClickeableMD( /*@RequestParam(value="teoid") String teoid,*/ 
            @PathVariable String username, 
            @PathVariable String nSol, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
      
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        
        Term metodoTerm = null;
        if (!nSol.equals("new"))
        {
            // Obtains the solution from DB.
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));     
            String method = solucion.getMetodo();
            if (!method.equals(""))
               metodoTerm = ProofMethodUtilities.getTerm(method);
        }

        response.generarHistorial(
            username, 
            term,
            "",
            nTeo, 
            null, 
            true, 
            false, 
            metodoTerm, 
            resuelveManager, 
            disponeManager, 
            simboloManager, 
            "DM",
            true
        );

        
        /*String formula = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        
        formula = "\\cssId{teoremaMD}{\\style{cursor:pointer; color:#08c;}{"+ formula + "}}";
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formula+ "$</center> Proof: ";
        response.setHistorial(historial);  */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaClickeablePL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaClickeablePL( /*@RequestParam(value="teoid") String teoid,*/ 
            @PathVariable String username, 
            @PathVariable String nTeo,
            @PathVariable String nSol)
    {   
        InferResponse response = new InferResponse();
      
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
       // String equiv = ((Const)((App)((App)term).p).p).getCon();
        
        /* Jean
        String equiv;
        try { // If something here goes wrong is because the theorem does not have one side form
               if(nuevoMetodo.equals("Natural Deduction,one-sided")) {
                       String impl = ((Const)((App)((App)term).p).p).getCon();
                       if(!impl.equals("c_{2}")) { // If is not an implication its wrong
                               response.setLado("0");
                    return response;
                       }
                       term = ((App)((App)term).p).q;
               }
               equiv = ((Const)((App)((App)term).p).p).getCon();
        }catch (Exception e) {
               response.setLado("0");
            return response;
               }
        */

        /*if(!equiv.startsWith("c_{1}") && !equiv.startsWith("c_{20}")){ 
            response.setLado("0");                                    
            return response;
        }
        else*/
            response.setLado("1");

        Term metodoTerm = null;
        if (!nSol.equals("new"))
        {
            // Obtains the solution from DB.
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));     
            String method = solucion.getMetodo();
            if (!method.equals(""))
               metodoTerm = ProofMethodUtilities.getTerm(method);
        }

        response.generarHistorial(
            username, 
            term,
            "",
            nTeo, 
            null, 
            true, 
            false, 
            metodoTerm, 
            resuelveManager, 
            disponeManager, 
            simboloManager, 
            "SS",
            true
        );
        /*String formulaDer = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInf(simboloManager,"");
        String formulaIzq = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInf(simboloManager,"");
        String operador = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).p.toStringInf(simboloManager,"");//resuelve.getTeorema().getOperador();
        
        formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
        formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaIzq+"$ $"+ operador +"$ $" + formulaDer + "$</center> Proof: ";
        response.setHistorial(historial);  
        */
        return response;
    }
    
    private Term initStatement(Term beginFormula, Term method) {
        
        if (method instanceof Const)
            return beginFormula;
        else if ( ((App)method).p.toString().equals("CR") ) {
            Term antec = ((App)beginFormula).q;
            antec = new App(new Const(7 ,"c_{7}"), antec);
            Term consec = ((App)((App)beginFormula).p).q;
            consec = new App(new Const(7,"c_{7}"),consec);
            beginFormula = new App(new App(new Const(2,"c_{2}"),antec), consec);
            
            return initStatement(beginFormula, ((App)method).q );
        }
        else
            return null;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialMD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialMD(@RequestParam(value="teoid") String teoid, @PathVariable String nSol, @PathVariable String username, 
            @PathVariable String nTeo) //Jean throws TypeVerificationException
    {   
        String nuevoMetodo = "DM";
        InferResponse response = new InferResponse();

        // Jean response.setLado("1");
        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm();
        
        /*
        if(nuevoMetodo.equals("Natural Deduction,direct")) {
               
               // If not of the form H => Q its wrong
               if( !(formulaAnterior instanceof App && ((App)formulaAnterior).p instanceof App && ((App)((App)formulaAnterior).p).p.toString().equals("c_{2}"))){
                       response.setLado("0");
                return response;
               }
               
               String prefix = teoid.substring(0, 3);
               teoid = teoid.substring(3,teoid.length());
               Term theorem = null;
               
               if(teoid.equals("Q")) { // if started from consequent
                       // HINT (H => Q) == (H == H /\ Q) 
                       
                       // p,q := H,Q
                       ArrayList<Var> vars = new ArrayList<Var>();
                       vars.add(new Var('p')); 
                       vars.add(new Var('q'));   
                       ArrayList<Term> terms = new ArrayList<Term>();
                       terms.add(((App)formulaAnterior).q);
                       terms.add(((App)((App)formulaAnterior).p).q);
                       Sust instantiation = new Sust(vars, terms);
                       TypedI I = new TypedI(instantiation);
                       
                       // p => q == (p == p /\ q)
                       TypedA A = new TypedA(new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"),new Var('q')),new Var('p'))), new Var('p'))),
                                       new App(new App(new Const("c_{2}"), new Var('q')), new Var('p'))));
                       
                       TypedApp formulaTerm = new TypedApp(I, A);
        
                       Solucion solucion = new Solucion(resuelveAnterior,false,formulaTerm, nuevoMetodo);
                solucionManager.addSolucion(solucion);
                response.setnSol(solucion.getId()+"");
                       
                response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,nuevoMetodo,
                        resuelveManager,disponeManager,simboloManager);
                return response;
               }else if(teoid.equals("H")) {
                       theorem = ((App)formulaAnterior).q;
               }else {
                       
                       if(prefix.equals("MT-")) {
                               Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, teoid);
                    theorem = dispone.getMetateorema().getTeoTerm();
                       }else {
                               Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,teoid);
                       theorem = resuelve.getTeorema().getTeoTerm();
                       }
        
               }
               
               // if here then starting form another theorem or H
               
               Term H = ((App)formulaAnterior).q;
               
               
               // HINT 1
                       
                       // true == (q == q)
                       TypedA A = new TypedA(new App(new App(new Const("c_{1}"), new App(new App(new Const("c_{1}"), new Var('q')),new Var('q'))),new Const("c_{8}")));
                       
                       // q := H
                       ArrayList<Var> vars = new ArrayList<Var>();
                       vars.add(new Var('q')); 
                       ArrayList<Term> terms = new ArrayList<Term>();
                       terms.add(H);
                       Sust instantiation = new Sust(vars, terms);
                       TypedI I = new TypedI(instantiation);
                       
                       TypedApp hint1 = new TypedApp(I,A);
                       
                       
                       // HINT 2
                       
                       // H == z
                       Bracket leib = new Bracket(new Var('z'), new App(new App(new Const("c_{1}"), new Var('z')), H));
                       TypedL L = new TypedL(leib);
                       
                       // p := H
                       vars = new ArrayList<Var>();
                       vars.add(new Var('p'));  
                       instantiation = new Sust(vars, terms);
                       I = new TypedI(instantiation);
                       
                       // p /\ true == p
                       A = new TypedA(new App( new App( new Const("c_{1}") ,new Var('p')), new App(new App(new Const("c_{5}"), new Const("c_{8}")), new Var('p'))));
                       
                       TypedApp hint2 = new TypedApp(I, A);
                       hint2 = new TypedApp(L, hint2);
                       hint2 = new TypedApp(new TypedS(hint2.type()), hint2);
               
               // HINT 3
                       
                       // H = H ^ z
                       leib = new Bracket(new Var('z'), new App( new App(new Const("c_{1}"), new App(new App(new Const("c_{5}"), new Var('z')), H)), H));
                       L = new TypedL(leib);
                       // Create teorema == true
                       TypedApp metaTheorem= metaTheorem(theorem);
                       
                       TypedApp hint3 = new TypedApp(L, metaTheorem);
                       hint3 = new TypedApp(new TypedS(hint3.type()), hint3);
               
                       // BUILD THE NEW PROOF
                       TypedApp formulaTerm = new TypedApp(hint1, hint2);
                       formulaTerm = new TypedApp(formulaTerm, hint3);
                       
                       Solucion solucion = new Solucion(resuelveAnterior,false,formulaTerm, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
               
            response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,nuevoMetodo,
                    resuelveManager,disponeManager,simboloManager);
            return response;
               
               
               
        }
        */
        //String formula = "";
        Term formulaTerm = null;
        if (teoid.substring(0, 3).equals("ST-"))
        {
          Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,teoid.substring(3,teoid.length()));
          //String formula = resuelve.getTeorema().getTeoTerm().toStringInfFinal();
          formulaTerm = resuelve.getTeorema().getTeoTerm();
          //formula = formulaTerm.toStringInfLabeled();
        }
        else if (teoid.substring(0, 3).equals("MT-"))
        {
          Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, teoid.substring(3,teoid.length()));
          formulaTerm = dispone.getMetateorema().getTeoTerm();
          //formula = formulaTerm.toStringInfLabeled();
        }
        
        Term metodoTerm = null;
        if (nSol.equals("new"))
        {
            Solucion solucion = new Solucion(resuelveAnterior,false,formulaTerm, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            // Obtains the solution from DB.
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));     
            String method = solucion.getMetodo();
            
            // If the method is And Introduction, we have to look for the 
            // correct sub tree to operate.
            if (method.startsWith("And Introduction(")) {
                
                // Obtains the path of the current sub-tree.
                String[] methodAndPath = method.split("-");
                String[] methods = methodAndPath[0].substring(
                    17, 
                    methodAndPath[0].length() - 1
                ).split(";");

                Term caseqTerm = ((App)(((App)formulaAnterior).p)).q;
                
                try {
                    // If first case method is null, there's no path to follow
                    // We have to initialize the path.
                    if (methods[0].equals("null")) {
                        formulaTerm = new TypedApp(new TypedApp(new TypedU(), formulaTerm), caseqTerm); 
                        // TODO: need to check this for recursive case
                        // We need to implement a parser for recursive case
                        nuevoMetodo = "And Introduction(" + nuevoMetodo + 
                                      ";null)-p";
                        
                    } else {
                        Term casepTerm = ((App)(((App)(solucion.getTypedTerm())).p)).q;

                        formulaTerm = new TypedApp(new TypedApp(new TypedU(), casepTerm), formulaTerm);
                        nuevoMetodo = "And Introduction(" + methods[0] + ";" + 
                                      nuevoMetodo + ")-q";
                    }
                    solucion.setTypedTerm(formulaTerm);
                } catch (TypeVerificationException e) {
                    response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,true,new Const(nuevoMetodo),
                                  resuelveManager,disponeManager,simboloManager);
                    return response;
                }
            } else {
                metodoTerm = updateMethod(method, nuevoMetodo);
                if (teoid.substring(3,teoid.length()).equals(nTeo)) {
                   formulaTerm = initStatement(formulaTerm,metodoTerm);
                   solucion.setTypedTerm(formulaTerm);
                } else
                   solucion.setTypedTerm(formulaTerm);
                nuevoMetodo = metodoTerm.toStringFinal();
                solucion.setMetodo(nuevoMetodo);
                solucionManager.updateSolucion(solucion);
            }
        }
        
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            formulaTerm,
            true,
            true,
            metodoTerm,
            resuelveManager,
            disponeManager,
            simboloManager 
        );
        //String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        //response.setHistorial(historial);
        response.setCambiarMetodo("0");

        return response;
    }

    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialPL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialPL(@PathVariable String nSol, 
                                                        @RequestParam(value="lado") String lado, 
                                                        @PathVariable String username, 
                                                        @PathVariable String nTeo)
    {
        String nuevoMetodo = "SS";
        InferResponse response = new InferResponse();
        
        /* Jean
        boolean naturalSide = nuevoMetodo.equals("Natural Deduction,one-sided");
        Term H = null;
        */
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Term formulaTerm = resuelve.getTeorema().getTeoTerm();
        
        /* Jean
        if(naturalSide) {
+               H = ((App)formulaAnterior).q;
+               formulaAnterior = ((App)((App)formulaAnterior).p).q;
+        }
        */
        
        /* Jean
        // In natural dededuction case add H /\ to the start
+        if(naturalSide) {
+               formulaTerm = new App(new App(new Const("c_{5}"), formulaTerm), H);
        */
        Solucion solucion = null;
        Term metodoTerm = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null, nuevoMetodo);
            response.setnSol(solucion.getId()+"");
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = updateMethod(method, nuevoMetodo);
            formulaTerm = initStatement(formulaTerm,metodoTerm);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
        }
        
        if(lado.equals("d")){
            //formula = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInfFinal();
            formulaTerm = ((App)((App)formulaTerm).p).q;
            //Jean formulaTerm = ((App)((App)formulaAnterior).p).q;
        }
        else if(lado.equals("i")){
            //formula = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInfFinal();
            formulaTerm = ((App)formulaTerm).q;
            // Jean formulaTerm = ((App)formulaAnterior).q;
        }
        
        solucion.setTypedTerm(formulaTerm);
        if (nSol.equals("new"))
            solucionManager.addSolucion(solucion);
        else
            solucionManager.updateSolucion(solucion);
        
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            formulaTerm,
            true,
            true,
            metodoTerm,
            resuelveManager,
            disponeManager,
            simboloManager 
        );
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial); */
        response.setCambiarMetodo("0");

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialD(@PathVariable String nSol, 
                                                       @PathVariable String username, 
                                                       @PathVariable String nTeo)
    {   
        String nuevoMetodo = "WE";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        //Teorema t = resuelve.getTeorema();
        //Term term = t.getTeoTerm();
        
        //String formula = "";
        Term formulaTerm = formulaAnterior;
        
        Term metodoTerm = null;
        Solucion solucion = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null, nuevoMetodo);
            response.setnSol(solucion.getId()+"");
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = updateMethod(method, nuevoMetodo);
            formulaTerm = initStatement(formulaTerm,metodoTerm);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
        }
        
        String operador = ((Const)((App)((App)formulaTerm).p).p).getCon();
        if(operador.equals("c_{3}")){
            response.setLado("d");
            formulaTerm = ((App)((App)formulaTerm).p).q;
        }
        else if(operador.equals("c_{2}")){
            response.setLado("i");
            formulaTerm = ((App)formulaTerm).q;
        }
        else{
            response.setLado("0");
        }
        
        solucion.setTypedTerm(formulaTerm);
        if (nSol.equals("new"))
            solucionManager.addSolucion(solucion);
        else
            solucionManager.updateSolucion(solucion);
        
        solucionManager.addSolucion(solucion);
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            formulaTerm,
            true,
            true,
            metodoTerm,
            resuelveManager,
            disponeManager,
            simboloManager 
        );
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */
        response.setCambiarMetodo("0");

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialF", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialF(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {
        String nuevoMetodo = "ST";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        //String formula = "";
        Term formulaTerm = formulaAnterior;
        
        Term metodoTerm = null;
        Solucion solucion = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null,nuevoMetodo);
            response.setnSol(solucion.getId()+"");
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = updateMethod(method, nuevoMetodo);
            formulaTerm = initStatement(formulaTerm,metodoTerm);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
        }
        
        String operador = ((Const)((App)((App)formulaTerm).p).p).getCon();
        if(operador.equals("c_{3}")){
            response.setLado("i");
            formulaTerm = ((App)formulaTerm).q;
        }
        else if(operador.equals("c_{2}")){
            response.setLado("d");
            formulaTerm = ((App)((App)formulaTerm).p).q;
        }
        else{
            response.setLado("0");
        }
        
        solucion.setTypedTerm(formulaTerm);
        if (nSol.equals("new"))
            solucionManager.addSolucion(solucion);
        else
            solucionManager.updateSolucion(solucion);
        
        solucionManager.addSolucion(solucion);
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            formulaTerm,
            true,
            true,
            metodoTerm,
            resuelveManager,
            disponeManager,
            simboloManager 
        );
        response.setCambiarMetodo("0");
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */

        return response;
    }

    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatementT", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniStatementT(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {
        String nuevoMetodo = "TR";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Term formulaTerm = formulaAnterior;
        
        Term metodoTerm = null;
        Solucion solucion = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null,nuevoMetodo);
            response.setnSol(solucion.getId()+"");
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = updateMethod(method, nuevoMetodo);
            formulaTerm = initStatement(formulaTerm,metodoTerm);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
        }
        
        String operador = ((Const)((App)((App)formulaTerm).p).p).getCon();
        // you must check if operator is transitive before the following
        if(!operador.equals("c_{2}") && !operador.equals("c_{3}")){
            response.setLado("i");
            formulaTerm = ((App)formulaTerm).q;
        }
        else{
            response.setLado("0");
        }
        
        solucion.setTypedTerm(formulaTerm);
        if (nSol.equals("new"))
            solucionManager.addSolucion(solucion);
        else
            solucionManager.updateSolucion(solucion);
        
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            formulaTerm,
            true,
            true,
            metodoTerm,
            resuelveManager,
            disponeManager,
            simboloManager 
        );
        response.setCambiarMetodo("0");
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatementCR", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniStatementCR(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        String nuevoMetodo = "CR";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        try {
            //String formula = "";
            if (((Const)((App)((App)formulaAnterior).p).p).getId() != 2) {
               response.setLado("0");
               return response;
           }
        } catch (ClassCastException e) {
            response.setLado("0");
            return response;
        }
        
        Term metodoTerm = null;
        
        if (nSol.equals("new"))
        {
            metodoTerm = new Const(nuevoMetodo);
            Solucion solucion = new Solucion(resuelve,false,null, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {   
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = updateMethod(solucion.getMetodo(), nuevoMetodo);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,null,true,false,metodoTerm,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */
        response.setCambiarMetodo("2");

        return response;
    }
    
    /**
     * Inits a proof for And Introduction method.
     * @param nSol Number of the solution.
     * @param username Name of the user that is making the proof.
     * @param nTeo Number of teorem to be prooved.
     * @return
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniAndI", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniAndI(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {
        InferResponse response = new InferResponse();

        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();

        // If we're starting a new proof.
        if (nSol.equals("new"))
        {
            // Get the cases of the proof.
            Term casepTerm = ((App)formulaAnterior).q;
            Term caseqTerm = ((App)(((App)formulaAnterior).p)).q;

            // Creates a new tree for the proof of the form:
            //          .
            //         / \
            //        .   qTerm
            //       / \
            // TypedU   pTerm
            //
            try {
                Term formulaTerm = new TypedApp(
                    new TypedApp(
                        new TypedU(), 
                        casepTerm
                    ), 
                    caseqTerm
                );

                // Saves the empty solution to the database.
                Solucion solucion = new Solucion(
                    resuelve,
                    false,
                    formulaTerm,
                    "And Introduction(null;null)-p"
                );
                solucionManager.addSolucion(solucion);

                // Stores the number of the solution to the reponse.
                response.setnSol(Integer.toString(solucion.getId()));
            } catch (TypeVerificationException e) {
                return response;
            }
           
            // Get's the expression of the first case (pTerm) to print it to
            // the user.
            String expression1 = casepTerm.toStringInf(simboloManager,"");
            String historial = "Theorem " + nTeo + ":<br> <center>$" + 
                               formulaAnterior.toStringInf(simboloManager,"") +
                               "$</center> Proof:<br><br>";
            historial += "Proof of $" + expression1 + "$:<br><br>Proof: ";
            response.setHistorial(historial);  
        }
        // If we're taking over a new proof.
        else {
            // TODO: review this clause.
            // Case you have a solution already started.
            String expression2 = ((App)((App)formulaAnterior).p).q.toStringInf(simboloManager,"");
        }

        return response;


    }

    public void setUsuarioManager(UsuarioManager usuarioManager) 
    {
        this.usuarioManager = usuarioManager;
    }
    
    public void setTerminoManager(TerminoManager terminoManager) 
    {
        this.terminoManager = terminoManager;
    }
}
