package com.calclogic.controller;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.Dispone;
import com.calclogic.entity.PredicadoId;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Predicado;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
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
import com.calclogic.lambdacalculo.TypedU;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SolucionManager;
import com.calclogic.service.TerminoManager;
import com.calclogic.service.UsuarioManager;
import com.calclogic.service.CategoriaManager;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.MetateoremaManager;
import com.calclogic.service.TeoremaManager;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.MostrarCategoriaManager;
import com.calclogic.service.PlantillaTeoremaManager;
import com.calclogic.service.SimboloManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.text.StrSubstitutor;
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
    private TeoremaManager teoremaManager;
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
    //@Autowired
    //private CombUtilities combUtilities;
    //@Autowired
    //private TermUtilities termUtilities;
    
    /**
     * Controller that respond to HTTP GET request and return the selection statement
     * page if there is a user session active. 
     * 
     * @param username: login of the user that make the request. It's is in the URL also
     * @param map: Mapping with values of each variables that will send to infer.jsp 
     * @return the String "infer" that refer to infer.jsp template if the user have an active session.
     *         With the right values in map, the infer.jsp template is filled to obtain the 
     *         selection statement view
     */
    @RequestMapping(value="/{username}", method=RequestMethod.GET)
    public String selectTeoView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminWithSol(username);
        for (Resuelve r: resuelves) // Este for debes mandarlo para el manager y quitar
        {                           // la construccion del metateorema del true
            Teorema t = r.getTeorema();
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),t.getTeoTerm()));
        }
        Usuario usr = usuarioManager.getUsuario(username);
        InfersForm infersForm = new InfersForm();
        List <Categoria> showCategorias = new LinkedList<Categoria>();
        List<MostrarCategoria> mostrarCategoria = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(usr);
        for (int i = 0; i < mostrarCategoria.size(); i++ ){// se puede evitar este for si se mandan
                                                           // los MostrarCategorias al jsp en lugar 
                                                           // de las categorias
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

    /**
     * Controller that respond to HTTP GET request. Return the proof environment 
     * page of the statement (if there is a user session active). 
     * 
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user request to prove. It is in the URL also
     * @param map: Mapping with values of each variables that will send to infer.jsp 
     * @return the String "infer" that refer to infer.jsp template if the user have an active session
     *         With the right values in map, the infer.jsp template is filled to obtain the 
     *         proof environment page
     */
    @RequestMapping(value="/{username}/{nTeo:.+}", method=RequestMethod.GET)
    public String inferView(@PathVariable String username, @PathVariable String nTeo, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);

        // Case when the user could only see the theorem but had not a Resuelve object associated to it
        if (resuel == null) {
            resuel = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",nTeo);
            Usuario user = usuarioManager.getUsuario(username);
            resuel.setUsuario(user);
            resuel.setDemopendiente(-1);
            resuel.setSolucions(new HashSet());
            resuel.setResuelto(false);
            resuel = resuelveManager.addResuelve(resuel);
        }
        Term formula = resuel.getTeorema().getTeoTerm();
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminWithSolWithoutAxiom(username,nTeo);
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
/*
            if (typedTerm == null && !hasInnerMethodSelected) 
                map.addAttribute("elegirMetodo","1");
            else if (//typedTerm == null && 
                     hasInnerMethodSelected && response.getCambiarMetodo().equals("2"))
                map.addAttribute("elegirMetodo","2");
            else
                map.addAttribute("elegirMetodo","0");
*/
            map.addAttribute("elegirMetodo",response.getCambiarMetodo());
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
     * Controller that respond for HTTP POST request with JSON encoded parameters. The request is
     * response by showing a instantiation of a statement of the user in the application. The 
     * response is encode with JSON.
     * 
     * @param nStatement: code that identifies, with username, the statement. It is a 
     *                    HTTP POST parameter
     * @param instanciacion: String that encode the substitution operator. It is a 
     *                       HTTP POST parameter
     * @param username: login of the user. It is in the url also
     * @return JSON encoded InstResponse object with the instantiation info 
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
                // Case when the user could only see the theorem but had not a Resuelve object associated to it
                if (resuelve == null) {
                    resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                }
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
                response.setError("The statement doesn't exist");
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
          arr=TermUtilities.instanciate(instanciacion, predicadoid, predicadoManager, simboloManager);
        }
        
        if (arr == null)
            response.setInstantiation(statementTerm.toStringInf(simboloManager, ""));
        else
            response.setInstantiation(statementTerm.sustParall((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1)).toStringInf(simboloManager, ""));
        return response;
    }

    /**
     * Controller that respond for HTTP POST request to set on/off the auto substitution 
     * functionality. The response is encode with JSON.
     * 
     * @param username: login of the user. It is in the URL also
     * @return JSON encoded AutoSustResponse object with the on/off info 
     */
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
     * Controller for automatic filling of the substitution form in the user session. 
     * 
     * @param nStatement: code that identifies the statement. It is a JSON encode HTTP POST parameter
     * @param leibniz: String with the E of Leibniz rule in format C. It is JSON encode 
     *                 HTTP POST parameter
     * @param freeV: String with the list of free variables in format C. It is JSON encode
     *               HTTP POST parameter
     * @param username: name of the user doing the prove. It is in the URL also
     * @param nSol: Id of user solution in which the autosust match the last line.  It is in 
     *              the URL also
     * @return JSON encode SubstResponse Object with the result substitution info
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
                // Case when the user could only see the theorem but had not a Resuelve object associated to it
                if (resuelve == null) {
                    resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                }
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
                response.setError("The statement doesn't exist");
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
            Term methodTerm = ProofMethodUtilities.getTerm(metodo);
            Term typedTerm = getSubProof(solucion.getTypedTerm(),methodTerm,true);

            Term lastLine = typedTerm.type();
            if (lastLine == null)
                lastLine = typedTerm;
            else {
                metodo = currentMethod(methodTerm).toStringFinal();
                if (metodo.equals("WE") || metodo.equals("ST") || metodo.equals("TR")) {
                    int index = wsFirstOpInferIndex1(typedTerm);
                    if (index == 0 || index == 1)
                        lastLine = ((App)((App)typedTerm.type()).p).q;
                    else
                        lastLine = ((App)((App)((App)((App)typedTerm.type()).p).q).p).q;
                }
                else
                    lastLine = ((App)((App)lastLine).p).q;
            }

            Term leibnizTerm = null;
            // CREATE THE INSTANTIATION
            Sust sust = null;
            Equation eq;
            boolean zUnifiable = true;
            if (!leibniz.equals("")){
                leibnizTerm =TermUtilities.getTerm(leibniz, predicadoid, predicadoManager, simboloManager);
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
        }
        response.setSustFormatC(null);
        response.setSustLatex(null);
        return response;
    }
    
    /**
     * This function will only be correct if called when using DirectMethod
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the DirectMethod. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved A == ... == F
     * @param theoremProved: The theorem the user is trying to prove
     * @param proof: The proof tree so far
     * @param username: name of the user doing the prove
     * @param teoNum: id that identify the theorem that the user is trying to prove
     * @return new proof if finished, else return the same proof
     */
    private Term finishedDirectMethodProve(Term theoremProved, Term proof, String username, String teoNum) {
        Term expr = proof.type();
        Term initialExpr = ((App)expr).q;
        Term finalExpr = ((App)((App)expr).p).q; // The last line in the demonstration that the user has made

        // Case when the direct method started from the theorem being proved
        if(theoremProved.equals(initialExpr)) {
            // List of teorems solved by the user. We examine them to check if the current proof already reached one 
            List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminWithSolWithoutAxiom(username,teoNum);
            Term theorem;
            Term mt;
            for(Resuelve resu: resuelves){ // todo este for deberia ser un simple Query
                                               // todo este for deberia ser un simple Query
                                               // todo este for deberia ser un simple Query
                                               // todo este for deberia ser un simple Query
                                               // Quedo claro? deberia ser un simple Query
            	// This is the theorem that is in the database
                theorem = resu.getTeorema().getTeoTerm();
                mt = new App(new App(new Const("c_{1}"),new Const("true")),theorem);

                // If the current theorem or theorem==true matches the final expression (and this theorem is not the one being proved) 
                if (!theorem.equals(theoremProved) && (theorem.equals(finalExpr) || mt.equals(finalExpr))){
                    try {
                        return new TypedApp(new TypedApp(new TypedS(proof.type()), proof),new TypedA(finalExpr)); 
                    }catch (TypeVerificationException e) {
                        Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
                    }
                } 

                // Check if the last line of the proof (finalExpr) is an instance of an already demonstrated theorem
                // >>> It does not work if we do it backwards
                Equation eq = new Equation(theorem, finalExpr);
                Sust sust = eq.mgu(simboloManager);

                // Case when last line is an instantiation of the compared theorem
                if (sust != null){
                    try {
                        TypedA A = new TypedA(theorem); // We treat the compared theorem as an axiom
                        TypedI I = new TypedI(sust); // We give the instantiation format to the substitution above

                        return new TypedApp(new TypedApp(new TypedS(proof.type()), proof),new TypedApp(I,A));

                    }catch (TypeVerificationException e) {
                        Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
                    }
                }     
            }
                        
            // If the proof hasn't finished
            return proof;
        }
        
        // Case when the direct method started from another theorem
        if(finalExpr.equals(theoremProved)) {
            try {
                return new TypedApp(proof, new TypedA(initialExpr));
            }catch (TypeVerificationException e) {
                 Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        
        // If the proof hasn't finished
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
     * @param teoremProved: The theorem the user is trying to prove (even if the original is of 
     *                      the form H => A == B in this case H /\ A ==  H /\ B must be given 
     *                      instead)
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
        
        // If the proof hasn't finished
        return proof;
    }

    /**
     * This function will only be correct if called when using Transitivity method
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the Transitivity method. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved A == ... == F
     * @param expr: Term that represents F
     * @param teoremProved: The theorem that user is trying to prove
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
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
     * caused the whole prove to be correct under the Weakening method. In other case it will return 
     * the proof given as argument.
     * 
     * Do the last equanimity and symmetry of => steps to finish a Weakening proof
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
        // me parece que si la app obliga a empezar de la izquierda, este else es imposible
        else if ( ((App)((App)teoremProved).p).p.toStringFinal().equals("c_{3}") ) {
            if (wsFirstOpInferIndex(proof)!=0 && isInverseImpl(expr,teoremProved) ) {
                TypedA ax = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)expr).p).q+", "+((App)expr).q+"]"));
                return new TypedApp(new TypedApp(inst,ax),proof);
            }
            if(wsFirstOpInferIndex(proof)!=0 && isInverseImpl(((App)((App)expr).p).q,teoremProved) ) {
                TypedA ax = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)((App)expr).p).q).p).q+", "+((App)((App)((App)expr).p).q).q+"]"));
                Term aux = new TypedApp(inst,ax);
                return new TypedApp(new TypedApp(new TypedS(aux.type()),aux),new TypedApp(proof,new TypedA(new Const("c_{8}"))));
            }
        }
     }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
      } 
        // If the proof hasn't finished
        return proof;
    }
    
    /**
     * This function will only be correct if called when using Strengthening method
     * This function will return a new prove tree in case it finds out that the last infer of prove
     * caused the whole prove to be correct under Strengthening method. In other case it will return 
     * the proof given as argument.
     * 
     * Do the last equanimity and symmetry of => steps to finish a Strengthening proof
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
        // me parece que si la app obliga a empezar de la izquierda, este else es imposible
        else if ( ((App)((App)teoremProved).p).p.toStringFinal().equals("c_{2}") ) {
            if (wsFirstOpInferIndex(proof)!=0 && isInverseImpl(expr,teoremProved) ) {
                TypedA ax = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)expr).q+", "+((App)((App)expr).p).q+"]"));
                return new TypedApp(new TypedApp(inst,ax),proof);
            }
            if(wsFirstOpInferIndex(proof)!=0 && isInverseImpl(((App)((App)expr).p).q,teoremProved) ) {
                TypedA ax = new TypedA(CombUtilities.getTerm("c_{1} (c_{2} x_{112} x_{113}) (c_{3} x_{113} x_{112})") );
                TypedI inst = new TypedI((Sust)CombUtilities.getTerm("[x_{112}, x_{113} := "+((App)((App)((App)expr).p).q).q+", "+((App)((App)((App)((App)expr).p).q).p).q+"]"));
                return new TypedApp(new TypedApp(inst,ax),new TypedApp(proof,new TypedA(new Const("c_{8}"))));
            }
        }
      }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
      } 
        // If the proof hasn't finished
        return proof;
    }    
    
    /**
     * This function will only be correct if called when using Counter-Reciprocal method
     * This function will return a new prove tree in case it finds out that the last infer of prove
     * caused the whole prove to be correct under the sub proof method. In other case it will return 
     * the proof given as argument.
     * 
     * Do the last step using axiom p => q == !q => !p to finish the Counter-Reciprocal proof
     * @param teoremProved: The theorem that user is trying to prove 
     * @param proof: The proof tree so far
     * @return proof of theoremProved if finished, else return the same proof
     */
    private Term finishedCounterRecProve(Term teoremProved, Term proof) {
       try {
         String str = "c_{1} (c_{2} (c_{7} x_{112}) (c_{7} x_{113})) (c_{2} x_{113} x_{112})";
         Term st = CombUtilities.getTerm(str);
         List<Var> vars = new ArrayList<Var>();
         List<Term> terms = new ArrayList<Term>();
         vars.add(0, new Var(112));
         vars.add(0, new Var(113));
         terms.add(0, ((App)teoremProved).q);
         terms.add(0, ((App)((App)teoremProved).p).q);
         Sust sus = new Sust(vars, terms);
         TypedA A = new TypedA(st);
         TypedI I = new TypedI(sus);
         return new TypedApp(new TypedApp(new TypedS(),new TypedApp(I,A)),proof);
             
       }catch (TypeVerificationException e)  {
          Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
       }
       
       return proof;
    }
    
    /**
     * This function will only be correct if called when using Counter-Reciprocal method
     * This function will return a new prove tree in case it finds out that the last infer of prove
     * caused the whole prove to be correct under the sub proof method. In other case it will return 
     * the proof given as argument.
     * 
     * Do the last step using axiom p => q == !q => !p to finish the Counter-Reciprocal proof
     * @param teoremProved: The theorem that user is trying to prove 
     * @param proof: The proof tree so far
     * @return proof of theoremProved if finished, else return the same proof
     */
    private Term finishedContradictionProve(Term teoremProved, Term proof) {
        try {
            // This string says: ¬p => false == ¬(¬p)
            String str1 = "c_{1} (c_{7} (c_{7} x_{112})) (c_{2} c_{9} (c_{7} x_{112}))";
            Term st1 = CombUtilities.getTerm(str1);

            // This string says: ¬(¬p) == p
            String str2 = "c_{1} x_{112} (c_{7} (c_{7} x_{112}))";
            Term st2 = CombUtilities.getTerm(str2);

            // The next two lists are for doing a parallel substitution [x1, x2,... := t1, t2, ...]
            List<Var> vars = new ArrayList<Var>();    
            List<Term> terms = new ArrayList<Term>();

            // In this case the substitution only needs one variable to be assigned [x112 := teoremProved]
            vars.add(0, new Var(112));   
            terms.add(0, teoremProved);

            // Here is where the substitution is applied
            Sust sus = new Sust(vars, terms);

            // We make the two formulas at the beginning to be treated as axioms
            TypedA A1 = new TypedA(st1);
            TypedA A2 = new TypedA(st2);

            // We give the instantiation format to the substitution above
            TypedI I = new TypedI(sus);

            return new TypedApp(new TypedApp(new TypedApp(I,A1),new TypedApp(I,A2)),proof); 
                     
        }catch (TypeVerificationException e)  {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e); 
        }
        return proof;
    }
    
    /**
     * This function will only be correct if called when using And Introduction method
     * This function will return a new prove tree that connect in one proof of P/\Q, 
     * two independent sub proofs of P and Q.
     * 
     * @param originalTerm: The current proof  
     * @param finalProof: The proof of second sub proof
     * @return proof of conjunction of two sub proofs
     */
    public static Term finishedAI2Proof(Term originalTerm, Term finalProof) {
        Map<String,String> values = new HashMap<String, String>();
        values.put("T1",finalProof.toStringFinal());
        String aux = finalProof.toStringFinal();
        values.put("T1Type", finalProof.type().toStringFinal());
        StrSubstitutor sub = new StrSubstitutor(values, "%(",")");
        String metaTheo = "S (I^{[x_{113} := %(T1Type)]} A^{c_{1} x_{113} (c_{1} x_{113} c_{8})}) (%(T1))";
        String theo = sub.replace(metaTheo);
        Term theoTerm = CombUtilities.getTerm(theo);
        Term firstProof = ((App)originalTerm).q;
        Term firstStAndTrue = ((App)((App)originalTerm).p).p;
        Term leibniz = ((App)((App)((App)originalTerm).p).q).p;
        try {
          Term newProof = new TypedApp(new TypedApp(firstStAndTrue,new TypedApp(leibniz,theoTerm)),firstProof);
          return newProof;
        }
        catch (TypeVerificationException e) {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
            return originalTerm;
        }
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
    private Term finishedDeductionOneSideProve(Term initialExpr, Term finalExpr, Term teoremProved, 
                                               Term proof) {
        
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
     * @param teoremProved: The theorem the user is trying to prove
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
            List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminResuelto(username);
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
     * In case the elements don't make sense it will return null
     * @param teorem: theorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents Leibniz on the hint
     * @param leibnizString: string that was used to parse Leibniz
     * @return a hint for the direct method
     */
    private Term createDirectMethodInfer(Term teorem, ArrayList<Object> instantiation, 
                                         String instantiationString, Bracket leibniz, String leibnizString ) 
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
     * In case the elements don't make sense it will return null
     * @param teorem: theorem used on the hint
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
    
    /**
     * This function will create one step infer for the weakening method given the inference's elements
     * In case the elements don't make sense it will return null
     * @param teorem: theorem used on the infer
     * @param instantiation: instantiation used on the statement in the form of arrays of variables 
     *                       and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents the Leibniz function on the inference step
     * @param leibnizString: string that was used to parse the Leibniz function
     * @return a hint for the weakening method
     */
    private Term createWSInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, 
                               Bracket leibniz, String leibnizString) throws TypeVerificationException {
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
     * In case the elements don't make sense it will return null
     * @param teorem: theorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents Leibniz on the hint
     * @param leibnizString: string that was used to parse Leibniz
     * @param teoremProved: theorem that we are proving using this hint
     * @return a hint for the natural deduction one side method
     */
    private Term createDeductionOneSideInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString, Term teoremProved) 
                 throws TypeVerificationException
    {

//      try {
        
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
        Term iaLefTerm = CombUtilities.getTerm(iaLeftString);
        
        //throw new TypeVerificationException();
        return new TypedApp(iaLefTerm, iaRighTerm);
        
        
        /*}catch(Exception e) { // If something goes wrong return null
            e.printStackTrace();
            return null;
        }*/

    }
    
    /**
     * This function will create a hint for the natural deduction with direct method given the hint's elements
     * In case the elements don't make sense it will return null
     * @param teorem: theorem used on the hint
     * @param instantiation: instantiation used on the hint in the form of arrays of variables and terms
     * @param instantiationString: string that was used to parse instantiation
     * @param leibniz: bracket that represents Leibniz on the hint
     * @param leibnizString: string that was used to parse Leibniz
     * @param teoremProved: theorem that we are proving using this hint
     * @return a hint for the natural deduction with direct method
     */
    private Term createDeductionDirectInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString, Term teoremProved) 
                 throws TypeVerificationException
    {

//      try {
        
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
        Term iaLefTerm = CombUtilities.getTerm(iaLeftString);
        
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
     * @param teo: theorem to be turned into teo == true
     * @return new Theorem for the given template meta theorem, null if the argument isn't valid
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
     * This method will return the typedTerm that represents the metaTheorem true == teo. 
     * This method use the proof of teo instead the statement of teo.
     * 
     * @param proof: proof of theorem teo to be turned into true == teo 
     * @return new theorem for the given meta theorem template, null if the argument isn't valid
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
    
    /**
     * This method return a derivation tree of the form: 
     *
     *     Gamma |- (x op y) == (!x op' !y)
     *     -------------------------------- I [x,y:=p,q]
     *     Gamma |- (p op q) == (!p op' !q)
     * 
     * where op' is ==> when op is <== and op' is <== when op is ==>
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @return typed term that represent the derivation tree before
     */
    private Term neg(Term p, Term q, Const op) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String neg = "I^{[x_{112}, x_{113} := "+P+", "+Q+"]}A^{c_{1} ("+op2+" (c_{7} x_{113}) (c_{7} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(neg);
    }
    
    /**
     * This method return a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((x op1 z) op (y op1 z))
     *     ---------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((p op1 r) op (q op1 r))
     * 
     * where op' is ==> when op is <== and op' is <== when op is ==> 
     * and op1 can be /\, \/, or <==
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @param op1: Constant that can be /\, \/, or <==
     * @return typed term that represent the derivation tree before
     */
    private Term wsl1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsl1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{114} x_{113}) ("+op1+" x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsl1);
    }
    
    /**
     * This method return a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((x ==> z) op' (y ==> z))
     *     ---------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((p ==> r) op' (q ==> r))
     * 
     * where op' is ==> when op is <== and op' is <== when op is ==> 
     * and op1 can be /\, \/, or <==
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @return typed term that represent the derivation tree before
     */
    private Term wsl2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsl2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{2} x_{114} x_{113}) (c_{2} x_{114} x_{112})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsl2);
    }
    
    /**
     * This method return a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((z op1 x) op (z op1 y))
     *     ---------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((r op1 p) op (r op1 q))
     * 
     * where op is ==> or <== and op1 can be /\, \/, or ==>
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @param op1: Constant that can be /\, \/, or ==>
     * @return typed term that represent the derivation tree before
     */
    private Term wsr1(Term p, Term q, Const op, Term r, Const op1) {
        
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsr1 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op+" ("+op1+" x_{113} x_{114}) ("+op1+" x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsr1);
    }
    
    /**
     * This method return a derivation tree of the form: 
     *
     *     Gamma |- (x op y) ==> ((z <== x) op' (z <== y))
     *     ----------------------------------------------- I [x,y,z:=p,q,r]
     *     Gamma |- (p op q) ==> ((r <== p) op' (r <== q))
     * 
     * where where op' is ==> when op is <== and op' is <== when op is ==> 
     * 
     * @param p: formula to be substituted in the tree
     * @param q: formula to be substituted in the tree
     * @param op: Constant that can be ==> or <==
     * @param r: formula to be substituted in the tree
     * @return typed term that represent the derivation tree before
     */
    private Term wsr2(Term p, Term q, Const op, Term r) {
        
        String op2 = (op.getId() == 2?"c_{3}":"c_{2}");
        String P = p.toStringFinal();
        String Q = q.toStringFinal();
        String R = r.toStringFinal();
        String wsr2 = "I^{[x_{112}, x_{113}, x_{114} := "+P+", "+Q+", "+R+"]}A^{c_{2} ("+op2+" (c_{3} x_{113} x_{114}) (c_{3} x_{112} x_{114})) ("+op+" x_{113} x_{112})}";
        
        return CombUtilities.getTerm(wsr2);
    }
    
    /**
     * This method will return the typedTerm that represents the sub derivation
     * tree that infer de use on Leibniz in weakening/strengthening 
     * @param leibniz: Term that represent de Leibniz expression 
     * @param nabla: derivation with root P op Q. The root is to be use as argument 
     *             for Leibniz rule with op in {Rightarrow,Leftarrow}
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
     * return the index of the first inference that is not a 
     * equiv or = in a Transitivity method
     * 
     * @param typedTerm derivation tree that code a Transitivity proof
     * @return index of the first no =inference
     */
    public static int wsFirstOpInferIndex1(Term typedTerm) {
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
        if (firstOpInf != 0)
            firstOpInf = i+1-firstOpInf;
        return firstOpInf;
    }
    
    /**
     * return the index (counting in reverse) of the first inference that is not a 
     * equiv or = in a Transitivity method
     * 
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
    
    /**
     * This method construct a new derivation tree adding an one step infer to
     * a proof written with the weakening/strengthening method
     *  
     * @param proof: Term that represent a proof written with the weakening/strengthening method
     * @param infer: Term that represent one step infer
     * @return new TypedTerm that represent a new derivation tree that 
     *         add in the last line of proof the infer
     */
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
            return new TypedApp(new TypedApp(CombUtilities.getTerm(deriv), proof), infer);
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
            return new TypedApp(new TypedApp(CombUtilities.getTerm(deriv), proof), infer);
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
    
    /**
     * This method construct a new derivation tree adding an one step infer to
     * a proof with the transitivity inference rule
     *  
     * @param proof: Term that represent the current proof
     * @param infer: Term that represent the one step infer
     * @return new TypedTerm that represent a new derivation tree that 
     *         add in the last line of proof the infer
     */
    private Term addInferToProof(Term proof, Term infer) throws TypeVerificationException {
        return new TypedApp(proof, infer);
    }
    
    /**
     * This method return true if and only if method is an incomplete non atomic proof method
     *  
     * @param method: Term that represent the current state of the proof method
     * @return true if and only if method is waiting the selection of 
     * another proof method to start de proof
     */
    public static boolean isWaitingMethod(Term method) {
        
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
            return isWaitingMethod(((App)method).q);
        }
        else
            return true;
    }
    
    /**
     * This method add a proof method for currentMethod to get a new compose method. 
     * If currentMethod is of the form ...M1 (M2 (M3...Mn)), then the method return  
     * ...M1 (M2 (M3...(Mn newMethod))). If currentMethod is of the from 
     * ...AI (M2 (M3...Mn)) where (M2 (M3...Mn)) is not waiting method then the method 
     * return ...((AI (M2 (M3...Mn))) newMethod). If currentMethod is of the from 
     * ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...Nm)))) where (N1 (N2 (N3...Nm))) is 
     * waiting method, then the method return 
     * ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...(Nm newMethod)))))
     *  
     * @param currentMethod: Term that represent the current state of the proof method
     * @param newMethod: new no compose Method 
     * @return Term that represent a new proof method compose by currentMethod and newMethod.
     */
    private Term updateMethod(String currentMethod, String newMethod) {
        
        if (currentMethod.equals(""))
            return new Const(newMethod);
        else {
            Term methodTerm = ProofMethodUtilities.getTerm(currentMethod);
            Term t = methodTerm;
            Term aux = null;
            Term father = methodTerm;
            
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
    }
    
    /**
     * This method erase one basic proof method for currentMethod. 
     * If currentMethod is of the form ...M1 (M2 (M3...(Mn M))), then the method return  
     * ...M1 (M2 (M3...Mn)). If currentMethod is of the from 
     * ...(AI (M2 (M3...Mn)) M) then the method  return ...(AI (M2 (M3...Mn))). 
     * If currentMethod is of the from ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...(Nm M))))) is 
     * then the method return ...((AI (M2 (M3...Mn))) (N1 (N2 (N3...Nm))))
     *  
     * @param currentMethod: String that encode the current state of the proof method
     * @return Term that represent a new proof method exactly as currentMethod but without the 
     *         last proof method. If currentMethod encode an Atomic method return null.
     */
    private Term eraseMethod(String currentMethod) {
        // revisa en las llamadas a este metodo si se ahorra algo al recibir String 
        // en lugar de Term
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
    
    private Term currentMethod(Term method) {
        if (method instanceof App) {
            while (method instanceof App) {
                method = ((App)method).q;
            }
            return method;
        }
        else
            return method;
    }
    
    /**
     * Return true if and only if method is a base method, i.e. a method 
     * that can't compose with another proof method. The base methods are 
     * Direct Method, Starting From One Side Method, Transitivity Method, 
     * Weakening Method, Strengthening Method
     *  
     * @param method: Term that represent the current state of the proof method
     * @return true if and only if method is a base method.
     */
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
    
    /**
     * The statement that it's needed to prove change inside a sub proof. This method 
     * calculate the statement within all the sub proofs a return the one in the 
     * current sub proof
     *  
     * @param beginFormula: general statement to be proved, is the base to calculate 
     *                      al de sub statement in the sub proofs
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    public static Term initStatement(Term beginFormula, Term method) {
        if (method.toString().equals("AI")){
            return ((App)beginFormula).q;           
        }
        else if (method instanceof Const){
            return beginFormula;
        }
        else if ( ((App)method).p.toStringFinal().equals("CR") ) {
            Term antec = ((App)beginFormula).q;
            antec = new App(new Const(7 ,"c_{7}"), antec);
            Term consec = ((App)((App)beginFormula).p).q;
            consec = new App(new Const(7,"c_{7}"),consec);
            beginFormula = new App(new App(new Const(2,"c_{2}"),antec), consec);
            
            return initStatement(beginFormula, ((App)method).q);
        }
        else if ( ((App)method).p.toStringFinal().equals("CO") ) {
            beginFormula = new App(new App(new Const(2,"c_{2}"),new Const(9,"c_{9}")), new App(new Const(7,"c_{7}"),beginFormula));
            return initStatement(beginFormula, ((App)method).q);
        }
        // hay que poner else if para los otros metodos recursivos unarios
        else if ( ((App)method).p.toStringFinal().substring(0, 2).equals("AI") ) {
            if ( ((App)method).p instanceof Const ) {
               beginFormula = ((App)beginFormula).q;
               return initStatement(beginFormula, ((App)method).q);
            } else {
               beginFormula = ((App)((App)beginFormula).p).q;
               return initStatement(beginFormula, ((App)method).q); 
            }
        }
        // hay que poner else if para el metodo CA
        return null;
    }
   
    /**
     * This method add 'formula' in one line sub proof for the current sub proof in 
     * (typedTerm, method).
     *  
     * @param formula: first line to add for the current sub proof
     * @param typedTerm: term that represent the current proof
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return Term that represent the statement to be proved in the current sub proof.
     */
    private Term addFirstLineSubProof(Term formula, Term typedTerm, Term method) {
        Term auxMethod = method;
        while (auxMethod instanceof App) {
           if (isAIProof2Started(auxMethod) && isAIProof2Started(((App)auxMethod).q))
           {
             Term aux = addFirstLineSubProof(formula, ((App)((App)((App)((App)typedTerm).p).q).q).q, 
                                                                                    ((App)auxMethod).q);
             return finishedAI2Proof(typedTerm,aux);
           }
           // si la segunda prueba del AI es otro metodo que adentro tiene un AI, esto no funciona
           else if (isAIProof2Started(auxMethod)) 
           {
               Map<String,String> values1 = new HashMap<String, String>();
               values1.put("ST1",new App(new App(new Const(1,"c_{1}"),formula),formula).toStringFinal());
               String aux = typedTerm.toStringFinal();
               values1.put("ST2", formula.toStringFinal());
               StrSubstitutor sub1 = new StrSubstitutor(values1, "%(",")");
               String metaTheoT= "S (I^{[x_{113} := %(ST1)]} A^{c_{1} x_{113} (c_{1} x_{113} c_{8})}) (L^{\\lambda x_{122}.%(ST2)} A^{c_{1} x_{113} x_{113}})";
               String metaTheo = sub1.replace(metaTheoT);
               Map<String,String> values2 = new HashMap<String, String>();
               values2.put("MT", metaTheo);
               values2.put("T1Type", typedTerm.type().toStringFinal());
               aux = typedTerm.toStringFinal();
               values2.put("T1", (typedTerm instanceof Const?aux:"("+aux+")"));
               StrSubstitutor sub2 = new StrSubstitutor(values2, "%(",")");
               String template = "S (I^{[x_{112}:=%(T1Type)]} A^{c_{1} x_{112} (c_{5} c_{8} x_{112})}) (L^{\\lambda x_{122}. c_{5} x_{122} (%(T1Type))} (%(MT)) )";
               String proof = sub2.replace(template);
               Term proofTerm = null;
               try {
                  proofTerm = new TypedApp(CombUtilities.getTerm(proof),typedTerm);
               }
               catch (TypeVerificationException e) {
                  Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
               }
               return proofTerm;
           }
           else
               auxMethod = ((App)auxMethod).q;
        }
        return formula;
    }
    
    /**
     * True if and only if exists sub proof that is already started. This information 
     * can infer from only the method term.
     *  
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return True if and only if exists sub proof that is already started.
     */
    public static boolean isProofStarted(Term method) {
        Term aux = method;
        while (aux instanceof App) {
            if (((App)aux).p instanceof App)
                return true;
            else 
               aux = ((App)aux).q;
        }
        return aux instanceof Const && 
                       (((Const)aux).getCon().equals("DM") ||
                        ((Const)aux).getCon().equals("SS") ||   
                        ((Const)aux).getCon().equals("TR") ||
                        ((Const)aux).getCon().equals("WE") ||
                        ((Const)aux).getCon().equals("ST")
                       );
    }
    
    /**
     * True if and only if method is an And Introduction proof and in the second sub proof 
     * exists sub proof (can be the same second sub proof) that is already started.
     * 
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return True if and only if method is an And Introduction proof and in the second sub proof 
     * exists sub proof (can be the same second sub proof) that is already started.
     */
    public static boolean isAIProof2Started(Term method) {
        return method instanceof App && ((App)method).p instanceof App && 
               ((App)((App)method).p).p.toStringFinal().equals("AI") && 
               isProofStarted(((App)method).q);
    }
    
    /**
     * True if and only if the proof that represent typedTerm is an And Introduction 
     * proof with only one line in the second proof.
     *  
     * @param typedTerm: Term that represent the proof.
     * @return True if and only if the proof that represent typedTerm is an And Introduction 
     *         proof with only one line in the second proof.
     */
    public static boolean isAIOneLineProof(Term typedTerm) {
        return typedTerm instanceof App && ((App)typedTerm).p instanceof App &&
                                    ((App)((App)typedTerm).p).q instanceof App && 
                                   ((App)((App)((App)typedTerm).p).q).q instanceof App &&
                       ((App)((App)((App)((App)typedTerm).p).q).q).q instanceof App &&
                    ((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p instanceof TypedL &&
    !(((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t.occur(new Var(122)));
    }
    
    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof of the first And Introduction method searched in 
     * method parameter.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof
     * @return sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof of the first And Introduction method searched 
     *         in method parameter.
     */
    public static Term getSubProof(Term typedTerm, Term method) {
       return getSubProof(typedTerm, method, false);
    }
    
    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof if isRecursive parameter is true. If isRecursive 
     * is false this method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof of the first And Introduction method searched in 
     * method parameter.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof.
     * @param isRecursive: if the value is true, the search of the sub proof call this 
     *                     method recursively.
     * @return sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof. The deep of the sub proof depend on the 
     *         value of isRecursive
     */
    public static Term getSubProof(Term typedTerm, Term method, boolean isRecursive) {
        Term auxMethod = method;
        while (auxMethod instanceof App) {
          if (auxMethod instanceof App && ((App)auxMethod).p instanceof App && 
              ((App)((App)auxMethod).p).p.toStringFinal().equals("AI") && 
              !isAIProof2Started(auxMethod)
             )
             return null;
          else if (isAIProof2Started(auxMethod) && isAIOneLineProof(typedTerm))
             return ((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t;
          else if (isAIProof2Started(auxMethod) && !isAIOneLineProof(typedTerm)) 
          {
             if (isRecursive)
               return getSubProof(((App)((App)((App)((App)typedTerm).p).q).q).q,((App)auxMethod).q,true);
             else
               return ((App)((App)((App)((App)typedTerm).p).q).q).q;
          }
          else 
             auxMethod = ((App)auxMethod).q;
        }
        return typedTerm;
    }
    
    /**
     * This method return the sub Term of typedTerm that represent the derivation tree 
     * of only the current sub proof and the father tree of this subproof.
     *  
     * @param typedTerm: Term that represent all the current proof.
     * @param method: Term that represent the current state of the proof method. This
     *                term had the information about what is the current sub proof.
     * @return List with sub Term of typedTerm that represent the derivation tree 
     *         of only the current sub proof and the father of this sub proof.
     */
    public static List<Term> getFatherAndSubProof(Term typedTerm, Term method, List<Term> li) {
        Term auxMethod = method;
        while (auxMethod instanceof App) {
          if (auxMethod instanceof App && ((App)auxMethod).p instanceof App && 
              ((App)((App)auxMethod).p).p.toStringFinal().equals("AI") && 
              !isProofStarted(((App)auxMethod).q)
             )
          {
             li.add(0,typedTerm);
             return li;
          }
          else if (isAIProof2Started(auxMethod) && isAIOneLineProof(typedTerm)) {
             li.add(0, typedTerm);
             li.add(0,((Bracket)((TypedL)((App)((App)((App)((App)((App)typedTerm).p).q).q).q).p).type()).t);
             return li;
          }
          else if (isAIProof2Started(auxMethod) && !isAIOneLineProof(typedTerm)) 
          {
             li.add(0, typedTerm);
             return getFatherAndSubProof(((App)((App)((App)((App)typedTerm).p).q).q).q,((App)auxMethod).q,li);
          }
          else 
             auxMethod = ((App)auxMethod).q;
        }
        li.add(0, typedTerm);
        return li;
    }
    
    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the the proof, in latex format, after an one step inference. 
     *
     * @param nStatement: id used by user to identify the statement of the inference. It is an HTTP POST 
     *                    parameter encoded with JSON
     * @param leibniz: String with the description of Leibniz of the inference in format C. It is an 
     *                 HTTP POST parameter encoded with JSON
     * @param instanciacion: String with the description of the substitution of the inference in format C. 
     *                       It is an HTTP POST parameter encoded with JSON
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the URL also 
     * @return InferResponse Object with the the proof, in latex format, after an one step inference. 
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Inferir",headers="Accept=application/json", produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody InferResponse infer(@RequestParam(value="nStatement") String nStatement, 
                                             @RequestParam(value="leibniz") String leibniz , 
                                             @RequestParam(value="instanciacion") String instanciacion, 
                                             @PathVariable String username, @PathVariable String nTeo, 
                                             @PathVariable String nSol 
                                             /*, @RequestParam(value="teoremaInicial") String teoremaInicial, @RequestParam(value="nuevoMetodo") String nuevoMetodo */) 
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
                // Case when the user could only see the theorem but had not a Resuelve object associated to it
                if (resuelve == null) {
                    resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                }
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
                response.setErrorParser2("The statement doesn't exist");
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
            arr=TermUtilities.instanciate(instanciacion, predicadoid, predicadoManager, simboloManager);
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
            leibnizTerm =TermUtilities.lambda(leibniz, predicadoid, predicadoManager, simboloManager);
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
        
        Stack<Term> methodStk = new Stack<Term>();
        Stack<Term> fatherProofs = new Stack<Term>();
        Stack<Term> formulasToProof = new Stack<Term>();
        formulasToProof.push(formula);
        Term initSt = formula;

        while (!(methodTermIter instanceof Const)) {
            methodStk.push(((App)methodTermIter).p);
            initSt = initStatement(initSt,new App(((App)methodTermIter).p,new Const("DM")));
            formulasToProof.push(initSt);
            if (((App)methodTermIter).p instanceof App && 
                 ((App)((App)methodTermIter).p).p.toStringFinal().equals("AI")
               )
            {
              if (isAIProof2Started(methodTermIter)) {
                 fatherProofs.push(typedTerm);
                 typedTerm = getSubProof(typedTerm, methodTermIter);
              }
            }
            methodTermIter = ((App)methodTermIter).q;
        }
        Term teoremProved = formulasToProof.pop();
    
        // CREATE THE NEW INFERENCE DEPENDING ON THE PROVE TYPE
        Term infer = null;
        String strMethodTermIter = methodTermIter.toStringFinal();
        try 
        {
            if(strMethodTermIter.equals("DM")) {
                infer = createDirectMethodInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
            } else if (strMethodTermIter.equals("SS")) {
                infer = createOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
            } else if (strMethodTermIter.equals("WE") || 
                          strMethodTermIter.equals("ST") || 
                          strMethodTermIter.equals("TR")
                      ) {
                infer = createWSInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
            } else if (strMethodTermIter.equals("Natural Deduction,one-sided")) {
                infer = createDeductionOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
            } else if (strMethodTermIter.equals("Natural Deduction,direct")) {
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
        } catch(TypeVerificationException e) {
            response.generarHistorial(username,formula, nTeo,typedTerm,false,true, methodTerm,resuelveManager,disponeManager,simboloManager);
            return response;
        }

        // CREATE THE NEW PROOF TREE BY ADDING THE NEW INFER
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
                if (i == 1 && j == 0){
                    infer = new TypedApp(new TypedS(infer.type()), infer);
                }
                if (strMethodTermIter.equals("WE") || 
                    strMethodTermIter.equals("ST") ||
                    strMethodTermIter.equals("TR")    
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
                    response.generarHistorial(username,formula, nTeo,typedTerm,false,true, methodTerm,resuelveManager,disponeManager,simboloManager);
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
        
        response.setResuelto("0");
             
        Term expr = newProof.type();
        Term initialExpr = ((App)expr).q;
        Term finalExpr = ((App)((App)expr).p).q;
        
        // CHECK IF THE PROOF FINISHED
        Term finalProof = newProof;

        // Depending on the method we create a new proof if we finished
        switch (strMethodTermIter){
            case "DM":
                finalProof = finishedDirectMethodProve(teoremProved, newProof, username, nTeo);
                break;
            case "SS":
                finalProof = finishedOneSideProve(initialExpr, finalExpr, teoremProved, newProof);
                break;
            case "Natural Deduction,one-sided":
                finalProof = finishedDeductionOneSideProve(initialExpr, finalExpr, teoremProved, newProof);
                break;
            case "Natural Deduction,direct":
                finalProof = finishedDeductionDirectProve(initialExpr, teoremProved, finalExpr, newProof, username); 
                break;
            case "WE":
                finalProof = finishedWeakProve(expr, teoremProved, newProof);
                break;
            case "ST":
                finalProof = finishedStrengProve(expr, teoremProved, newProof);
                break;
            case "TR":
                finalProof = finishedTransProve(expr, teoremProved, newProof);
                break;
            default: 
                break;
        }   
        
        /* Jean
        newProof = finishedDeductionDirectProve(teoremProved, proof, username);
        */
        
        // Get the complete method in case it was not atomic

        Boolean isFinalSolution = teoremProved.equals(finalProof.type());
        while (!methodStk.isEmpty())
        {
            Term methodTermAux = methodStk.pop();
            if (isFinalSolution && methodTermAux instanceof Const) {
                switch (methodTermAux.toStringFinal()){
                    case "CR":
                        finalProof = finishedCounterRecProve(formulasToProof.pop(), finalProof);
                        break;
                    case "CO":
                        finalProof = finishedContradictionProve(formulasToProof.pop(), finalProof);
                        break;
                    case "AI":
                       isFinalSolution = false;
                       response.setEndCase(true);
                }
            }
            // This ensures that after each one-step inference the tree for the second proof is updated
            if (methodTermAux instanceof App && ((App)methodTermAux).p.toStringFinal().equals("AI")) {
                finalProof = finishedAI2Proof(fatherProofs.pop(), finalProof);
            }
        }

        // newProve might or might not be different than pasoPostTerm
        
        // UPDATE SOLUCION 
        solucion.setTypedTerm(finalProof);
        
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
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the the proof, in latex format, without the last line. If delete the last 
     * line implies that you must select a new proof method, the InferResponse has the select 
     * method attribute on.
     *
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the url also 
     * @return InferResponse Object with the the proof, in latex format, without the last line. If delete the last 
     * line implies that you must select a new proof method, the InferResponse has the select 
     * method attribute on. 
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Retroceder",produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse retroceder( /*@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion,*/ 
                                                  @PathVariable String username, 
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
            method = (solucion.getMetodo().equals("")?null:ProofMethodUtilities.getTerm(solucion.getMetodo()));
            Term currentMethod = currentMethod(method);
            boolean isWaitingMethod = !isBaseMethod(currentMethod);
            if (!solucion.getMetodo().equals("") && isWaitingMethod)
            /*if (solucion.getDemostracion().equals("") && !solucion.getMetodo().equals("")) */
                respRetroceder = 0;
            else {
                respRetroceder = solucion.retrocederPaso(method,currentMethod.toStringFinal());
            }
            if (respRetroceder == 0) {
               method = eraseMethod(solucion.getMetodo());
               solucion.setMetodo((method == null?"":method.toStringFinal()));
            }
            //else
              // method = ProofMethodUtilities.getTerm(solucion.getMetodo());
            
            solucionManager.updateSolucion(solucion);
        }
        
        //List<PasoInferencia> inferencias = solucion.getArregloInferencias();
        Term formula = resuelve.getTeorema().getTeoTerm();

        response.generarHistorial(
               username,
               formula, 
               nTeo, 
               nSol.equals("new")?null:solucion.getTypedTerm(), 
               true, 
               true, 
               method,
               resuelveManager, 
               disponeManager, 
               simboloManager);
        
        // estos set se pudieran calcular dentro de generar historial
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
        
    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, in witch the statement of the last sub proof is 
     * is clickeable
     *
     * @param username: login of the user that make the request. It is in the url also
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the url also
     * @param nTeo: code of statement that the user is proving. It is in the url also
     * @return Return an InferResponse Object with the proof, in latex format, in witch the 
     *         statement of the last sub proof is clickeable
     */
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
        Term typedTerm = null;
        if (!nSol.equals("new"))
        {
            // Obtains the solution from DB.
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            typedTerm = solucion.getTypedTerm();
            String method = solucion.getMetodo();
            if (!method.equals(""))
               metodoTerm = ProofMethodUtilities.getTerm(method);
        }

        response.generarHistorial(
            username, 
            term,
            "",
            nTeo, 
            typedTerm, 
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
    
    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, in witch the statement of the last sub proof is 
     * an equality (or equivalence) with both sides (left and right) clickeable 
     *
     * @param username: login of the user that make the request. It is in the url also
     * @param nTeo: code of statement that the user is proving. It is in the url also
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the url also
     * @return Return an InferResponse Object with the proof, in latex format, in witch the 
     *         statement of the last sub proof is an equality (or equivalence) with both 
     *         sides (left and right) clickeable
     */
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
    
    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, with only the statement selected for the 
     * user in the first line of the current sub proof.
     *
     * @param teoid: ID of theorem that user select to start the Direct Method proof. It is a 
     *               HTTP POST parameter encode with JSON
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the url also
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also 
     * @return InferResponse Object with the the proof, in latex format, with only the statement 
     *         selected for the user in the first line of the current sub proof.
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialMD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialMD(@RequestParam(value="teoid") String teoid, 
                                                        @PathVariable String nSol, 
                                                        @PathVariable String username, 
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
            if (resuelve == null){
                resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",teoid.substring(3,teoid.length()));
            }
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
        Term typedTerm = null;
        if (nSol.equals("new"))
        {
            typedTerm = formulaTerm;
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
            
            metodoTerm = updateMethod(method, nuevoMetodo);
            if (teoid.substring(3,teoid.length()).equals(nTeo)) {
               formulaTerm = initStatement(formulaTerm, metodoTerm);
               typedTerm = addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
               solucion.setTypedTerm(typedTerm);
            } else {
               typedTerm = addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
               solucion.setTypedTerm(typedTerm);
            }
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            typedTerm,
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

    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, with only the expression selected (right or left 
     * side of the equation) for the user in the first line of the current sub proof.
     *
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the URL also
     * @param lado: String that encode the side of the equation selected for the user. It is a 
     *              HTTP POST parameter encode with JSON
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also 
     * @return InferResponse Object with the the proof, in latex format, with only the expression 
     *         selected (right or left side of the equation) for the user in the first line of the 
     *         current sub proof.
     */
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
        Term typedTerm = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null, nuevoMetodo);
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
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else {
            typedTerm = addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
            solucion.setTypedTerm(typedTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            typedTerm,
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
    
    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, with only the antecedent of the current statement 
     * in the first line of the current sub proof.
     *
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the URL also
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also 
     * @return InferResponse Object with the the proof, in latex format, with only the antecedent 
     *         of the current statement in the first line of the current sub proof.
     */
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
        Term typedTerm = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null, nuevoMetodo);
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = updateMethod(method, nuevoMetodo);
            formulaTerm = initStatement(formulaTerm, metodoTerm);
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
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            typedTerm = addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
            solucion.setTypedTerm(typedTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        solucionManager.addSolucion(solucion);
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            typedTerm,
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
    
    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, with only the consequent of the current statement 
     * in the first line of the current sub proof.
     *
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the URL also
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also 
     * @return InferResponse Object with the the proof, in latex format, with only the consequent 
     *         of the current statement in the first line of the current sub proof.
     */
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
        Term typedTerm = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null,nuevoMetodo);
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = updateMethod(method, nuevoMetodo);
            formulaTerm = initStatement(formulaTerm, metodoTerm);
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
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            typedTerm = addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
            solucion.setTypedTerm(typedTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        solucionManager.addSolucion(solucion);
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            typedTerm,
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

    /**
     * Controller that respond to HTTP POST request encoded with JSON. Return an InferResponse
     * Object with the proof, in latex format, with only the antecedent of the current statement 
     * in the first line of the current sub proof.
     *
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the URL also
     * @param username: login of the user that make the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also 
     * @return InferResponse Object with the the proof, in latex format, with only the antecedent 
     *         of the current statement in the first line of the current sub proof.
     */
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
        Term typedTerm = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null,nuevoMetodo);
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
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            typedTerm = addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
            solucion.setTypedTerm(typedTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(
            username,
            formulaAnterior, 
            nTeo,
            typedTerm,
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
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatementCO", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniStatementCO(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        String nuevoMetodo = "CO";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);

        // It is the theorem statement but parsed as a binary tree. 
        // We call it as "previous" because it will change when the proof starts: ¬Statement => False
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm(); 
        
        // Despite the new method is "CO", maybe it is nested into a previous one.
        Term metodoTerm = null;
        Solucion solucion = null;

        if (nSol.equals("new"))
        {
            metodoTerm = new Const(nuevoMetodo);

            // The arguments are: 1) associated Resuelve object, 2) if it is solved, 3) binary tree of the proof, and 4) demonstration method
            solucion = new Solucion(resuelve,false,null, nuevoMetodo);

            // Here is where we add a new row to the "solucion" table
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+""); // The concatenation with "" converts the id to a string
        }
        else
        {   
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = updateMethod(solucion.getMetodo(), nuevoMetodo);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,solucion.getTypedTerm(),true,false,metodoTerm,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */

        // It is "2" because we need the button "Go back" to appear in case we no longer want to use this demonstration method.
        response.setCambiarMetodo("2");

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatementCR", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniStatementCR(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        String nuevoMetodo = "CR";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Term metodoTerm = null;
        Solucion solucion = null;
        try {
          if (nSol.equals("new"))
          {
            // Determines if the prove can by made bu counter-reciprocal method
            if (((Const)((App)((App)formulaAnterior).p).p).getId() != 2) {
               response.setLado("0");
               return response;
            }
            metodoTerm = new Const(nuevoMetodo);
            solucion = new Solucion(resuelve,false,null, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
          }
          else
          {   
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = updateMethod(solucion.getMetodo(), nuevoMetodo);
            if (((Const)((App)((App)initStatement(formulaAnterior, metodoTerm)).p).p).getId() != 2) {
               response.setLado("0");
               return response;
            }
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
          }
        }catch (ClassCastException e) {
            response.setLado("0");
            return response;
        }
        response.generarHistorial(username,formulaAnterior, nTeo,solucion.getTypedTerm(),true,false,metodoTerm,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */
        response.setCambiarMetodo("2");

        return response;
    }
    
    /**
     * Init a proof for Conjunction by parts method.
     * @param nSol Number of the solution.
     * @param username Name of the user that is making the proof.
     * @param nTeo Number of theorem to be proved.
     * @return
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniAndI", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniAndI(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {
        // revisa la recursion de este metodo si no hace falta un initStatement o getSubProof
        String nuevoMetodo = "AI";
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        try {
            //String formula = "";
            if (((Const)((App)((App)formulaAnterior).p).p).getId() != 5) {
               response.setLado("0");
               return response;
            }
        } catch (ClassCastException e) {
            response.setLado("0");
            return response;
        }
        
        Term metodoTerm = null;
        Term typedTerm = null;
        
        if (nSol.equals("new"))
        {
            metodoTerm = new Const(nuevoMetodo);
            Solucion solucion = new Solucion(resuelve,false,null, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = updateMethod(solucion.getMetodo(), nuevoMetodo);
            nuevoMetodo = metodoTerm.toStringFinal();
            typedTerm = solucion.getTypedTerm();
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,typedTerm,true,false,metodoTerm,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */
        response.setCambiarMetodo("2");

        return response;
/*        
        // Mnuel y Juan
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
*/
    }

    public void setUsuarioManager(UsuarioManager usuarioManager) 
    {
        this.usuarioManager = usuarioManager;
    }
    
/*    public void setTerminoManager(TerminoManager terminoManager) 
    {
        this.terminoManager = terminoManager;
    }
*/
}