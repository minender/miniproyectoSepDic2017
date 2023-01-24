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
import com.calclogic.externalservices.MicroServices;
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.GenericProofMethod;
import com.calclogic.proof.ProofBoolean;
import com.calclogic.proof.MetaTheorem;
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
import org.json.simple.JSONObject;

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
     * @param username: login of the user that made the request. It's is in the URL also
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
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username,true);
        
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
        
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
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
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","100%");
        map.addAttribute("categorias",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));

        return "infer";
    }

    /**
     * Controller that responds to HTTP GET request. Returns the proof environment 
     * page of the statement (if there is a user session active). 
     * 
     * @param username: login of the user that made the request. It is in the URL also
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
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo,false);

        // Case when the user could only see the theorem but had not a Resuelve object associated to it
        if (resuel == null) {
            resuel = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",nTeo,false);
            Usuario user = usuarioManager.getUsuario(username);
            resuel.setUsuario(user);
            resuel.setDemopendiente(-1);
            resuel.setSolucions(new HashSet());
            resuel.setResuelto(false);
            resuel = resuelveManager.addResuelve(resuel);
        }
        TypedA A = new TypedA(resuel.getTeorema().getTeoTerm(),username);
        Term formula = A.type();
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSolWithoutAxiom(username,nTeo,true); // Maybe: getAllResuelveByUserResuelto

        // Usando algoritmo de punto fijo
        List<Resuelve> unResuelve = new ArrayList<Resuelve>();
        unResuelve.add(resuel);
        List<Resuelve> depend = resuelveManager.getResuelveDependent(username, unResuelve);
        HashSet<Integer> dependIds = new HashSet<Integer>();
        List<String> dependNum = new ArrayList<String>();
        for (Resuelve r: depend) {
            dependIds.add(r.getId());
            dependNum.add(r.getNumeroteorema());
        }
        resuelves.removeIf(r -> dependIds.contains(r.getId()));
        //resuelves.removeAll(depend);
        //resuelves = new ArrayList<Resuelve>();

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
            map.addAttribute("formula","Theorem "+nTeo+":<br> <center>$"+formula.toStringLaTeX(simboloManager,"")+"$</center> Proof:");
            map.addAttribute("elegirMetodo","1");
            map.addAttribute("teoInicial", "");
        }
        else{
            Solucion solucion = solucionManager.getSolucion(resuel.getDemopendiente(),username);
            infersForm.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula.toStringLaTeX(simboloManager,"")+"$</center> Proof:");  
            InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);
            Term typedTerm = solucion.getTypedTerm();

            response.generarHistorial(
                username,
                formula, 
                nTeo, 
                typedTerm, 
                true,
                (solucion.getMetodo().equals("") || 
                        ProofBoolean.isWaitingMethod(ProofMethodUtilities.getTerm(solucion.getMetodo()))?
                                false:true),
                (solucion.getMetodo().equals("")?null:ProofMethodUtilities.getTerm(solucion.getMetodo()))
            );
            map.addAttribute("elegirMetodo",response.getCambiarMetodo());
            map.addAttribute("formula",response.getHistorial());
        }

        List <Categoria> showCategorias = new LinkedList<>();
        List<MostrarCategoria> mostrarCategoria = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(usr);

        for (int i = 0; i < mostrarCategoria.size(); i++ ){
            showCategorias.add(mostrarCategoria.get(i).getCategoria());
        }
        
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(resuel.getTeoria().getId());
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
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("categorias",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));

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
        
        Term statementTerm = crudOp.findStatement(response, nStatement, username, resuelveManager, disponeManager);
        if (response.getError() != null){
            return response;
        }
       
        // CREATE THE INSTANTIATION
        ArrayList<Object> arr = null;
        if (!instanciacion.equals("")){
            arr=TermUtilities.instanciate(instanciacion, predicadoid, predicadoManager, simboloManager);
        }
        
        if (arr == null)
            response.setInstantiation(statementTerm.type().toStringLaTeX(simboloManager, ""));
        else {// (ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1)
            try {
            TypedI I = new TypedI(new Sust((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1)));
            response.setInstantiation(new TypedApp(I,statementTerm).type().toStringLaTeX(simboloManager, ""));
            }
            catch (TypeVerificationException e) {
                e.printStackTrace();
            }
        }
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
        
        Term statementTerm = crudOp.findStatement(response, nStatement, username, resuelveManager, disponeManager);
        statementTerm = statementTerm.type().setToPrint(simboloManager);
        if (response.getError() != null){
            return response;
        }

        // String freeV = statementTerm.freeVars();
        if (!freeV.equals("")) {
            String[] freeVars = freeV.split(",");
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol),username);

            String method = solucion.getMetodo();
            Term methodTerm = ProofMethodUtilities.getTerm(method);
            Term typedTerm = crudOp.getSubProof(solucion.getTypedTerm(),methodTerm,true);

            Term lastLine = typedTerm.type();
            
            if (lastLine == null)
                lastLine = typedTerm;
            else {
                method = crudOp.currentMethod(methodTerm).toString();
                GenericProofMethod objectMethod = crudOp.returnProofMethodObject(method);

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

            lastLine = lastLine.body();
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
                //String[] sustVars = sust.getVars().toString().replaceAll("[\\s\\[\\]]", "").split(",");
                String[] sustFormatC = new String[freeVars.length];
                String[] sustLatex = new String[freeVars.length];
                for (int i=0; i<freeVars.length; i++) {
                    int j = sust.getVars().indexOf(new Var(freeVars[i].toCharArray()[0]));
                    if (j != -1) {
                        sustFormatC[i] = sust.getTerms().get(j).toStringFormatC(simboloManager,"",0,"substitutionButtonsId."+freeVars[i]);
                        sustLatex[i] = sust.getTerms().get(j).toStringLaTeXWithInputs(simboloManager,"","substitutionButtonsId."+freeVars[i]);
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
     * @param username: login of the user that made the request. It is in the URL also
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
        InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);
        PredicadoId predicadoid = new PredicadoId();
        predicadoid.setLogin(username);

        Term statementTerm = crudOp.findStatement(response, nStatement, username, resuelveManager, disponeManager);
        if (response.getError() != null){
            return response;
        }

        // CREATE THE INSTANTIATION
        ArrayList<Object> arr = null;
        if (!instanciacion.equals("")){
            arr=TermUtilities.instanciate(instanciacion, predicadoid, predicadoManager, simboloManager);
        }

        // CREATE LEIBNIZ
        Term leibnizTerm = null;
        if (!leibniz.equals("")){
            leibnizTerm =TermUtilities.lambda(leibniz, predicadoid, predicadoManager, simboloManager);
            if ( ((Bracket)leibnizTerm).isIdFunction()) {
                leibnizTerm = null;
                leibniz = "";
            }
        }   

        Resuelve resuel     = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo,false);
        Solucion solucion   = solucionManager.getSolucion(Integer.parseInt(nSol),username);
        Term typedTerm      = solucion.getTypedTerm();
        Term formula        = resuel.getTeorema().getTeoTerm().evaluar(resuel.getVariables());//.setToPrinting(resuel.getVariables(),simboloManager);
        // CHECK formula pudiera ser una igualdad y pasar por equival trans usando arboles de derivacion
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

            if (
                  ((App)methodTermIter).p instanceof App &&
                  ("B".equals(crudOp.returnProofMethodObject( ((App)((App)methodTermIter).p).p.toString() ).getGroupMethod())) &&
                  (ProofBoolean.isBranchedProof2Started(methodTermIter))         
               )
            {
                fatherProofs.push(typedTerm);
                typedTerm = crudOp.getSubProof(typedTerm, methodTermIter);
            }
            methodTermIter = ((App)methodTermIter).q;
        }
        Term formulaBeingProved = formulasToProof.pop();
    
        // CREATE THE NEW INFERENCE DEPENDING ON THE PROOF TYPE
        Term infer;
        String strMethodTermIter = methodTermIter.toString();
        GenericProofMethod objectMethod = crudOp.returnProofMethodObject(strMethodTermIter);
        
        try {
            infer = objectMethod.createOneStepInfer(username,statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
        }
        catch(TypeVerificationException e) { // If something went wrong building the new step of the proof
            response.generarHistorial(username,formula, nTeo,typedTerm,false,true, methodTerm);
            return response;
        }

        // CREATE THE NEW PROOF TREE BY ADDING THE NEW INFER
        Term newProof =null;
        
        boolean isOnlyOneLine = ProofBoolean.isOneLineProof(typedTerm);
        Term currentProof;
        if (isOnlyOneLine){
            // If the proof only has one line so far, it may not be a boolean expression yet, because it could only 
            // be arithmetic, like 3 + 4. But since we always need it to be boolean, if the only line was P, we make 
            // the proof to be provisionally: P == P. Soon we will discard again the first P-
            currentProof = new TypedA(new App(new App(new Const(0,"="),typedTerm),typedTerm));
        }
        else{
            currentProof = typedTerm;
        }

        int i;//, j;
        i = 0;
        //j = 0;
        while (newProof == null && i < 2) {

            try {
                if (i == 1 /*&& j == 0*/){
                    infer = new TypedApp(new TypedS(), infer);
                }
                // If proofCrudOperations.addInferToProof does not throw exception when typedTerm.type()==null, then the inference is valid respect of the first expression.
                // NOTE: The parameter "currentProof" changes with the application of this method, so this method cannot be omitted when "onlyOneLine" is true
                newProof = crudOp.addInferToProof(username,currentProof, infer, objectMethod);
                if (isOnlyOneLine){
                    // If the proof only has one line with expression P for the user, then at this point it is interally P == P
                    // as explained previously. But since we don't need the first P and the new inference "infer" consists of 
                    // the three parts that will be shown to the user: 1) the previous expression P, 2) the hint and 3) the new expresssion,
                    // then we make the proof to be equal to that inference.
                    if (newProof instanceof TypedApp && ((TypedApp)newProof).inferType == 'e'){
                        newProof = null;
                        throw new TypeVerificationException();
                    }
                    newProof = infer;
                }
            }
            catch (TypeVerificationException e) {
                if (i==1/*(i == 1 && !onlyOneLine) || (i == 1 && j == 1)*/){
                    response.generarHistorial(username,formula, nTeo,typedTerm,false,true, methodTerm);
                    return response;
                }
                /*if (onlyOneLine && j == 0) {
                    currentProof = new TypedA(new App(new App(new Const(1,"c_{20}",false,1,1),
                            typedTerm),typedTerm));
                    j=1;
                }
                else if (onlyOneLine && j == 1) {
                    currentProof = new TypedA(new App(new App(new Const(1,"c_{1}",false,1,1),
                            typedTerm),typedTerm));
                    j=0;
                }*/
            }
            //i = (j == 1?i:i+1);
            i++;
        }       
        response.setResuelto("0");
        // CHECK IF THE PROOF FINISHED

        // *************** Note: Try to include both cases (recursive and not recursive) in a single cycle.
        // For example, like pushing the non-recursive method to the stack **************************
        Term finalProof = newProof;

        if (!objectMethod.getIsRecursiveMethod()){
            finalProof = objectMethod.finishedBaseMethodProof(formulaBeingProved, newProof, username, resuelveManager, simboloManager);
        }
        // Get the complete method in case it was not atomic
        Boolean isFinalSolution = formulaBeingProved.traducBD().equals(finalProof.type().traducBD());//.setToPrinting(resuel.getVariables(),simboloManager));
        // CHECK puede ser una igualdad y pasar por equivalencia, esto hay que transformarlo usando arboles de deriv

        // We need this because in branched recursive methods we use And Introduction structure anyway
        GenericProofMethod aiObject = crudOp.returnProofMethodObject("AI");

        while (!methodStk.isEmpty()){
            Term methodTermAux = methodStk.pop();
            String strMethodTermAux = methodTermAux.toString();
            objectMethod = crudOp.returnProofMethodObject(strMethodTermAux);

            if (isFinalSolution && methodTermAux instanceof Const) {
                // Recursive branched method
                if ("B".equals(objectMethod.getGroupMethod())) {
                    isFinalSolution = false;
                    response.setEndCase(true);   
                }
                // Recursive linear method
                else if (objectMethod.getIsRecursiveMethod()) {
                    finalProof = objectMethod.finishedLinearRecursiveMethodProof(username,formulasToProof.pop(), finalProof);
                }
                else{
                    break;
                }
            }

            // This part ensures that after each one-step inference the tree for the second proof is updated
            if (methodTermAux instanceof App){
                Term m = ((App)methodTermAux).p;
                String strM = m.toString();
                if (m != null){
                    objectMethod = crudOp.returnProofMethodObject(strM);
                    if ("B".equals(objectMethod.getGroupMethod())){
                        finalProof = aiObject.finishedBranchedRecursiveMethodProof(username,fatherProofs.pop(), finalProof);
                        if (isFinalSolution && !("AI".equals(strM))){
                            finalProof = objectMethod.finishedBranchedRecursiveMethodProof(username,null, finalProof);
                        }
                    }
                }
            }
        }
        
        // UPDATE SOLUCION 
        solucion.setTypedTerm(finalProof);
        
        // If finished mark solucion as solved
        if (isFinalSolution && formula.traducBD().equals(finalProof.type().traducBD())) {
            response.setResuelto("1");
            solucion.setResuelto(true);
            resuel.setResuelto(true);
            resuelveManager.updateResuelve(resuel);
        }

        response.generarHistorial(
            username,
            formula, 
            nTeo,
            finalProof,
            true,
            true,
            methodTerm
        );

        solucionManager.updateSolucion(solucion);
        
        return response;
    }

    /**
     * Controller that responds to HTTP POST request encoded with JSON. Returns an InferResponse
     * Object with the the proof, in latex format, without the last line. If delete the last 
     * line implies that you must select a new proof method, the InferResponse has the select 
     * method attribute on.
     *
     * @param username: login of the user that made the request. It is in the URL also
     * @param nTeo: code of statement that the user is proving. It is in the URL also
     * @param nSol: id of the solution of nTeo that the user is editing. It is in the url also 
     * @return InferResponse Object with the the proof, in latex format, without the last line. If delete the last 
     * line implies that you must select a new proof method, the InferResponse has the select 
     * method attribute on. 
     */
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Retroceder",produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse retroceder(@PathVariable String username, 
                                                  @PathVariable String nTeo, 
                                                  @PathVariable String nSol)
    {   
        InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);

        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo,false);
        Solucion solucion = solucionManager.getSolucion(resuelve.getDemopendiente(),username);
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
                respRetroceder = 0;
            }
            else {
                GenericProofMethod objectMethod = crudOp.returnProofMethodObject(currentMethod.toString());
                respRetroceder = solucion.retrocederPaso(username,method,objectMethod,simboloManager);
            }
            if (respRetroceder == 0) {
               method = crudOp.eraseMethod(solucion.getMetodo());
               solucion.setMetodo((method == null?"":method.toString()));
            }
            
            solucionManager.updateSolucion(solucion);
        }
        
        //List<PasoInferencia> inferencias = solucion.getArregloInferencias();
        Term formula = resuelve.getTeorema().getTeoTerm().evaluar(resuelve.getVariables());

        response.generarHistorial(
            username,
            formula, 
            nTeo, 
            nSol.equals("new")?null:solucion.getTypedTerm(), 
            true, 
            true, 
            method
        );
        
        // estos set se podrían calcular dentro de generar historial
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
     * @param username: Login of the user that made the request. It is in the url also.
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
        InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo,false);
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm().evaluar(resuelve.getVariables());
        Term methodTerm, typedTerm;
        methodTerm = typedTerm = null;

        if ("SS".equals(newMethod)){
            // if (((App)((App)term).p).q.containT()){
            //     response.setErrorParser1(true);
            //     return response;
            // }
            response.setLado("1");
        }
        term = new TypedA(term,username).type();

        // When the proof already exists in the DB, we obtain the solution from it.
        if (!nSol.equals("new")){       
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol),username);
            
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
            newMethod,
            true
        );
        return response;
    }

    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/iniStatement", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse iniStatementController(
                                            @RequestParam(value="teoid") String teoid,
                                            @RequestParam(value="lado") String lado, 
                                            @RequestParam(value="method") String newMethod,
                                            @PathVariable String nSol, 
                                            @PathVariable String username, 
                                            @PathVariable String nTeo)
    {
        GenericProofMethod objectMethod = crudOp.returnProofMethodObject(newMethod);
        Boolean isRecursive = objectMethod.getIsRecursiveMethod();
        String groupMethod = objectMethod.getGroupMethod();
        boolean sideOrTransitive = ("SS".equals(newMethod) || "T".equals(groupMethod));

        InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);

        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo,false);

        // This is the theorem statement but parsed as a binary tree. 
        // We call it as "previous" because it may change when the proof starts
        Term formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm().evaluar(resuelveAnterior.getVariables());//.setToPrinting(resuelveAnterior.getVariables(),simboloManager);

        Integer opId; // Id of the symbol of the main operator of an expression
        Solucion solucion = null;
        Term methodTerm, typedTerm;
        methodTerm = typedTerm = null;
        try{
            // ---- In this section we determine the value of "formulaTerm" -----
            Term formulaTerm = "T".equals(groupMethod) ? formulaAnterior : null;

            if ("DM".equals(newMethod)){
                if (teoid.substring(0, 3).equals("ST-")){
                    Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,teoid.substring(3,teoid.length()),false);
                    if (resuelve == null){
                        resuelve = resuelveManager.getResuelveByUserAndTeoNum("AdminTeoremas",teoid.substring(3,teoid.length()),false);
                    }
                    formulaTerm = resuelve.getTeorema().getTeoTerm().evaluar(resuelve.getVariables());//.setToPrinting(resuelve.getVariables(),simboloManager);
                    
                    /*if (nSol.equals("new") && !formulaTerm.containT()) {
                        solucion = new Solucion(resuelveAnterior, false, null, "D1", crudOp);
                        solucionManager.addSolucion(solucion);
                        nSol = solucion.getId()+"";
                    }*/
                        
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
                formulaTerm = resuelveAnterior.getTeorema().getTeoTerm().setToPrinting(resuelveAnterior.getVariables(),simboloManager);
            }
            // ---- End of assigning "formulaTerm" 

            if (nSol.equals("new")){
                System.out.println("El id del operador es: "+crudOp.binaryOperatorId(formulaAnterior,null));
                if ( ("CR".equals(newMethod) && ((opId=crudOp.binaryOperatorId(formulaAnterior,null)) != 2) && (opId !=3) ) || // Right arrow ==> or left arrow <==
                     ("AI".equals(newMethod) && (crudOp.binaryOperatorId(formulaAnterior,null) != 5) ) || // Conjunction /\
                     ("MI".equals(newMethod) && (crudOp.binaryOperatorId(formulaAnterior,null) != 1) )    // Equivalence ==
                    )
                {
                    throw new ClassCastException("Error");
                }

                if (sideOrTransitive){
                    solucion = new Solucion(resuelveAnterior, false, null, newMethod, crudOp);
                }
                else{
                    // Arguments: 1) associated Resuelve object, 2) if it is solved, 3) binary tree of the proof, 4) demonstration method, 5) CrudOperations object
                    boolean containT = formulaTerm.containT();
                    formulaTerm = formulaTerm.setToPrint(simboloManager);
                    if (newMethod.equals("DM") && !containT)
                        solucion = new Solucion(resuelveAnterior, false, formulaTerm, "EO "+newMethod, crudOp);
                    else 
                        solucion = new Solucion(resuelveAnterior, false, formulaTerm, newMethod, crudOp);
                    typedTerm = formulaTerm;
                    solucionManager.addSolucion(solucion); // This adds a new row to the "solucion" table
                    response.setnSol(solucion.getId()+""); // The concatenation with "" converts the id to a string
                }

                methodTerm = ProofMethodUtilities.getTerm(solucion.getMetodo()); //new Const(newMethod);        
            }
            else{
                // When the proof already exists in the DB, we obtain the solution from it.
                solucion = solucionManager.getSolucion(Integer.parseInt(nSol),username); 
                methodTerm = crudOp.updateMethod(solucion.getMetodo(), newMethod);
                if ( ("CR".equals(newMethod) && ((opId=crudOp.binaryOperatorId(formulaAnterior,methodTerm)) != 2) && (opId !=3) ) || // Right arrow ==> or left arrow <==
                     ("AI".equals(newMethod) && (crudOp.binaryOperatorId(formulaAnterior,methodTerm) != 5) ) || // Conjunction /\
                     ("MI".equals(newMethod) && (crudOp.binaryOperatorId(formulaAnterior,methodTerm) != 1) )    // Equivalence ==
                    )
                {
                    throw new ClassCastException("Error");
                }

                // We save in the database the concatenation of the previous list of methods with the new one
                solucion.setMetodo(methodTerm.toString());

                if (sideOrTransitive){
                    formulaTerm = crudOp.initStatement(formulaTerm,methodTerm);
                }
                else{
                    if ("DM".equals(newMethod)){
                        if (!(methodTerm instanceof Const)) {
                           formulaAnterior = crudOp.initStatement(formulaAnterior, methodTerm);
                        }
                        if (!formulaAnterior.containT()) {
                           methodTerm = crudOp.eraseMethod(methodTerm.toString());
                           methodTerm = crudOp.updateMethod(methodTerm!=null?methodTerm.toString():"", "EO");
                           methodTerm = crudOp.updateMethod(methodTerm.toString(), "DM");
                           solucion.setMetodo(methodTerm.toString());
                        }
                        if (teoid.substring(3,teoid.length()).equals(nTeo)) {
                           formulaTerm = crudOp.initStatement(formulaTerm, methodTerm);
                        }
                        formulaTerm = formulaTerm.setToPrint(simboloManager);
                        typedTerm = crudOp.addFirstLineSubProof(username,formulaTerm, solucion.getTypedTerm(), methodTerm);
                        solucion.setTypedTerm(typedTerm);
                    }
                    solucionManager.updateSolucion(solucion);       
                }
                if (isRecursive){ // If we don't put this, we will get "typedTerm" as null in a branched sub-proof
                    typedTerm = solucion.getTypedTerm();
                }
            }

            if (sideOrTransitive){
                // CAUTION: The controller sets the String null parameters as ""
                if ("".equals(lado)){ // This does not occur in Starting from one side method, so we are in a transitive one
                    opId = crudOp.binaryOperatorId(formulaTerm,null);

                    switch (opId){
                        case 2: // Right arrow ==> 
                            lado = "TR".equals(newMethod) ? null : ("WE".equals(newMethod) ? "i" : "d");
                            break;
                        case 3: // Left arrow <==
                            lado = "TR".equals(newMethod) ? null : ("WE".equals(newMethod) ? "d" : "i");
                            break;
                        default:
                            // **** For the "TR" method we should check first if the operator is transitive
                            // **** Also, the user should be able to start from whichever side they want
                            lado = "TR".equals(newMethod) ? "i" : null;
                            break;
                    }
                }
                if (!"".equals(lado)){ // THIS IS NOT AN ELSE, BECAUSE "lado" MAY HAVE CHANGED IN THE PREVIOUS BLOCK
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
                    typedTerm = crudOp.addFirstLineSubProof(username,formulaTerm, solucion.getTypedTerm(), methodTerm);
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
            typedTerm,
            true, // valida
            !isRecursive, // labeled
            methodTerm
        );

        // In the recursive case, the user still needs to choose another proof method for the sub-proof
        response.setCambiarMetodo(isRecursive ? "2" : "0");

        return response;
    }

    /**
     * Controller that responds to HTTP POST request, with data sent as a dictionary.
     *
     * @param username: login of the user that made the request. It is in the URL also.
     * @param nTheo: code of statement of the theorem. 
     * @return A JSON object with a property named "string" representing the formula 
     * of a metatheorem applied to a selected theorem, written in LaTeX notation.
     *
     * The reason why we don't return the String directly is because doing it that way,
     * the tokens of the form \cssId{num} are not processed later in the web page, but
     * they remain as "?".
     */
    @RequestMapping(value="/{username}/metatheorem", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody // This lets the return value be written straight to the HTTP response body
    public JSONObject metatheoremController( @PathVariable String username,
                                             @RequestParam(value="nTheo") String nTheo
                                            )
    {
        Term statement = resuelveManager.getResuelveByUserAndTeoNum(username,nTheo,true).getTeorema().getTeoTerm();

        // Specific case, we use the 3.7 one. The others should be obtained from a template in the database
        Term metaTheo = MetaTheorem.metaTheorem(statement).type();
        String str = "<span>("+nTheo+")" + " with Metatheorem (" + "3.7" +"):$~~~" + metaTheo.toStringLaTeX(simboloManager,nTheo) + "$</span>";

        JSONObject json = new JSONObject();
        json.put("string", MicroServices.transformLaTexToHTML(str));
        return json;
    }
}