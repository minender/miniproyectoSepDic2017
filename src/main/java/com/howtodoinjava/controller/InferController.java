package com.howtodoinjava.controller;

import com.google.gson.TypeAdapter;
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
import com.howtodoinjava.lambdacalculo.TypedTerm;
import com.howtodoinjava.parse.CombUtilities;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SolucionManager;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.UsuarioManager;
import com.sun.org.apache.bcel.internal.generic.NEW;
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

import org.antlr.v4.parse.ANTLRParser.throwsSpec_return;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;
//import org.apache.jasper.tagplugins.jstl.core.If;
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
    @Autowired
    private CombUtilities combUtilities;
    
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
    public String inferView(@PathVariable String username, @PathVariable String nTeo, ModelMap map){
        
    	if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formula = resuel.getTeorema().getTeoTerm();
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        
        // Will be true if the theorem is an implication
        boolean implication = formula instanceof App && ((App)formula).p instanceof App && ((App)((App)formula).p).p.toString().equals("c_{2}");
        String Hstring = "";
        String Qstring = "";
        if(implication) {
        	Term H = ((App)formula).q;
        	Term Q = ((App)((App)formula).p).q;
        	Hstring = H.toStringInf(simboloManager,"");
        	Qstring = Q.toStringInf(simboloManager,"");
        }
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            Term term = t.getTeoTerm();
            if(r.isResuelto()==true || r.getNumeroteorema().equals(nTeo)){
                
                t.setTeoTerm(term);
                t.setMetateoTerm(new App(new App(new Const(1,"\\cssId{clickmeta@"+r.getNumeroteorema()+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{\\equiv}}}",false,1,1),new Const("true ")), term));
            }
            else{
                ;
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
        map.addAttribute("implication", implication);
        map.addAttribute("Hstring", Hstring);
        map.addAttribute("Qstring", Qstring);
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

        return "infer";
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
    private Term finishedOneSideProve(Term teoremProved, Term proof) {
    	
    	Term expr = proof.type();
    	Term initialExpr = ((App)expr).q;
    	Term finalExpr = ((App)((App)expr).p).q;
    	
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
    
    /**
     * This function will only be correct if called when using Starting from one side method with natural deduction
     * This function will return a new prove tree in case it finds out that the last hint of prove
     * caused the whole prove to be correct under the One side natural deduction method. In other case it will return 
     * the proof given as argument.
     * 
     * To understand the arguments assume we have a prove that so far has proved  H /\ Bi == ... == H /\ Bn
     * @param initialExpr: Term that represents H /\ Bi
     * @param finalExpr: Term that represents H /\ Bn
     * @param teoremProved: The teorem the user is trying to prove
     * @param proof: The proof tree so far
     * @return new proof if finished, else return the same proof
     */
    private Term finishedDeductionOneSideProve(Term teoremProved, Term proof) {
    	
    	try {
    		
		Term expr = proof.type();
    	Term initialExpr = ((App)expr).q;
    	Term finalExpr = ((App)((App)expr).p).q;
    	
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
    private Term finishedDeductionDirectProve(Term teoremProved, Term proof, String username) {
    	
    	Term expr = proof.type();
    	Term initialExpr = ((App)expr).q;
    	Term finalExpr = ((App)((App)expr).p).q;
    	
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
    private Term createDirectMethodInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString ) throws TypeVerificationException {
    	
    	Term hint = null;
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
    private Term createOneSideInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString) throws TypeVerificationException {
    	return createDirectMethodInfer(teorem, instantiation, instantiationString, leibniz, leibnizString);
    }
    
    private Term createWSInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString) {
        Term hint = null;
    	try {
        	if (instantiationString.equals("") && leibnizString.equals(""))
        		hint = new TypedA(teorem);
        	else if (instantiationString.equals(""))
        	{
        		TypedA A = new TypedA(teorem);
                        Term c;
                        if ( teorem instanceof App && ((App)teorem).p instanceof App &&
                             (c=((App)(((App)teorem).p)).p) != null && c instanceof Const &&
                              (((Const)c).getId() == 2 || ((Const)c).getId() == 3) )
                            hint = parityLeibniz(leibniz, A);
                        else {
                            TypedL L = new TypedL(leibniz);
                            hint = new TypedApp(L,A);    
                        }
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
                        Term c;
                        if (  teorem instanceof App && ((App)teorem).p instanceof App &&
                             (c=((App)((App)teorem).p).p) != null && c instanceof Const &&
                              (((Const)c).getId() == 2 || ((Const)c).getId() == 3 )
                           )
                            hint = parityLeibniz(leibniz,new TypedApp(I,A));
                        else {
                            TypedL L = new TypedL((Bracket)leibniz);
                            hint = new TypedApp(L,new TypedApp(I,A));    
                        }
        	} 
        }catch(TypeVerificationException e) { // If something went wrong return null
        	e.printStackTrace();
        	return null;
        }
    	
    	return hint;        
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
    private Term createDeductionOneSideInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString, Term teoremProved) throws TypeVerificationException {

    	
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
    private Term createDeductionDirectInfer(Term teorem, ArrayList<Object> instantiation, String instantiationString, Bracket leibniz, String leibnizString, Term teoremProved) throws TypeVerificationException {


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
    	//String iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{1}  (c_{5} (x_{69} x_{67}) x_{65}) x_{65}) (c_{1}  (c_{5} (x_{69} x_{66}) x_{65}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
    	String iaLeftString = "I^{[x_{65},x_{66},x_{67},x_{69} :=" +a+ "," +b+ "," +c+ "," +e+ "]}A^{c_{2} (c_{1} (c_{5} (x_{69} x_{67}) x_{65}) (c_{5} (x_{69} x_{66}) x_{65})) (c_{2} (c_{1} x_{67} x_{66}) x_{65})}";
    	Term iaLefTerm = combUtilities.getTerm(iaLeftString);
    	
    	// need this L to make the hint fit for H == z
    	TypedL L = new TypedL(new Bracket(new Var('z'), new App(new App(new Const("c_{1}"),new Var('z')) ,aTerm)));
    	
    	return  new TypedApp(L, new TypedApp(iaLefTerm, iaRighTerm));

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
        Term formula = resuel.getTeorema().getTeoTerm();
        String metodo = solucion.getMetodo();
        

        // CREATE THE NEW INFERENCE DEPENDING ON THE PROVE TYPE
        Term infer = null;
        try {
	        if(metodo.equals("Direct method")) {
	        	infer = createDirectMethodInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
	        }else if(metodo.equals("Starting from one side")) {
	        	infer = createOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
	        }else if(metodo.equals("DWeakening")) {
	                infer = createWSInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz);
	        }else if(metodo.equals("Natural Deduction,one-sided")) {
	        	infer = createDeductionOneSideInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
	        }else if(metodo.equals("Natural Deduction,direct")) {
	        	infer = createDeductionDirectInfer(statementTerm, arr, instanciacion, (Bracket)leibnizTerm, leibniz, resuel.getTeorema().getTeoTerm());
	        }

        // If something went wrong building the new hint
        } catch (TypeVerificationException e) {
        	response.generarHistorial(username,formula, nTeo,typedTerm,false,metodo,resuelveManager,disponeManager,simboloManager);
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
//        		ex.printStackTrace();
        		response.generarHistorial(username,formula, nTeo,typedTerm,false,metodo,resuelveManager,disponeManager,simboloManager);
        		return response;
        	}
        	catch (ClassCastException ex)
        	{
//        		ex.printStackTrace();
        		response.generarHistorial(username,formula, nTeo,typedTerm,false,metodo,resuelveManager,disponeManager,simboloManager);
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
    	
    	// CHECK IF THE PROOF FINISHED
    	
    	Term newProof = pasoPostTerm;
    	
    	// Depending on the method we create a new proof if we finished
    	if(metodo.equals("Direct method")) {
    		newProof = finishedDirectMethodProve(teoremProved, proof, username);
    	}else if(metodo.equals("Starting from one side")) {
    		newProof = finishedOneSideProve(teoremProved, proof);
    	}else if(metodo.equals("Natural Deduction,one-sided")) {
        	newProof = finishedDeductionOneSideProve(teoremProved, proof);
        }else if(metodo.equals("Natural Deduction,direct")) {
        	newProof = finishedDeductionDirectProve(teoremProved, proof, username);
        	
        }
    	
    	// newProve might or might not be different than pasoPostTerm
    	
    	// UPDATE SOLUCION 
    	solucion.setTypedTerm(newProof);
    	solucionManager.updateSolucion(solucion);

    	// If finished mark solucion as solved
        if(teoremProved.equals(newProof.type())){
        	response.setResuelto("1");
        	solucion.setResuelto(true);
        	resuel.setResuelto(true);
        	resuelveManager.updateResuelve(resuel);
        	solucionManager.updateSolucion(solucion); // no creo que sea necesario hacer dos veces esto
        }       
        
       
        response.generarHistorial(username,formula, nTeo,newProof,true,metodo,
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
        Term formula = resuelve.getTeorema().getTeoTerm();

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
            @PathVariable String nTeo) throws TypeVerificationException
    {   
        InferResponse response = new InferResponse();
        response.setLado("1");
        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm();
        
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
    public @ResponseBody InferResponse teoremaClickeablePL( @RequestParam(value="nuevoMetodo") String nuevoMetodo, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
      
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        
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
    

        if(!equiv.startsWith("c_{1}") && !equiv.startsWith("c_{10}")){
            response.setLado("0");
            return response;
        }
        else{
            response.setLado("1");
        }

        String formulaDer = ((App)((App)term).p).q.toStringInf(simboloManager,"");
        String formulaIzq = ((App)term).q.toStringInf(simboloManager,"");
        String operador = ((App)((App)term).p).p.toStringInf(simboloManager,"");//resuelve.getTeorema().getOperador();
        
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
        
        boolean naturalSide = nuevoMetodo.equals("Natural Deduction,one-sided");
        Term H = null;
                
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        Term formulaTerm = null;
        
        if(naturalSide) {
        	H = ((App)formulaAnterior).q;
        	formulaAnterior = ((App)((App)formulaAnterior).p).q;
        }
        
        if(lado.equals("d")){
            formulaTerm = ((App)((App)formulaAnterior).p).q;
        }
        else if(lado.equals("i")){
            formulaTerm = ((App)formulaAnterior).q;
        }
        
        // In natural dededuction case add H /\ to the start
        if(naturalSide) {
        	formulaTerm = new App(new App(new Const("c_{5}"), formulaTerm), H);
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
      
        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialD(@RequestParam(value="nuevoMetodo") String nuevoMetodo, @PathVariable String nSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String operador = ((Const)((App)((App)term).p).p).getCon();
        
        
        //String formula = "";
        Term formulaTerm = null;
        if(operador.equals("c_{3}")){
            response.setLado("d");
            formulaTerm = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q;
        }
        else if(operador.equals("c_{2}")){
            response.setLado("i");
            formulaTerm = ((App)resuelve.getTeorema().getTeoTerm()).q;
        }
        else{
            response.setLado("0");
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
        response.setHistorial(historial);  */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialF", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialF(@RequestParam(value="nuevoMetodo") String nuevoMetodo, @RequestParam(value="teoSol") String teoSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        Term formulaAnterior = resuelve.getTeorema().getTeoTerm();
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String operador = ((Const)((App)((App)term).p).p).getCon();
        
        
        //String formula = "";
        Term formulaTerm = null;
        if(operador.equals("c_{3}")){
            response.setLado("i");
            formulaTerm = ((App)resuelve.getTeorema().getTeoTerm()).q;

        }
        else if(operador.equals("c_{2}")){
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
