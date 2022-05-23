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
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.parse.TermUtilities;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SolucionManager;
import com.calclogic.service.UsuarioManager;
import com.calclogic.service.CategoriaManager;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.MetateoremaManager;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.MostrarCategoriaManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.proof.FinishedProofMethod;
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.ProofBoolean;
import com.calclogic.proof.InferenceIndex;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;
import java.util.HashSet;
import javax.servlet.http.HttpSession;
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
    private FinishedProofMethod finiPMeth;
    @Autowired
    private CrudOperations crudOp;
    
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
        List <Categoria> showCategorias = new LinkedList<>();
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
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserOrAdminWithSolWithoutAxiom(username,nTeo); // Maybe: getAllResuelveByUserOrAdminResuelto
        for (Resuelve r: resuelves){
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
            InferResponse response = new InferResponse(crudOp);
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

            //Boolean hasInnerMethodSelected = !solucion.getMetodo().equals("");


            // If it is an And Introduction proof
            //if (solucion.getMetodo().startsWith("And Introduction(")) {
            // if (solucion.getMetodo().startsWith("AI")) {
            //     String[] methodAndPath = solucion.getMetodo().split("-");
            //     String[] methods = methodAndPath[0].substring(
            //                            17,
            //                            methodAndPath[0].length() - 1
            //                        ).split(";");
            //     String currentMethod;
            //     String path = methodAndPath[1];
    
            //     // TODO: we have to create a parser to identify the recursive
            //     // case.
            //     if (path.equals("p")) {
            //         currentMethod = methods[0];
            //     } else {
            //         currentMethod = methods[1];
            //     }

            //     // If no method has been selected, we should show the method 
            //     // selector 
            //     if (currentMethod.equals("null")) {
            //         hasInnerMethodSelected = false;
            //     }

            // }
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
        List <Categoria> showCategorias = new LinkedList<>();
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
        
            switch (tipoTeo) {
                case "ST":
                    Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                    // Case when the user could only see the theorem but had not a Resuelve object associated to it
                    if (resuelve == null) {
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                    }
                    statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
                    break;
                case "MT":
                    Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                    statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
                    break;
                default:
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
            response.setError("user doesn't exist");
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
            
            switch (tipoTeo) {
                case "ST":
                    Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                    // Case when the user could only see the theorem but had not a Resuelve object associated to it
                    if (resuelve == null) {
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                    }
                    statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
                    break;
                case "MT":
                    Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                    statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
                    break;
                default:
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
            Term typedTerm = crudOp.getSubProof(solucion.getTypedTerm(),methodTerm,true);

            Term lastLine = typedTerm.type();
            if (lastLine == null)
                lastLine = typedTerm;
            else {
                metodo = crudOp.currentMethod(methodTerm).toStringFinal();
                if (metodo.equals("WE") || metodo.equals("ST") || metodo.equals("TR")) {
                    int index = InferenceIndex.wsFirstOpInferIndex(typedTerm);
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
        InferResponse response = new InferResponse(crudOp);
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
        
            switch (tipoTeo) {
                case "ST":
                    Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
                    // Case when the user could only see the theorem but had not a Resuelve object associated to it
                    if (resuelve == null) {
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",numeroTeo);
                    }
                    statementTerm = (resuelve!=null?resuelve.getTeorema().getTeoTerm():null);
                    break;
                case "MT":
                    Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
                    statementTerm = (dispone!=null?dispone.getMetateorema().getTeoTerm():null);
                    break;
                default:
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
        
        Stack<Term> methodStk = new Stack<>();
        Stack<Term> fatherProofs = new Stack<>();
        Stack<Term> formulasToProof = new Stack<>();
        formulasToProof.push(formula);
        Term initSt = formula;

        while (!(methodTermIter instanceof Const)) {
            methodStk.push(((App)methodTermIter).p);
            initSt = crudOp.initStatement(initSt,new App(((App)methodTermIter).p,new Const("DM")));
            formulasToProof.push(initSt);
            if (((App)methodTermIter).p instanceof App && 
                 ((App)((App)methodTermIter).p).p.toStringFinal().equals("AI")
               )
            {
              if (ProofBoolean.isAIProof2Started(methodTermIter)) {
                 fatherProofs.push(typedTerm);
                 typedTerm = crudOp.getSubProof(typedTerm, methodTermIter);
              }
            }
            methodTermIter = ((App)methodTermIter).q;
        }
        Term theoremBeingProved = formulasToProof.pop();
    
        // CREATE THE NEW INFERENCE DEPENDING ON THE PROOF TYPE
        Term infer = null;
        String strMethodTermIter = methodTermIter.toStringFinal();
        
        try {
            infer = crudOp.createBaseMethodInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm(), strMethodTermIter);
        } 
        catch(TypeVerificationException e) { // If something went wrong building the new hint
            response.generarHistorial(username,formula, nTeo,typedTerm,false,true, methodTerm,resuelveManager,disponeManager,simboloManager);
            return response;
        }

        // CREATE THE NEW PROOF TREE BY ADDING THE NEW INFER
        Term newProof =null;
        
        boolean onlyOneLine = ProofBoolean.isOneLineProof(typedTerm);
        Term currentProof;
        if (onlyOneLine){
            // If the proof only has one line so far, it may not be a boolean expression yet, because it could only 
            // be arithmetic, like 3 + 4. But since we always need it to be boolean, if the only line was P, we make 
            // the proof to be provisionally: P == P. Soon we will discard again the first P-
            currentProof = new TypedA(new App(new App(new Const(1,"c_{1}",false,1,1),typedTerm),typedTerm));
        }
        else{
            currentProof = typedTerm;
        }

        int i, j;
        i = 0;
        j = 0;
        while (newProof == null && i < 2) {
            try {
                if (i == 1 && j == 0){
                    infer = new TypedApp(new TypedS(infer.type()), infer);
                }
                // If proofCrudOperations.addInferToProof does not throw exception when typedTerm.type()==null, then the inference is valid respect of the first expression.
                // NOTE: The parameter "currentProof" changes with the application of this method, so this method cannot be omitted when "onlyOneLine" is true
                newProof = crudOp.addInferToProof(currentProof, infer, strMethodTermIter);
                if (onlyOneLine){
                    // If the proof only has one line with expression P for the user, then at this point it is interally P == P
                    // as explained previously. But since we don't need the first P and the new inference "infer" consists of 
                    // the three parts that will be shown to the user: 1) the previous expression P, 2) the hint and 3) the new expresssion,
                    // then we make the proof to be equal to that inference.
                    newProof = infer;
                }
            }
            catch (TypeVerificationException e) {
                if ((i == 1 && !onlyOneLine) || (i == 1 && j == 1)){
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
        
        // CHECK IF THE PROOF FINISHED
        Term finalProof = finiPMeth.finishedBaseMethodProof(theoremBeingProved, newProof, username, strMethodTermIter);
        
        /* Jean
        newProof = finishedDeductionDirectProve(theoremBeingProved, proof, username);
        */
        
        // Get the complete method in case it was not atomic
        Boolean isFinalSolution = theoremBeingProved.equals(finalProof.type());
        while (!methodStk.isEmpty())
        {
            Term methodTermAux = methodStk.pop();
            String strMethodTermAux = methodTermAux.toStringFinal();

            if (isFinalSolution && methodTermAux instanceof Const) {
                switch (strMethodTermAux){
                    case "CR":
                    case "CO":
                        finalProof = finiPMeth.finishedWaitingMethodProof(formulasToProof.pop(), finalProof, strMethodTermAux);
                        break;
                    case "CA":
                    case "AI":
                        isFinalSolution = false;
                        response.setEndCase(true);
                        break;
                    default:
                        break;
                }
            }
            String m=null;
            // This ensures that after each one-step inference the tree for the second proof is updated
            if (methodTermAux instanceof App && 
                    ( (m=((App)methodTermAux).p.toStringFinal()).equals("AI") || m.equals("CA") )
               )
               finalProof = finiPMeth.finishedAI2Proof(fatherProofs.pop(), finalProof);
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
        InferResponse response = new InferResponse(crudOp);

        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Solucion solucion = solucionManager.getSolucion(resuelve.getDemopendiente());
        int respRetroceder;
        Term method = null;
        
        if(nSol.equals("new")){
            respRetroceder = 0;
        }
        else{
            method = (solucion.getMetodo().equals("")?null:ProofMethodUtilities.getTerm(solucion.getMetodo()));
            Term currentMethod = crudOp.currentMethod(method);
            boolean isWaitingMethod = !ProofBoolean.isBaseMethod(currentMethod);
            if (!solucion.getMetodo().equals("") && isWaitingMethod)
            /*if (solucion.getDemostracion().equals("") && !solucion.getMetodo().equals("")) */
                respRetroceder = 0;
            else {
                respRetroceder = solucion.retrocederPaso(method,currentMethod.toStringFinal());
            }
            if (respRetroceder == 0) {
               method = crudOp.eraseMethod(solucion.getMetodo());
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
        InferResponse response = new InferResponse(crudOp);
      
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
        InferResponse response = new InferResponse(crudOp);
      
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
                               response.setErrorParser1(true);
                    return response;
                       }
                       term = ((App)((App)term).p).q;
               }
               equiv = ((Const)((App)((App)term).p).p).getCon();
        }catch (Exception e) {
               response.setErrorParser1(true);
            return response;
               }
        */

        /*if(!equiv.startsWith("c_{1}") && !equiv.startsWith("c_{20}")){ 
            response.setErrorParser1(true);                                    
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
        InferResponse response = new InferResponse(crudOp);

        // Jean response.setLado("1");
        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm();
        
        /*
        if(nuevoMetodo.equals("Natural Deduction,direct")) {
               
               // If not of the form H => Q its wrong
               if( !(formulaAnterior instanceof App && ((App)formulaAnterior).p instanceof App && ((App)((App)formulaAnterior).p).p.toString().equals("c_{2}"))){
                       response.setErrorParser1(true);
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
        if (teoid.substring(0, 3).equals("ST-")){
            Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,teoid.substring(3,teoid.length()));
            if (resuelve == null){
                resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",teoid.substring(3,teoid.length()));
            }
            //String formula = resuelve.getTeorema().getTeoTerm().toStringInfFinal();
            formulaTerm = resuelve.getTeorema().getTeoTerm();
            //formula = formulaTerm.toStringInfLabeled();
        }
        else if (teoid.substring(0, 3).equals("MT-")){
            Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, teoid.substring(3,teoid.length()));
            formulaTerm = dispone.getMetateorema().getTeoTerm();
            //formula = formulaTerm.toStringInfLabeled();
        }
        
        Term metodoTerm = null;
        Term typedTerm = null;
        if (nSol.equals("new")){
            typedTerm = formulaTerm;
            Solucion solucion = new Solucion(resuelveAnterior,false,formulaTerm, nuevoMetodo, 
                                             finiPMeth, crudOp);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
            metodoTerm = new Const(nuevoMetodo);
        }
        else{
            // Obtains the solution from DB.
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));     
            String method = solucion.getMetodo();
            
            metodoTerm = crudOp.updateMethod(method, nuevoMetodo);
            if (teoid.substring(3,teoid.length()).equals(nTeo)) {
               formulaTerm = crudOp.initStatement(formulaTerm, metodoTerm);
               typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
               solucion.setTypedTerm(typedTerm);
            } else {
               typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
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
        InferResponse response = new InferResponse(crudOp);
        
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
        if (nSol.equals("new")){
            solucion = new Solucion(resuelve,false,null, nuevoMetodo,finiPMeth, crudOp);
            metodoTerm = new Const(nuevoMetodo);
        }
        else{
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = crudOp.updateMethod(method, nuevoMetodo);
            formulaTerm = crudOp.initStatement(formulaTerm,metodoTerm);
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
            typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
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
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        //Teorema t = resuelve.getTeorema();
        //Term term = t.getTeoTerm();
        
        //String formula = "";
        Term formulaTerm = formulaAnterior;
        
        Term metodoTerm = null;
        Solucion solucion = null;
        Term typedTerm = null;
        if (nSol.equals("new")){
            solucion = new Solucion(resuelve,false,null, nuevoMetodo,finiPMeth, crudOp);
            metodoTerm = new Const(nuevoMetodo);
        }
        else{
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = crudOp.updateMethod(method, nuevoMetodo);
            formulaTerm = crudOp.initStatement(formulaTerm, metodoTerm);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
        }
        
        String operador = ((Const)((App)((App)formulaTerm).p).p).getCon();
        switch (operador) {
            case "c_{3}":
                response.setLado("d");
                formulaTerm = ((App)((App)formulaTerm).p).q;
                break;
            case "c_{2}":
                response.setLado("i");
                formulaTerm = ((App)formulaTerm).q;
                break;
            default:
                response.setErrorParser1(true);
                break;
        }
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
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
     * in the first line of the current sub proof when the strenghtening method is used
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
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        //String formula = "";
        Term formulaTerm = formulaAnterior;
        
        Term metodoTerm = null;
        Solucion solucion = null;
        Term typedTerm = null;
        if (nSol.equals("new")){
            solucion = new Solucion(resuelve,false,null,nuevoMetodo,finiPMeth, crudOp);
            metodoTerm = new Const(nuevoMetodo);
        }
        else{
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = crudOp.updateMethod(method, nuevoMetodo);
            formulaTerm = crudOp.initStatement(formulaTerm, metodoTerm);
            nuevoMetodo = metodoTerm.toStringFinal();
            solucion.setMetodo(nuevoMetodo);
        }
        
        String operador = ((Const)((App)((App)formulaTerm).p).p).getCon();
        switch (operador) {
            case "c_{3}":
                response.setLado("i");
                formulaTerm = ((App)formulaTerm).q;
                break;
            case "c_{2}":
                response.setLado("d");
                formulaTerm = ((App)((App)formulaTerm).p).q;
                break;
            default:
                response.setErrorParser1(true);
                break;
        }
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
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
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Term formulaTerm = formulaAnterior;
        
        Term metodoTerm = null;
        Solucion solucion = null;
        Term typedTerm = null;
        if (nSol.equals("new"))
        {
            solucion = new Solucion(resuelve,false,null,nuevoMetodo,finiPMeth, crudOp);
            metodoTerm = new Const(nuevoMetodo);
        }
        else
        {
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            String method = solucion.getMetodo();
            metodoTerm = crudOp.updateMethod(method, nuevoMetodo);
            formulaTerm = crudOp.initStatement(formulaTerm,metodoTerm);
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
            response.setErrorParser1(true);
        }
        
        if (nSol.equals("new")) {
            typedTerm = formulaTerm;
            solucion.setTypedTerm(formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), metodoTerm);
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
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);

        // It is the theorem statement but parsed as a binary tree. 
        // We call it as "previous" because it will change when the proof starts: ¬Statement => False
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm(); 
        
        // Despite the new method is "CO", maybe it is nested into a previous one.
        Term metodoTerm = null;
        Solucion solucion = null;

        if (nSol.equals("new")){
            metodoTerm = new Const(nuevoMetodo);

            // The arguments are: 1) associated Resuelve object, 2) if it is solved, 3) binary tree of the proof, and 4) demonstration method
            solucion = new Solucion(resuelve,false,null, nuevoMetodo,finiPMeth, crudOp);

            // Here is where we add a new row to the "solucion" table
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+""); // The concatenation with "" converts the id to a string
        }
        else{   
            solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = crudOp.updateMethod(solucion.getMetodo(), nuevoMetodo);
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
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Term metodoTerm = null;
        Solucion solucion = null;
        try {
            if (nSol.equals("new")){
                // Determines if the prove can by made bu counter-reciprocal method
                if (((Const)((App)((App)formulaAnterior).p).p).getId() != 2) {
                    response.setErrorParser1(true);
                    return response;
                }
                metodoTerm = new Const(nuevoMetodo);
                solucion = new Solucion(resuelve,false,null, nuevoMetodo,finiPMeth, crudOp);
                solucionManager.addSolucion(solucion);
                response.setnSol(solucion.getId()+"");
            }
            else {   
                solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
                metodoTerm = crudOp.updateMethod(solucion.getMetodo(), nuevoMetodo);
                if (((Const)((App)((App)crudOp.initStatement(formulaAnterior, metodoTerm)).p).p).getId() != 2) {
                   response.setErrorParser1(true);
                   return response;
                }
                nuevoMetodo = metodoTerm.toStringFinal();
                solucion.setMetodo(nuevoMetodo);
                solucionManager.updateSolucion(solucion);
            }
        } catch (ClassCastException e) {
            response.setErrorParser1(true);
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
     * Inits a proof for Conjunction by parts method.
     * @param nSol Number of the solution.
     * @param username Name of the user that is making the proof.
     * @param nTeo Number of theorem to be proved.
     * @return
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialAndIntroduction", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialAndIntroduction(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {
        // revisa la recursion de este metodo si no hace falta un initStatement o getSubProof
        String nuevoMetodo = "AI";
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        try {
            //String formula = "";
            if (((Const)((App)((App)formulaAnterior).p).p).getId() != 5) {
               response.setErrorParser1(true);
               return response;
            }
        } catch (ClassCastException e) {
            response.setErrorParser1(true);
            return response;
        }
        
        Term metodoTerm = null;
        Term typedTerm = null;
        
        if (nSol.equals("new")){
            metodoTerm = new Const(nuevoMetodo);
            Solucion solucion = new Solucion(resuelve,false,null, nuevoMetodo,finiPMeth, crudOp);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = crudOp.updateMethod(solucion.getMetodo(), nuevoMetodo);
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

    /**
     * Inits a proof for Case analysis method.
     * @param nSol Number of the solution.
     * @param username Name of the user that is making the proof.
     * @param nTeo Number of theorem to be proved.
     * @return
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatementCA", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse initCaseAnalysis(@PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {
        // revisa la recursion de este metodo si no hace falta un initStatement o getSubProof
        String nuevoMetodo = "CA";
        InferResponse response = new InferResponse(crudOp);
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Term metodoTerm = null;
        Term typedTerm = null;
        
        if (nSol.equals("new")){
            metodoTerm = new Const(nuevoMetodo);
            Solucion solucion = new Solucion(resuelve,false,null, nuevoMetodo,finiPMeth, crudOp);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        } else {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            metodoTerm = crudOp.updateMethod(solucion.getMetodo(), nuevoMetodo);
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
}