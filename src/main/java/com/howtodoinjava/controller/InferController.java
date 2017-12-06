package com.howtodoinjava.controller;

import com.howtodoinjava.entity.Metateorema;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Usuario;
import com.howtodoinjava.forms.InferResponse;
import com.howtodoinjava.forms.InfersForm;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.MakeTerm;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.lambdacalculo.Var;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SolucionManager;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.UsuarioManager;
import com.howtodoinjava.service.CategoriaManager;
import com.howtodoinjava.service.MetateoremaManager;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
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
    private SolucionManager solucionManager;
    @Autowired
    private MetateoremaManager metateoremaManager;
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private HttpSession session;
    @Autowired
    private CategoriaManager categoriaManager;
    
    @RequestMapping(value="/{username}", method=RequestMethod.GET)
    public String selectTeoView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUser(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const("\\equiv ",false,1,1),new Const("true")),t.getTeoTerm()));
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        InfersForm infersForm = new InfersForm();
        
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
        map.addAttribute("hrefAMiMismo","href=../../eval/"+username+"#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","100%");
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("makeTerm",new MakeTerm());
        return "infer";
    }

    @RequestMapping(value="/{username}/{nTeo:.+}", method=RequestMethod.GET)
    public String inferView(@PathVariable String username, @PathVariable String nTeo, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formula = resuel.getTeorema().getTeoTerm().toStringInfFinal();
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUser(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            Term term = t.getTeoTerm();
            if(r.isResuelto()==true || r.getNumeroteorema().equals(nTeo)){
                
                try
                {
                  t.setTeoTerm(new App(new App(new Const("\\cssId{click@"+r.getNumeroteorema()+"}{\\style{cursor:pointer; color:#08c;}{"+((Const)((App)((App)term).p).p).getCon()+"}}",false,1,1),((App)((App)term).p).q),((App)term).q));
                }
                catch (java.lang.ClassCastException e)
                {
                    t.setTeoTerm(term);
                }
                t.setMetateoTerm(new App(new App(new Const("\\cssId{click@"+r.getNumeroteorema()+"}{\\style{cursor:pointer; color:#08c;}{\\equiv}}",false,1,1),new Const("true ")), term));
            }
            else{
                
                try
                {
                  t.setTeoTerm(new App(new App(new Const(((Const)((App)((App)term).p).p).getCon(),false,1,1),((App)((App)term).p).q),((App)term).q));
                }
                catch (java.lang.ClassCastException e)
                {
                    t.setTeoTerm(term);
                }
                t.setMetateoTerm(new App(new App(new Const("{\\equiv}}",false,1,1),new Const("true ")), term));
            }
            
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
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
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(resuel.getDemopendiente());
            infersForm.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
            List<PasoInferencia> inferencias = solucion.getArregloInferencias();
            String ultimaExp = "";
            for (PasoInferencia x: inferencias) {
                infersForm.setHistorial(infersForm.getHistorial()+ "$$" +
                                        x.getExpresion().toStringInfFinal()+" $$" + " $$ \\equiv< " + 
                                        new App(new App(new Const("\\equiv ",false,1,1),x.getTeoDer()), x.getTeoIzq()).toStringInfFinal() + 
                                        " - " + x.getLeibniz().toStringInfFinal() + 
                                        " - " + x.getInstancia().toString()+" > $$");
                ultimaExp = x.getResult().toStringInfFinal();
            }
            if(!ultimaExp.equals("")){
                infersForm.setHistorial(infersForm.getHistorial()+ "$$" +ultimaExp+ "$$");
            }
            if(inferencias.size()==0){
                map.addAttribute("elegirMetodo","1");
            }else{
                map.addAttribute("elegirMetodo","0");
            }
            
            map.addAttribute("formula",infersForm.getHistorial());
        }
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
        map.addAttribute("hrefAMiMismo","href=../../eval/"+username+"#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("makeTerm",new MakeTerm());
        return "infer";
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Inferir",produces= MediaType.APPLICATION_JSON_VALUE)
    
    public @ResponseBody InferResponse infer(@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion, @PathVariable String username, 
            @PathVariable String nTeo, @PathVariable String nSol, @RequestParam(value="teoremaInicial") String teoremaInicial )
    {
        InferResponse response = new InferResponse();
        
        String pasoPost = "";

        TerminoId terminoid=new TerminoId();
        terminoid.setLogin(username);

        if (instanciacion.equals(""))
           instanciacion = "p:=p";
        if (leibniz.equals(""))
            leibniz = "lambda z.z";
        
        String tipoTeo = nStatement.substring(0, 2);
        String numeroTeo = nStatement.substring(3, nStatement.length());

        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
        Teorema teorema = resuelve.getTeorema();
        int idTeorema = teorema.getId();
        Metateorema metateorema = metateoremaManager.getMetateorema(idTeorema);

        Term term = null;
        ObjectInputStream in = null;
        try {
            if(tipoTeo.equals("ST")){
                in = new ObjectInputStream(new ByteArrayInputStream(teorema.getTeoserializado()));
            }
            else if(tipoTeo.equals("MT")){
                in = new ObjectInputStream(new ByteArrayInputStream(metateorema.getMetateoserializado()));
            }
            
            term = (Term) in.readObject();
            in.close();

        } catch (IOException ex) {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, ex);
        }


        ANTLRStringStream in2 = new ANTLRStringStream(instanciacion);
        TermLexer lexer2 = new TermLexer(in2);
        CommonTokenStream tokens2 = new CommonTokenStream(lexer2);
        TermParser parser2 = new TermParser(tokens2);
        ArrayList<Object> arr;
        try
        {
           arr=parser2.instantiate(terminoid,terminoManager);
        }
        catch(RecognitionException e)
        {

                String hdr = parser2.getErrorHeader(e);
                String msg = parser2.getErrorMessage(e, TermParser.tokenNames);
                response.setErrorParser2(hdr + " " + msg);
                
                return response;
            }
            
            ANTLRStringStream in3 = new ANTLRStringStream(leibniz);
            TermLexer lexer3 = new TermLexer(in3);
            CommonTokenStream tokens3 = new CommonTokenStream(lexer3);
            TermParser parser3 = new TermParser(tokens3);
            Term leibnizTerm;
            try
            {
               leibnizTerm =parser3.lambda(terminoid,terminoManager);
            }
            catch(RecognitionException e)
            {
                String hdr = parser3.getErrorHeader(e);
                String msg = parser3.getErrorMessage(e, TermParser.tokenNames);
                response.setErrorParser3(hdr + " " + msg);
                
                return response;
            }
            
            term = term.sustParall((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1));
            Term izq,der;
            izq = ((App)term).q;
            der = ((App)((App)term).p).q;
            
            Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
            Solucion solucion = null;
            Term pasoAntTerm = null;
            
            PasoInferencia paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
            
            if (resuel.getDemopendiente() == -1)
            {
                
                if(teoremaInicial.equals("")){
                    
                    pasoAntTerm = resuel.getTeorema().getTeoTerm();
                    paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                }
                else{
                    Resuelve resuelInicial;
                    ArrayList<String> teoremaInicialInfo = new ArrayList();
                    
                    for (String retval: teoremaInicial.split("-")) {
                        teoremaInicialInfo.add(retval);
                    }
                    
                    String nTeoInicial = teoremaInicialInfo.get(0);
                    resuelInicial = resuelveManager.getResuelveByUserAndTeoNum(username,nTeoInicial);
                    
                    if(teoremaInicialInfo.size() == 1){
                        
                        pasoAntTerm = resuelInicial.getTeorema().getTeoTerm();
                        paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                    }
                    else{
                        if(teoremaInicialInfo.get(1).equals("d")){
                            
                            pasoAntTerm = ((App)((App)resuelInicial.getTeorema().getTeoTerm()).p).q;
                            paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                        }
                        else if (teoremaInicialInfo.get(1).equals("i")){
                            
                            pasoAntTerm = ((App)resuelInicial.getTeorema().getTeoTerm()).q;
                            paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                        }
                        
                    }
                    
                }
                
            }
            else
            {                
                solucion = solucionManager.getSolucion(resuel.getDemopendiente());
                int tam = solucion.getArregloInferencias().size();
                if(tam > 0){
                    PasoInferencia lastInfer = solucion.getArregloInferencias().get(solucion.getArregloInferencias().size()-1);
                    pasoAntTerm = lastInfer.getResult();
                }
                else
                {
                    
                    if(teoremaInicial.equals("")){
                    
                        pasoAntTerm = resuel.getTeorema().getTeoTerm();
                    }
                    else{
                        Resuelve resuelInicial;
                        ArrayList<String> teoremaInicialInfo = new ArrayList();

                        for (String retval: teoremaInicial.split("-")) {
                            teoremaInicialInfo.add(retval);
                        }

                        String nTeoInicial = teoremaInicialInfo.get(0);
                        resuelInicial = resuelveManager.getResuelveByUserAndTeoNum(username,nTeoInicial);

                        if(teoremaInicialInfo.size() == 1){

                            pasoAntTerm = resuelInicial.getTeorema().getTeoTerm();
                        }
                        else{
                            if(teoremaInicialInfo.get(1).equals("d")){

                                pasoAntTerm = ((App)((App)resuelInicial.getTeorema().getTeoTerm()).p).q;
                            }
                            else if (teoremaInicialInfo.get(1).equals("i")){

                                pasoAntTerm = ((App)resuelInicial.getTeorema().getTeoTerm()).q;
                            }

                        }

                    }
                }
                       
                paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);                
            }
            
            izq = new App(leibnizTerm,izq).reducir();
            der = new App(leibnizTerm,der).reducir();

            boolean valida = true;
            
            Term pasoPostTerm=null;
            if (izq.equals(pasoAntTerm)) {
                pasoPostTerm = der;
                //pasoPost = der.toStringInfFinal();
                pasoPost = der.toStringInfLabeled();
            }else if(der.equals(pasoAntTerm)) {
                pasoPostTerm = izq;
                //pasoPost = izq.toStringInfFinal();
                pasoPost = izq.toStringInfLabeled();
            }else{
                pasoPost = "Regla~de~inferencia~no~valida";
                valida = false;
            }
            
            if (resuel.getDemopendiente() == -1 && valida)
            {
                paso.setResult(pasoPostTerm);
                solucion = new Solucion(resuel,false,paso);
                solucionManager.addSolucion(solucion);
                nSol = ""+solucion.getId();
                response.setnSol(nSol);
                
            }
            else if (valida)
            {
                paso.setResult(pasoPostTerm);
                solucion.addArregloInferencias(paso);
                solucionManager.updateSolucion(solucion);
            }
            
            List<PasoInferencia> inferencias = solucion.getArregloInferencias();
            String formula = resuel.getTeorema().getTeoTerm().toStringInfFinal();
            
            response.generarHistorial(formula, nTeo, pasoPost, valida, inferencias);

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Retroceder",produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse retroceder( @RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion, @PathVariable String username, 
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
        

        List<PasoInferencia> inferencias = solucion.getArregloInferencias();
        String formula = resuelve.getTeorema().getTeoTerm().toStringInfFinal();

        response.generarHistorial(formula, nTeo,inferencias);
        if(respRetroceder==1 || respRetroceder==0){
            response.setCambiarMetodo("1");
        }
        else{
            response.setCambiarMetodo("0");
        }
    
        
        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialMD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialMD( @RequestParam(value="teoid") String teoid, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm().toStringInfFinal();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,teoid.substring(3,teoid.length()));
        //String formula = resuelve.getTeorema().getTeoTerm().toStringInfFinal();
        String formula = resuelve.getTeorema().getTeoTerm().toStringInfLabeled();
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<center>$"+formula+"$</center>";
        response.setHistorial(historial);  

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaClickeablePL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaClickeablePL( @RequestParam(value="teoid") String teoid, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
      
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String equiv = ((Const)((App)((App)term).p).p).getCon();
        
        if(!equiv.startsWith("\\equiv")){
            response.setLado("0");
            return response;
        }
        else{
            response.setLado("1");
        }

        String formulaDer = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInfFinal();
        String formulaIzq = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInfFinal();
        String operador = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).p.toStringInfFinal();//resuelve.getTeorema().getOperador();
        
        formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
        formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaIzq+"$ $"+ operador +"$ $" + formulaDer + "$</center> Proof: ";
        response.setHistorial(historial);  

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialPL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialPL( @RequestParam(value="teoid") String teoId,@RequestParam(value="lado") String lado, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInfFinal();
        
        String formula = "";
        
        if(lado.equals("d")){
            //formula = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInfFinal();
            formula = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInfLabeled();
        }
        else if(lado.equals("i")){
            //formula = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInfFinal();
            formula = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInfLabeled();
        }
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<center>$"+formula+"$</center>";
        response.setHistorial(historial);  

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialDF", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialDF(@PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInfFinal();
        
        Teorema t = resuelve.getTeorema();
        Term term = t.getTeoTerm();
        String operador = ((Const)((App)((App)term).p).p).getCon();
        
        
        String formula = "";
        if(operador.startsWith("\\Lefttarrow")){
            response.setLado("d");
            formula = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInfFinal();
        }
        else if(operador.startsWith("\\Rightarrow")){
            response.setLado("i");
            formula = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInfFinal();
        }
        else{
            response.setLado("0");
        }
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<center>$"+formula+"$</center>";
        response.setHistorial(historial);  

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
