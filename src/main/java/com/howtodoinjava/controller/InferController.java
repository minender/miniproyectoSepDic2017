package com.howtodoinjava.controller;

import com.howtodoinjava.entity.Dispone;
import com.howtodoinjava.entity.Resuelve;
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
import com.howtodoinjava.service.SimboloManager;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;
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
        //map.addAttribute("hrefAMiMismo","href=../../eval/"+username+"#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","100%");
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("simboloManager",simboloManager);
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
        String formula = resuel.getTeorema().getTeoTerm().toStringInf(simboloManager);
        String solId = "new";
        if (resuel.getDemopendiente() != -1)
            solId ="" + resuel.getDemopendiente();
        
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            Term term = t.getTeoTerm();
            if(r.isResuelto()==true || r.getNumeroteorema().equals(nTeo)){
                
                try
                {
                  t.setTeoTerm(new App(new App(new Const(1,"\\cssId{click@"+r.getNumeroteorema()+"}{\\class{operator}{\\style{cursor:pointer; color:#08c;}{"+((Const)((App)((App)term).p).p).getCon()+"}}}",((Const)((App)((App)term).p).p).getFunNotation(),((Const)((App)((App)term).p).p).getPreced(),((Const)((App)((App)term).p).p).getAsociat()),((App)((App)term).p).q),((App)term).q));
                }
                catch (java.lang.ClassCastException e)
                {
                    t.setTeoTerm(term);
                }
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
            map.addAttribute("teoInicial", "");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(resuel.getDemopendiente());
            infersForm.setHistorial("Theorem "+nTeo+":<br> <center>$"+formula+"$</center> Proof:");  
            InferResponse response = new InferResponse();
            Term typedTerm = solucion.getTypedTerm();
            response.generarHistorial(username,formula, nTeo, typedTerm, true, resuelveManager, disponeManager,simboloManager);

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
        //map.addAttribute("makeTerm",new MakeTerm());
        return "infer";
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}", method=RequestMethod.POST, params="submitBtn=Inferir",headers="Accept=application/json", produces= MediaType.APPLICATION_JSON_VALUE)    
    public @ResponseBody InferResponse infer(@RequestParam(value="nStatement") String nStatement, @RequestParam(value="leibniz") String leibniz , @RequestParam(value="instanciacion") String instanciacion, @PathVariable String username, 
            @PathVariable String nTeo, @PathVariable String nSol/*, @RequestParam(value="teoremaInicial") String teoremaInicial, @RequestParam(value="nuevoMetodo") String nuevoMetodo */)
    {
        InferResponse response = new InferResponse();
        String pasoPost = "";
        
        /*ArrayList<String> teoremaInicialInfo = new ArrayList();

        for (String retval: teoremaInicial.split("@")) {
            teoremaInicialInfo.add(retval);
        }*/

        /*
        Resuelve resuelInicial = null;
        Dispone disponeInicial = null;
        String nTeoInicial = teoremaInicialInfo.get(0);
        if ("ST-".equals(nTeoInicial.substring(0,3)))
        {
          resuelInicial = resuelveManager.getResuelveByUserAndTeoNum(username,nTeoInicial.substring(3,nTeoInicial.length()));
        }
        else if ("MT-".equals(nTeoInicial.substring(0,3)))
        {
          disponeInicial = disponeManager.getDisponeByUserAndTeoNum(username,nTeoInicial.substring(3,nTeoInicial.length()));
        }*/
        
        
        TerminoId terminoid=new TerminoId();
        terminoid.setLogin(username);
        
        String tipoTeo = nStatement.substring(0, 2);
        String numeroTeo = nStatement.substring(3, nStatement.length());

        /*Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
        Teorema teorema = resuelve.getTeorema();
        int idTeorema = teorema.getId();
        Metateorema metateorema = metateoremaManager.getMetateorema(idTeorema);
        */
        Term statementTerm = null;
        if (tipoTeo.equals("ST")){
            Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username, numeroTeo);
            statementTerm = resuelve.getTeorema().getTeoTerm();
        }
        else if(tipoTeo.equals("MT")){
            Dispone dispone = disponeManager.getDisponeByUserAndTeoNum(username, numeroTeo);
            statementTerm = dispone.getMetateorema().getTeoTerm();
        }
        /*ObjectInputStream in = null;
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
        }*/

        ArrayList<Object> arr = null;
        if (!instanciacion.equals(""))
        {
          CharStream in2 = CharStreams.fromString(instanciacion);
          TermLexer lexer2 = new TermLexer(in2);
          CommonTokenStream tokens2 = new CommonTokenStream(lexer2);
          TermParser parser2 = new TermParser(tokens2);
          try
          {
             arr=parser2.instantiate(terminoid,terminoManager,simboloManager).value;
          }
          catch(RecognitionException e)
          {

              String hdr = parser2.getErrorHeader(e);
              String msg = e.getMessage(); //parser2.getErrorMessage(e, TermParser.tokenNames);
              response.setErrorParser2(hdr + " " + msg);
                
              return response;
          }
        }
        
        Term leibnizTerm = null;
        if (!leibniz.equals(""))
        {
            CharStream in3 = CharStreams.fromString(leibniz);
            TermLexer lexer3 = new TermLexer(in3);
            CommonTokenStream tokens3 = new CommonTokenStream(lexer3);
            TermParser parser3 = new TermParser(tokens3);
            try
            {
               leibnizTerm =parser3.lambda(terminoid,terminoManager,simboloManager).value;
            }
            catch(RecognitionException e)
            {
                String hdr = parser3.getErrorHeader(e);
                String msg = e.getMessage(); //parser3.getErrorMessage(e, TermParser.tokenNames);
                response.setErrorParser3(hdr + " " + msg);
                
                return response;
            }
        }   
            /*statementTerm = statementTerm.sustParall((ArrayList<Var>)arr.get(0), (ArrayList<Term>)arr.get(1));
            Term izq,der;
            izq = ((App)term).q;
            der = ((App)((App)term).p).q;*/
            
            Resuelve resuel = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));
            Term typedTerm = solucion.getTypedTerm();
            Term expIniTerm = null;
            Term aux = typedTerm.type();
            if (aux == null)
                expIniTerm = typedTerm;
            else
                expIniTerm = ((App)aux).q;
            /*
            PasoInferencia paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
            */
            
            /*if (resuel.getDemopendiente() == -1)
            {
                if(teoremaInicial.equals("")){
                    
                    pasoAntTerm = resuel.getTeorema().getTeoTerm();
                 //   paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                }
                else{

                    if(teoremaInicialInfo.size() == 1){
                        if (resuelInicial != null)
                          pasoAntTerm = resuelInicial.getTeorema().getTeoTerm();
                        else if (disponeInicial != null)
                          pasoAntTerm = disponeInicial.getMetateorema().getTeoTerm();
                 //       paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                    }
                    else{
                        if(teoremaInicialInfo.get(1).equals("d")){
                            
                            pasoAntTerm = ((App)((App)resuelInicial.getTeorema().getTeoTerm()).p).q;
                   //         paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                        }
                        else if (teoremaInicialInfo.get(1).equals("i")){
                            
                            pasoAntTerm = ((App)resuelInicial.getTeorema().getTeoTerm()).q;
                     //       paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                        }
                        
                    }
                    
                }
                
            }
            else
            {                
                solucion = solucionManager.getSolucion(resuel.getDemopendiente());
                
                if(nuevoMetodo.equals("1")){
                    
                    if(teoremaInicialInfo.size() == 1){
                        if (resuelInicial != null)
                          pasoAntTerm = resuelInicial.getTeorema().getTeoTerm();
                        else if (disponeInicial != null)
                          pasoAntTerm = disponeInicial.getMetateorema().getTeoTerm();
                 //       paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                    }
                    else{
                        if(teoremaInicialInfo.get(1).equals("d")){
                            
                            pasoAntTerm = ((App)((App)resuelInicial.getTeorema().getTeoTerm()).p).q;
                   //         paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                        }
                        else if (teoremaInicialInfo.get(1).equals("i")){
                            
                            pasoAntTerm = ((App)resuelInicial.getTeorema().getTeoTerm()).q;
                     //       paso = new PasoInferencia(pasoAntTerm, izq, der, leibnizTerm, instanciacion);
                        }
                        
                    }
                }
                else{
                    pasoAntTerm = solucion.getTypedTerm();
                }
            }*/

            boolean valida = true;
            Term pasoPostTerm =null;
            Term infer = null;
            boolean exception = false;
            try
            {
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
                }
                catch (TypeVerificationException e)
                {
                    exception = true;
                    throw new TypeVerificationException();
                }
                if (typedTerm.type() == null)
                {
                    try{
                    new TypedApp(new TypedA(new App(new App(new Const(1,"\\equiv ",false,1,1),
                            typedTerm),typedTerm)),infer); // si no da excepcion la inferencia 
                                                             //es valida con respecto a la primera exp
                    }
                    catch (TypeVerificationException e)
                    {
                        new TypedApp(new TypedA(new App(new App(new Const(1,"=",false,1,1),
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
                    if (exception)
                        throw new TypeVerificationException();
                    infer = new TypedApp(new TypedS(infer.type()), infer);
                    if (typedTerm.type() == null)
                    {
                       try {
                         new TypedApp(new TypedA(new App(new App(new Const(1,"\\equiv ",false,1,1),
                            typedTerm),typedTerm)),infer); // si no da excepcion la inferencia 
                                                             //es valida con respecto a la primera exp
                       }
                       catch (TypeVerificationException ex)
                       {
                          new TypedApp(new TypedA(new App(new App(new Const(1,"=",false,1,1),
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
                  pasoPost = "Regla~de~inferencia~no~valida";
                  valida = false;
                }
                catch (ClassCastException ex)
                {
                  pasoPost = "Regla~de~inferencia~no~valida";
                  valida = false;
                }
            }
            
            if (resuel.getDemopendiente() == -1 && valida)
            {
                // paso.setResult(pasoPostTerm);
                // solucion = new Solucion(resuel,false,paso);
                solucion = new Solucion(resuel,false,pasoPostTerm);
                //solucion.setNteoinicial(teoremaInicial);
                solucionManager.addSolucion(solucion);
                nSol = ""+solucion.getId();
                response.setnSol(nSol);
            }
            else if (valida)
            {
                solucion.setTypedTerm(pasoPostTerm);
                solucionManager.updateSolucion(solucion);
            }
            response.setResuelto("0");
            if (valida){
                Term type = pasoPostTerm.type();
                Term teoremaTerm = resuel.getTeorema().getTeoTerm();
                Term pasoPostExp = ((App)((App)type).p).q;
                /*Term expIniTerm = null; 
                if (resuelInicial != null)
                   expIniTerm = resuelInicial.getTeorema().getTeoTerm();
                else if (disponeInicial != null)
                   expIniTerm = disponeInicial.getMetateorema().getTeoTerm();*/
                //String teoremaIniStr = pasoAntTerm.toStringInfFinal();
                //teoremaIniStr = resuelInicial.getTeorema().getTeoTerm().toStringInfFinal();
                    
                Term stTeorema = resuel.getTeorema().getTeoTerm();
                
                if(true/*teoremaInicialInfo.size() == 1*/){//cableado para metodo directo

                    if(stTeorema.equals(expIniTerm)){
                        //buscar en bd
                        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserResuelto(username);
                        Term temp;
                        for(Resuelve resu: resuelves){
                            temp = resu.getTeorema().getTeoTerm();
                            Term mt = new App(new App(new Const("\\equiv"),new Const("true")),resu.getTeorema().getTeoTerm());
                            if(!temp.equals(stTeorema) &&
                                  (temp.equals(pasoPostExp) ||
                                       (mt.equals(pasoPostExp) && !mt.equals(stTeorema))
                                  ) 
                              )
                            {
                           //     response.setResuelto("1");
                                try{
                                  solucion.setTypedTerm(new TypedApp(new TypedApp(new TypedS(type), solucion.getTypedTerm()),new TypedA( ((App)((App)type).p).q))); 
                                  type = solucion.getTypedTerm().type();
                                }
                                catch (TypeVerificationException e){
                                     Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
                                }
                                break;
                            }
                        }
                    }
                    else{
                        if(pasoPostExp.equals(stTeorema)){
                           // response.setResuelto("1");
                            try{
                               solucion.setTypedTerm(new TypedApp(solucion.getTypedTerm(), new TypedA(((App)type).q)));
                               type = solucion.getTypedTerm().type();
                            }
                            catch (TypeVerificationException e){
                               Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
                            }
                        }
                        /*else{
                            response.setResuelto("0");
                        }*/
                    }
                }
                //else{

                if(teoremaTerm.equals(type)){
                        response.setResuelto("1");
                }
                else{
                        response.setResuelto("0");
                }            
                //}

                if(response.getResuelto().equals("1")){
                    solucion.setResuelto(true);
                    resuel.setResuelto(true);
                    resuelveManager.updateResuelve(resuel);
                    solucionManager.updateSolucion(solucion);
                }
            }

            String formula = resuel.getTeorema().getTeoTerm().toStringInf(simboloManager);
            response.generarHistorial(username,formula, nTeo,valida?pasoPostTerm:typedTerm,valida,
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
        String formula = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager);

        response.generarHistorial(username,formula, nTeo,respRetroceder==0?null:solucion.getTypedTerm(),true,resuelveManager,disponeManager,simboloManager);
        if(/*respRetroceder==1 ||*/ respRetroceder==0){
            response.setCambiarMetodo("1");
        }
        else{
            response.setCambiarMetodo("0");
        }
    
        
        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialMD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialMD( @RequestParam(value="teoid") String teoid, @PathVariable String nSol, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();

        Resuelve resuelveAnterior = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelveAnterior.getTeorema().getTeoTerm().toStringInf(simboloManager);
        
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
            Solucion solucion = new Solucion(resuelveAnterior,false,formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));        
            solucion.setTypedTerm(formulaTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,
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
        
        if(!equiv.startsWith("\\equiv") && !equiv.startsWith("=")){
            response.setLado("0");
            return response;
        }
        else{
            response.setLado("1");
        }

        String formulaDer = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).q.toStringInf(simboloManager);
        String formulaIzq = ((App)resuelve.getTeorema().getTeoTerm()).q.toStringInf(simboloManager);
        String operador = ((App)((App)resuelve.getTeorema().getTeoTerm()).p).p.toStringInf(simboloManager);//resuelve.getTeorema().getOperador();
        
        formulaDer = "\\cssId{d}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaDer + "}}}";
        formulaIzq = "\\cssId{i}{\\class{teoremaClick}{\\style{cursor:pointer; color:#08c;}{"+ formulaIzq + "}}}";
        
        String historial = "Theorem "+nTeo+":<br> <center>$"+formulaIzq+"$ $"+ operador +"$ $" + formulaDer + "$</center> Proof: ";
        response.setHistorial(historial);  

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialPL", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialPL(@PathVariable String nSol, @RequestParam(value="lado") String lado, @PathVariable String username, 
            @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager);
        
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
            Solucion solucion = new Solucion(resuelve,false,formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(nSol));        
            solucion.setTypedTerm(formulaTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial); */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialD", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialD(@RequestParam(value="teoSol") String teoSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager);
        
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
            Solucion solucion = new Solucion(resuelve,false,formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(teoSol));        
            solucion.setTypedTerm(formulaTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,
                                      resuelveManager,disponeManager,simboloManager);
        /*String historial = "Theorem "+nTeo+":<br> <center>$"+formulaAnterior+"$</center> Proof:<br><center>$"+formula+"</center>";
        response.setHistorial(historial);  */

        return response;
    }
    
    @RequestMapping(value="/{username}/{nTeo:.+}/{nSol}/teoremaInicialF", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse teoremaInicialF(@RequestParam(value="teoSol") String teoSol, @PathVariable String username, @PathVariable String nTeo)
    {   
        InferResponse response = new InferResponse();
        
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeoNum(username,nTeo);
        String formulaAnterior = resuelve.getTeorema().getTeoTerm().toStringInf(simboloManager);
        
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
            Solucion solucion = new Solucion(resuelve,false,formulaTerm);
            solucionManager.addSolucion(solucion);
            response.setnSol(solucion.getId()+"");
        }
        else
        {
            Solucion solucion = solucionManager.getSolucion(Integer.parseInt(teoSol));        
            solucion.setTypedTerm(formulaTerm);
            solucionManager.updateSolucion(solucion);
        }
        
        response.generarHistorial(username,formulaAnterior, nTeo,formulaTerm,true,
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
