package com.howtodoinjava.controller;

import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.Dispone;
import com.howtodoinjava.entity.PredicadoId;
import com.howtodoinjava.entity.MostrarCategoria;
import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Usuario;
import com.howtodoinjava.forms.InferResponse;
import com.howtodoinjava.forms.InfersForm;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Bracket;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.Sust;
import com.howtodoinjava.lambdacalculo.Var;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.lambdacalculo.TypeVerificationException;
import com.howtodoinjava.lambdacalculo.TypedA;
import com.howtodoinjava.lambdacalculo.TypedApp;
import com.howtodoinjava.lambdacalculo.TypedI;
import com.howtodoinjava.lambdacalculo.TypedL;
import com.howtodoinjava.lambdacalculo.TypedS;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SolucionManager;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.UsuarioManager;
import com.howtodoinjava.service.CategoriaManager;
import com.howtodoinjava.service.DisponeManager;
import com.howtodoinjava.service.MetateoremaManager;
import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.MostrarCategoriaManager;
import com.howtodoinjava.service.SimboloManager;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;
import org.hibernate.classic.Validatable;
import org.omg.CORBA.PRIVATE_MEMBER;
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
        map.addAttribute("computarMenu","class=\"active\"");
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
        String formula = resuel.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            Term term = t.getTeoTerm();
            if(r.isResuelto()==true || r.getNumeroteorema().equals(nTeo)){
                
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
            map.addAttribute("formula","Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");
            map.addAttribute("elegirMetodo","1");
            map.addAttribute("teoInicial", "");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(resuel.getDemopendiente());
            infersForm.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
            InferResponse response = new InferResponse();
            Term typedTerm = solucion.getTypedTerm();
            response.generarHistorial(username,formula, nTeo, typedTerm, true,solucion.getMetodo(), resuelveManager, disponeManager,simboloManager);

            if (typedTerm == null){
                map.addAttribute("elegirMetodo","1");
            }else{
                map.addAttribute("elegirMetodo","0");
            }
            
            map.addAttribute("formula",response.getHistorial());
            Term type = null;//typedTerm.type();
            String teoInicial;
            Resuelve res = null;
            if (typedTerm!=null && (type = typedTerm.type()) == null)
            {
                teoInicial = solucion.getTypedTerm().toStringFinal();
                res = resuelveManager.getResuelveByUserAndTeorema(username, teoInicial);
            }
            else if (typedTerm!=null)
            {
              teoInicial = ((App)type).q.toStringFinal();
              res = resuelveManager.getResuelveByUserAndTeorema(username, teoInicial);
            }
            if (res != null)
               map.addAttribute("teoInicial", res.getNumeroteorema());
            else
               map.addAttribute("teoInicial", "");
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
        
        map.addAttribute("usuario",usr);
        map.addAttribute("guardarMenu","");
        map.addAttribute("selecTeo",false);
        map.addAttribute("nSol",solId);
        map.addAttribute("nTeo",nTeo);
        map.addAttribute("admin","admin");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","class=\"active\"");
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
     * This function will only be correct if called when using DirectMethod
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the DirectMethod. In other case it will return 
     * the prove given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved A == ... == F
     * @param initialExpr: Term that represents A
     * @param teoremProved: The teorem the user is trying to prove
     * @param finalExpr: Term that represents F
     * @param proof: The proof tree so far
     * @param username: name of the user doing the prove
     * @return
     */
    private Term finishedDirectMethodProve(Term initialExpr, Term teoremProved,Term finalExpr, Term proof, String username) {
    	
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
				return new TypedApp(proof, new TypedA(((App)proof.type()).q));
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
     * the prove given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved A == ... == F
     * @param initialExpr: Term that represents A
     * @param finalExpr: Term that represents F
     * @param teoremProved: The teorem the user is trying to prove
     * @param proof: The proof tree so far
     * @return
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
    
   
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Inferir",headers="Accept=application/json", produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody InferResponse infer(@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion, @PathVariable String username, 
            @PathVariable String nTeo, @PathVariable String nSol, @RequestParam(value="nuevoMetodo") String nuevoMetodo/*, @RequestParam(value="teoremaInicial") String teoremaInicial, @RequestParam(value="nuevoMetodo") String nuevoMetodo */) 
    {
        InferResponse response = new InferResponse();
        
        PredicadoId predicadoid=new PredicadoId();
        predicadoid.setLogin(username);
        

        // FIND THE THEOREM BEING USED IN THE HINT
    	String tipoTeo = nStatement.substring(0, 2);
        String numeroTeo = nStatement.substring(3, nStatement.length());
        Term statementTerm = null;
        if (tipoTeo.equals("ST")){
            Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
            statementTerm = resuelve.getTeorema().getTeoTerm();
        }
        else if(tipoTeo.equals("MT")){
            Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
            statementTerm = dispone.getMetateorema().getTeoTerm();
        }
    	
        // CREATE THE INSTANTIATION
    	ArrayList<Object> arr = null;
        if (!instanciacion.equals("")){
          CharStream in2 = CharStreams.fromString(instanciacion);
          TermLexer lexer2 = new TermLexer(in2);
          CommonTokenStream tokens2 = new CommonTokenStream(lexer2);
          TermParser parser2 = new TermParser(tokens2);
          try{
             arr=parser2.instantiate(predicadoid,predicadoManager,simboloManager).value;
          }
          catch(RecognitionException e){ // Wrong instantiation sent by the user
              String hdr = parser2.getErrorHeader(e);
              String msg = e.getMessage(); 
              response.setErrorParser2(hdr + " " + msg);
                
              return response;
          }
        }
        
        // CREATE LEIBNIZ
        Term leibnizTerm = null;
        if (!leibniz.equals("")){
            CharStream in3 = CharStreams.fromString(leibniz);
            TermLexer lexer3 = new TermLexer(in3);
            CommonTokenStream tokens3 = new CommonTokenStream(lexer3);
            TermParser parser3 = new TermParser(tokens3);
            try{
               leibnizTerm =parser3.lambda(predicadoid,predicadoManager,simboloManager).value;
            }
            catch(RecognitionException e) { // Wrong leibniz sent by the user
                String hdr = parser3.getErrorHeader(e);
                String msg = e.getMessage(); 
                response.setErrorParser3(hdr + " " + msg);
                
                return response;
            }
        }   

            
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
        Term typedTerm = solucion.getTypedTerm();
        String formula = resuel.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        

        // CREATE THE NEW HINT
        Term infer = null;
        try {
        	if (instanciacion.equals("") && leibniz.equals(""))
        		infer = new TypedA(statementTerm);
        	else if (instanciacion.equals(""))
        	{
        		TypedA A = new TypedA(statementTerm);
        		TypedL L = new TypedL((Bracket)leibnizTerm);
        		infer = new TypedApp(L,A);
        	}
        	else if (leibniz.equals(""))
        	{
        		TypedA A = new TypedA(statementTerm);
        		TypedI I = new TypedI(new Sust((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1)));
        		infer = new TypedApp(I,A);
        	}
        	else
        	{
        		TypedA A = new TypedA(statementTerm);
        		TypedI I = new TypedI(new Sust((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1)));
        		TypedL L = new TypedL((Bracket)leibnizTerm);
        		infer = new TypedApp(L,new TypedApp(I,A));
        	} 
        }catch(TypeVerificationException e) {
        	response.generarHistorial(username,formula, nTeo,typedTerm,false,nuevoMetodo,resuelveManager,disponeManager,simboloManager);
        	return response;
        } 

        // CREATE THE NEW PROOF TREE BY ADDING THE NEW HINT
        Term pasoPostTerm =null;
        try
        {
        	
        	if (typedTerm.type() == null)// If the proof only has one line so far
        	{
        		try{
        			new TypedApp(new TypedA(new App(new App(new Const(1,"c_{1}",false,1,1),
        					typedTerm),typedTerm)),infer); // si no da excepcion la inferencia 
        			//es valida con respecto a la primera exp
        		}
        		catch (TypeVerificationException e)
        		{
        			new TypedApp(new TypedA(new App(new App(new Const(1,"c_{10}",false,1,1),
        					typedTerm),typedTerm)),infer); // si no da excepcion la inferencia 
        			//es valida con respecto a la primera exp
        		}
        		pasoPostTerm = infer;                                                             
        	}
        	else
        		pasoPostTerm = new TypedApp(typedTerm, infer);
        }
        catch (TypeVerificationException e)
        {
        	try
        	{
        		infer = new TypedApp(new TypedS(infer.type()), infer);
        		if (typedTerm.type() == null)
        		{
        			try {
        				new TypedApp(new TypedA(new App(new App(new Const(1,"c_{1}",false,1,1),
        						typedTerm),typedTerm)),infer); // si no da excepcion la inferencia 
        				//es valida con respecto a la primera exp
        			}
        			catch (TypeVerificationException ex)
        			{
        				new TypedApp(new TypedA(new App(new App(new Const(1,"c_{10}",false,1,1),
        						typedTerm),typedTerm)),infer); // si no da excepcion la inferencia 
        				//es valida con respecto a la primera exp    
        			}
        			pasoPostTerm = infer;
        		}
        		else
        			pasoPostTerm = new TypedApp(typedTerm, infer);
        	}
        	catch (TypeVerificationException ex)
        	{
        		response.generarHistorial(username,formula, nTeo,typedTerm,false,nuevoMetodo,resuelveManager,disponeManager,simboloManager);
        		return response;
        	}
        	catch (ClassCastException ex)
        	{
        		response.generarHistorial(username,formula, nTeo,typedTerm,false,nuevoMetodo,resuelveManager,disponeManager,simboloManager);
        		return response;
        	}
        }
        
        
        // IF HERE THEN THE HINT WAS VALID
        
        response.setResuelto("0");
             
        Term proof = pasoPostTerm;
        Term expr = proof.type();
    	Term initialExpr = ((App)expr).q;
    	Term finalExpr = ((App)((App)expr).p).q;
    	Term teoremProved = resuel.getTeorema().getTeoTerm();
    	String metodo = solucion.getMetodo();
    	
    	// CHECK IF THE PROOF FINISHED
    	
    	Term newProof = null;
    	
    	// Depending on the method we create a new proof if we finished
    	if(metodo.equals("Direct method")) {
    		newProof = finishedDirectMethodProve(initialExpr, teoremProved, finalExpr, proof, username);
    	}else if(metodo.equals("Starting from one side")) {
    		newProof = finishedOneSideProve(initialExpr, finalExpr, teoremProved, proof);
    	}
    	
    	// newProve might or might not be different than pasoPostTerm
    	
    	// UPDATE SOLUCION 
    	solucion.setTypedTerm(newProof);
    	solucionManager.updateSolucion(solucion);

    	// If we finished mark solucion as solved
        if(teoremProved.equals(newProof.type())){
        	response.setResuelto("1");
        	solucion.setResuelto(true);
        	resuel.setResuelto(true);
        	resuelveManager.updateResuelve(resuel);
        	solucionManager.updateSolucion(solucion);
        }       
        
        response.generarHistorial(username,formula, nTeo,pasoPostTerm,true,nuevoMetodo,
        		resuelveManager,disponeManager,simboloManager);
        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Retroceder",produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse retroceder( /*@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion,*/ @PathVariable String username, 
            @PathVariable String nTeo, @PathVariable String nSol)
    {   
        InferResponse response = new InferResponse();

        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Solucion solucion = solucionManager.getSolucion(resuelve.getDemopendiente());
        int respRetroceder;
        if(nSol.equals("new")){
            respRetroceder = 0;
        }
        else{
            respRetroceder = solucion.retrocederPaso();
            solucionManager.updateSolucion(solucion);
        }
        
        //List<PasoInferencia> inferencias = solucion.getArregloInferencias();
        String formula = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager,"");

        response.generarHistorial(username,formula, nTeo,respRetroceder==0?null:solucion.getTypedTerm(),true,solucion.getMetodo(),resuelveManager,disponeManager,simboloManager);
        if(/*respRetroceder==1 ||*/ respRetroceder==0){
            response.setCambiarMetodo("1");
        }
        else{
            response.setCambiarMetodo("0");
        }
    
        
        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialMD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialMD( @RequestParam(value="nuevoMetodo") String nuevoMetodo, @RequestParam(value="teoid") String teoid, @PathVariable String nSol, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();

        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        
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
        
        if (nSol.equals("new"))
        {
            Solucion solucion = new Solucion(resuelveAnterior,false,formulaTerm, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));        
            solucion.setTypedTerm(formulaTerm);
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,nuevoMetodo,
                                      resuelveManager,disponeManager,simboloManager);
        //String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        //response.setHistorial(historial);  

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaClickeablePL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaClickeablePL( /*@RequestParam(value="teoid") String teoid,*/ @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
      
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String equiv = ((Const)((App)((App)term).p).p).getCon();

        if(!equiv.startsWith("c_{1}") && !equiv.startsWith("c_{10}")){
            response.setLado("0");
            return response;
        }
        else{
            response.setLado("1");
        }

        String formulaDer = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInf(simboloManager,"");
        String formulaIzq = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInf(simboloManager,"");
        String operador = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).p.toStringInf(simboloManager,"");//resuelve.getTeorema().getOperador();
        
        formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
        formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaIzq+"$ $"+ operador +"$ $" + formulaDer + "$</center> Proof: ";
        response.setHistorial(historial);  

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialPL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialPL(@RequestParam(value="nuevoMetodo") String nuevoMetodo, @PathVariable String nSol, @RequestParam(value="lado") String lado, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
                
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        
        Term formulaTerm = null;
        
        if(lado.equals("d")){
            //formula = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInfFinal();
            formulaTerm = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q;
        }
        else if(lado.equals("i")){
            //formula = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInfFinal();
            formulaTerm = ((App)resuelve.getTeorema().getTeoTerm()).q;
        }
        
        if (nSol.equals("new"))
        {
            Solucion solucion = new Solucion(resuelve,false,formulaTerm, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));        
            solucion.setTypedTerm(formulaTerm);
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,nuevoMetodo,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial); */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialD(@RequestParam(value="nuevoMetodo") String nuevoMetodo, @RequestParam(value="teoSol") String teoSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String operador = ((Const)((App)((App)term).p).p).getCon();
        
        
        //String formula = "";
        Term formulaTerm = null;
        if(operador.startsWith("\\Lefttarrow")){
            response.setLado("d");
            formulaTerm = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q;
        }
        else if(operador.startsWith("\\Rightarrow")){
            response.setLado("i");
            formulaTerm = ((App)resuelve.getTeorema().getTeoTerm()).q;
        }
        else{
            response.setLado("0");
        }
        
        if (teoSol.equals("new"))
        {
            Solucion solucion = new Solucion(resuelve,false,formulaTerm, nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(teoSol));        
            solucion.setTypedTerm(formulaTerm);
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,nuevoMetodo,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialF", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialF(@RequestParam(value="nuevoMetodo") String nuevoMetodo, @RequestParam(value="teoSol") String teoSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager,"");
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String operador = ((Const)((App)((App)term).p).p).getCon();
        
        
        //String formula = "";
        Term formulaTerm = null;
        if(operador.startsWith("\\Lefttarrow")){
            response.setLado("i");
            formulaTerm = ((App)resuelve.getTeorema().getTeoTerm()).q;

        }
        else if(operador.startsWith("\\Rightarrow")){
            response.setLado("d");
            formulaTerm = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q;
        }
        else{
            response.setLado("0");
        }
        
        if (teoSol.equals("new"))
        {
            Solucion solucion = new Solucion(resuelve,false,formulaTerm,nuevoMetodo);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(teoSol));        
            solucion.setTypedTerm(formulaTerm);
            solucion.setMetodo(nuevoMetodo);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,nuevoMetodo,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */

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
