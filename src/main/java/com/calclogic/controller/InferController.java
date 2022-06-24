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
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.GenericProofMethod;
import com.calclogic.proof.ProofBoolean;
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
    private CrudOperations crudOp;
    
    /**
     * Controller that responds to HTTP GET request and returns the selection statement
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
     * Controller that responds to HTTP GET request. Returns the proof environment 
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
        else{
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
     * Controller that responds for HTTP POST request with JSON encoded parameters. The request is
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
        PredicadoId predicadoid = new PredicadoId();
        predicadoid.setLogin(username);
        
        Term statementTerm;
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
                    if (dispone == null){
                        dispone = disponeManager.getDisponeByUserAndTeoNum("AdminTeoremas", numeroTeo);
                    }
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
     * Controller that responds for HTTP POST request to set on/off the auto substitution 
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
        
        Term statementTerm;
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
                    if (dispone == null){
                        dispone = disponeManager.getDisponeByUserAndTeoNum("AdminTeoremas", numeroTeo);
                    }
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

            String method = solucion.getMetodo();
            Term methodTerm = ProofMethodUtilities.getTerm(method);
            Term typedTerm = crudOp.getSubProof(solucion.getTypedTerm(),methodTerm,true);

            Term lastLine = typedTerm.type();
            if (lastLine == null)
                lastLine = typedTerm;
            else {
                method = crudOp.currentMethod(methodTerm).toStringFinal();
                GenericProofMethod objectMethod = crudOp.createProofMethodObject(method);

                if (objectMethod.getGroupMethod().equals("T")){
                    int index = objectMethod.transFirstOpInferIndex(typedTerm,false);
                    if (index == 0 || index == 1)
                        lastLine = ((App)((App)typedTerm.type()).p).q;
                    else
                        lastLine = ((App)((App)((App)((App)typedTerm.type()).p).q).p).q;
                }
                else
                    lastLine = ((App)((App)lastLine).p).q;
            }

            Term leibnizTerm;
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
                //String[] sustVars = sust.getVars().toString().replaceAll("[\\s\\[\\]]", "").split(",");
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
     * Controller that responds to HTTP POST request encoded with JSON. Returns an InferResponse
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
        Term statementTerm;
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
                    if (dispone == null){
                        dispone = disponeManager.getDisponeByUserAndTeoNum("AdminTeoremas", numeroTeo);
                    }
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

        Resuelve resuel     = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Solucion solucion   = solucionManager.getSolucion(Integer.parseInt(nSol));
        Term typedTerm      = solucion.getTypedTerm();
        Term formula        = resuel.getTeorema().getTeoTerm();
        String metodo       = solucion.getMetodo();
        Term methodTerm     = ProofMethodUtilities.getTerm(metodo);
        Term methodTermIter = methodTerm;
        
        Stack<Term> methodStk       = new Stack<>();
        Stack<Term> fatherProofs    = new Stack<>();
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
                // THIS MUST BE CHANGED OR ELIMINATED. THIS ALSO APPLIES TO CASE ANALYSIS
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
        GenericProofMethod objectMethod = crudOp.createProofMethodObject(strMethodTermIter);
        
        try {
            infer = objectMethod.createBaseMethodInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
        } 
        catch(TypeVerificationException e) { // If something went wrong building the new step of the proof
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
                newProof = crudOp.addInferToProof(currentProof, infer, objectMethod);
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
                    response.generarHistorial(username,formula,nTeo,typedTerm,false,true,methodTerm,resuelveManager,disponeManager,simboloManager);
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

        // *************** Note: Try to include both cases (recursive and not recursive) in a single cycle.
        // For example, like pushing the non-recursive method to the stack **************************
        Term finalProof = newProof;

        if (!objectMethod.getIsRecursiveMethod()){
            finalProof = objectMethod.finishedBaseMethodProof(theoremBeingProved, newProof, username, resuelveManager, simboloManager);
        }
        
        // Get the complete method in case it was not atomic
        Boolean isFinalSolution = theoremBeingProved.equals(finalProof.type());
        while (!methodStk.isEmpty()){
            Term methodTermAux = methodStk.pop();
            String strMethodTermAux = methodTermAux.toStringFinal();
            objectMethod = crudOp.createProofMethodObject(strMethodTermAux);

            if (isFinalSolution && methodTermAux instanceof Const) {
                // Recursive and branched method
                if ("B".equals(objectMethod.getGroupMethod())) {
                    isFinalSolution = false;
                    response.setEndCase(true);   
                }
                // Recursive linear method
                else if (objectMethod.getIsRecursiveMethod()) {
                    finalProof = objectMethod.finishedLinearRecursiveMethodProof(formulasToProof.pop(), finalProof);
                }
                else{
                    break;
                }
            }

            // This part ensures that after each one-step inference the tree for the second proof is updated
            if (methodTermAux instanceof App){
                Term m = ((App)methodTermAux).p;
                if (m != null){
                    objectMethod = crudOp.createProofMethodObject(m.toStringFinal());
                    if ("B".equals(objectMethod.getGroupMethod())){
                        finalProof = objectMethod.finishedBranchedRecursiveMethodProof(fatherProofs.pop(), finalProof);
                    }
                }
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
     * Controller that responds to HTTP POST request encoded with JSON. Returns an InferResponse
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
            if (!solucion.getMetodo().equals("") && isWaitingMethod){
                /*if (solucion.getDemostracion().equals("") && !solucion.getMetodo().equals("")) */
                respRetroceder = 0;
            }
            else {
                String groupMethod = crudOp.createProofMethodObject(currentMethod.toStringFinal()).getGroupMethod();
                respRetroceder = solucion.retrocederPaso(method,groupMethod);
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
     * Controller that responds to HTTP POST request encoded with JSON. Returns an InferResponse
     * Object with the proof, in latex format, in which the statement of the last sub proof is 
     * clickable
     *
     * @param newMethod: Proof method that will be introduced in the proof.
     * @param username: Login of the user that make the request. It is in the url also.
     * @param nSol: Identifier of the solution of nTeo that the user is editing. It is in the url also.
     * @param nTeo: Code of statement that the user is proving. It is in the url also.
     * @return Returns an InferResponse object with the proof, in latex format, in which the 
     *         statement of the last sub proof is clickable.
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/clickableST", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse clickableSTController(
                                            @RequestParam(value="method") String newMethod,
                                            @PathVariable String username, 
                                            @PathVariable String nSol, 
                                            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse(crudOp);
    
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        
        Term methodTerm, typedTerm;
        methodTerm = typedTerm = null;

        if ("SS".equals(newMethod)){
            response.setLado("1");
        }

        // When the proof already exists in the DB, we obtain the solution from it.
        if (!nSol.equals("new")){       
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            
            String previousMethod = solucion.getMetodo();
            if (!previousMethod.equals(""))
                methodTerm = ProofMethodUtilities.getTerm(previousMethod);

            typedTerm = solucion.getTypedTerm();
        }

        response.generarHistorial(
            username, 
            term,
            "",
            nTeo, 
            typedTerm, 
            true, 
            false, 
            methodTerm, 
            resuelveManager, 
            disponeManager, 
            simboloManager, 
            newMethod,
            true
        );
        return response;
    }

    /**
     * Controller that responds to HTTP POST request encoded with JSON. Returns an InferResponse
     * Object with the proof, in latex format, with only the expression selected for the 
     * user (a complete statement or a side of the equation) in the first line of the current sub proof.
     *
     * @param teoid: Identifier of the theorem that the user selects to start the proof. It is a 
     *               HTTP POST parameter encode with JSON.
     * @param lado: String that encodes the side of the equation selected for the user. It is a 
     *              HTTP POST parameter encoded with JSON.
     * @param newMethod: Proof method that will be introduced in the proof.
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the url also.
     * @param username: login of the user that make the request. It is in the URL also.
     * @param nTeo: code of statement that the user is proving. It is in the URL also .
     * @return InferResponse Object with the the proof, in latex format, with only the statement 
     *         selected for the user in the first line of the current sub proof.
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatement", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniStatementController(
                                            @RequestParam(value="teoid") String teoid,
                                            @RequestParam(value="lado") String lado, 
                                            @RequestParam(value="method") String newMethod,
                                            @PathVariable String nSol, 
                                            @PathVariable String username, 
                                            @PathVariable String nTeo)
    {   
        GenericProofMethod objectMethod = crudOp.createProofMethodObject(newMethod);
        String groupMethod = objectMethod.getGroupMethod();
        boolean sideOrTransitive = ("SS".equals(newMethod) || "T".equals(groupMethod));

        InferResponse response = new InferResponse(crudOp);
        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);

        // This is the theorem statement but parsed as a binary tree. 
        // We call it as "previous" because it may change when the proof starts
        Term formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm();

        Solucion solucion = null;
        Term methodTerm, typedTerm;
        methodTerm = typedTerm = null;

        try{
            if ("AI".equals(newMethod) && (((Const)((App)((App)formulaAnterior).p).p).getId() != 5) ) {
                throw new ClassCastException("Error");
            }

            // ---- In this section we determine the value of "formulaTerm" -----
            Term formulaTerm = "T".equals(groupMethod) ? formulaAnterior : null;

            if ("DM".equals(newMethod)){
                if (teoid.substring(0, 3).equals("ST-")){
                    Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,teoid.substring(3,teoid.length()));
                    if (resuelve == null){
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",teoid.substring(3,teoid.length()));
                    }
                    formulaTerm = resuelve.getTeorema().getTeoTerm();
                }
                else if (teoid.substring(0, 3).equals("MT-")){
                    Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, teoid.substring(3,teoid.length()));
                    if (dispone == null){
                        dispone = disponeManager.getDisponeByUserAndTeoNum("AdminTeoremas", teoid.substring(3,teoid.length()));
                    }
                    formulaTerm = dispone.getMetateorema().getTeoTerm();
                }
            }
            else if ("SS".equals(newMethod)){
                formulaTerm = resuelveAnterior.getTeorema().getTeoTerm();
            }
            // ---- End of assigning "formulaTerm" 

            if (nSol.equals("new")){
                if ("CR".equals(newMethod) && (((Const)((App)((App)formulaAnterior).p).p).getId() != 2) ){
                    throw new ClassCastException("Error");
                }

                if (sideOrTransitive){
                    solucion = new Solucion(resuelveAnterior, false, null, newMethod, crudOp);
                }
                else{
                    // Arguments: 1) associated Resuelve object, 2) if it is solved, 3) binary tree of the proof, 4) demonstration method, 5) CrudOperations object
                    solucion = new Solucion(resuelveAnterior, false, formulaTerm, newMethod, crudOp);
                    typedTerm = formulaTerm;
                    solucionManager.addSolucion(solucion); // This adds a new row to the "solucion" table
                    response.setnSol(solucion.getId()+""); // The concatenation with "" converts the id to a string
                }

                methodTerm = new Const(newMethod);        
            }
            else{
                if ("CR".equals(newMethod) && 
                    (((Const)((App)((App)crudOp.initStatement(formulaAnterior, methodTerm)).p).p).getId() != 2)
                    )
                {
                    throw new ClassCastException("Error");
                }   

                // When the proof already exists in the DB, we obtain the solution from it.
                solucion = solucionManager.getSolucion(Integer.parseInt(nSol));     
                methodTerm = crudOp.updateMethod(solucion.getMetodo(), newMethod);

                // We save in the database the concatenation of the previous list of methods with the new one
                solucion.setMetodo(methodTerm.toStringFinal());

                if (sideOrTransitive){
                    formulaTerm = crudOp.initStatement(formulaTerm,methodTerm);
                }
                else{
                    if ("DM".equals(newMethod)){
                        if (teoid.substring(3,teoid.length()).equals(nTeo)) {
                           formulaTerm = crudOp.initStatement(formulaTerm, methodTerm);
                        }
                        typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), methodTerm);
                        solucion.setTypedTerm(typedTerm);
                    }
                    solucionManager.updateSolucion(solucion);       
                }

                // if ("AI".equals(newMethod) || "CA".equals(newMethod)){
                //     typedTerm = solucion.getTypedTerm();
                // }
            }

            if (sideOrTransitive){
                if (lado == null){ // This does not occur in Starting from one side method, so we are in a transitive one
                    String operator = ((Const)((App)((App)formulaTerm).p).p).getCon();

                    switch (operator){
                        case "c_{2}": // Right arrow
                            lado = "TR".equals(newMethod) ? null : ("WE".equals(newMethod) ? "i" : "d");
                            break;
                        case "c_{3}": // Left arrow
                            lado = "TR".equals(newMethod) ? null : ("WE".equals(newMethod) ? "d" : "i");
                            break;
                        default:
                            // **** For the "TR" method we should check first if the operator is transitive
                            // **** Also, why must we always start from the left side ?
                            lado = "TR".equals(newMethod) ? "i" : null;
                            break;
                    }
                }
                if (lado != null){ // THIS IS NOT AN ELSE, BECAUSE "lado" MAY HAVE CHANGED IN THE PREVIOUS BLOCK
                    response.setLado(lado);
                    formulaTerm = lado.equals("i") ? ((App)formulaTerm).q : ((App)((App)formulaTerm).p).q;  
                } 
                else {
                    throw new ClassCastException("Error");
                }

                if (nSol.equals("new")) {
                    typedTerm = formulaTerm;
                    solucion.setTypedTerm(formulaTerm);
                    solucionManager.addSolucion(solucion);
                    response.setnSol(solucion.getId()+"");
                }
                else {
                    typedTerm = crudOp.addFirstLineSubProof(formulaTerm, solucion.getTypedTerm(), methodTerm);
                    solucion.setTypedTerm(typedTerm);
                    solucionManager.updateSolucion(solucion);
                }       
            }

            // This occurs because the first line of the proof is printed inmediately after selecting the following methods
            if ("WE".equals(newMethod) || "ST".equals(newMethod)){
                solucionManager.addSolucion(solucion);
            }

        } catch (ClassCastException e) {
            response.setErrorParser1(true);
            return response;
        }
        
        response.generarHistorial(
            username, // user
            formulaAnterior, // formula
            nTeo, 
            typedTerm, // EN CO y CR, ponía solucion.getTypedTerm()
            true, // valida
            ! objectMethod.getIsRecursiveMethod(), // labeled
            methodTerm,
            resuelveManager,
            disponeManager,
            simboloManager 
        );

        // In the recursive case, the user still needs to choose another proof method for the sub-proof
        response.setCambiarMetodo(objectMethod.getIsRecursiveMethod() ? "2" : "0");

        return response;
    }
    
}