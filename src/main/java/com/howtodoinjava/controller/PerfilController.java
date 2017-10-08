/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.controller;

import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.Dispone;
import com.howtodoinjava.entity.Metateorema;
import com.howtodoinjava.entity.Publicacion;
import com.howtodoinjava.entity.PublicacionId;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.entity.Teorema;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.util.SerializationUtils;

import com.howtodoinjava.entity.Usuario;
import com.howtodoinjava.entity.Termino;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.forms.AgregarTeorema;
import com.howtodoinjava.forms.InfersForm;
import com.howtodoinjava.forms.InsertarEvaluar;
import com.howtodoinjava.forms.ModificarAliasForm;
import com.howtodoinjava.forms.ModificarForm;
import com.howtodoinjava.forms.UsuarioGuardar;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Brackear;
import com.howtodoinjava.lambdacalculo.Comprobacion;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.UsuarioManager;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.lambdacalculo.Tokenizar;
import com.howtodoinjava.parse.IsNotInDBException;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.CategoriaManager;
import com.howtodoinjava.service.DisponeManager;
import com.howtodoinjava.service.MetateoremaManager;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SolucionManager;
import com.howtodoinjava.service.TeoremaManager;
import java.util.List;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.springframework.validation.BindingResult;

@Controller
@RequestMapping(value="/perfil")
public class PerfilController {
    
    @Autowired
    private UsuarioManager usuarioManager;
    @Autowired
    private TerminoManager terminoManager;
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
    
    @RequestMapping(value="/{username}/close", method=RequestMethod.GET)
    public String closeSesion(@PathVariable String username, ModelMap map){
        map.addAttribute("usuariolog",new Usuario());
        map.addAttribute("mensaje", "");
        session.removeAttribute("user");
        return "redirect:../../index";
    }
    
    @RequestMapping(value="/{username}", method=RequestMethod.GET)
    public String perfilView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("mensaje","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","");        
        map.addAttribute("agregarTeoremaMenu","");        
        map.addAttribute("perfilMenu","class=\"active\"");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        return "perfil";
    }
    
    @RequestMapping(value="/{username}/misTeoremas", method=RequestMethod.GET)
    public String misTeoremasView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        List<Teorema> teoremas = usuarioManager.getAllTeoremas(usuarioManager.getUsuario(username));
        for (Teorema t: teoremas)
        {
            t.setTeoTerm(new App(new App(new Const("\\equiv "),t.getTeoDerTerm()),t.getTeoIzqTerm()));
            t.setMetateoTerm(new App(new App(new Const("\\equiv "),new Const("true ")),t.getTeoTerm()));
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","class=\"active\"");
        map.addAttribute("agregarTeoremaMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("teoremas", teoremas);
        map.addAttribute("resuelveManager",resuelveManager);
//        map.addAttribute("metateoremas",metateoremaManager);
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        return "misTeoremas";
    }
    
    @RequestMapping(value="/{username}/guardarteo", method=RequestMethod.GET)
    public String guardarTeoView(@PathVariable String username,ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("agregarTeorema",new AgregarTeorema());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("teorema","");
        map.addAttribute("categoria",categoriaManager.getAllCategorias());
        map.addAttribute("numeroTeorema","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","admin");
        map.addAttribute("agregarTeoremaMenu","class=\"active\"");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        
        return "agregarTeorema";
    }
    
        
    @RequestMapping(value="/{username}/guardarteo", method=RequestMethod.POST)
    public String guardar(@Valid AgregarTeorema agregarTeorema, BindingResult bindingResult, @PathVariable String username, ModelMap map)
    {
            if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
            {
                return "redirect:/index";
            }
            //Aqui hay que validar sintaxis se puede hacer como un aspecto con 
            // un @Valid
            //aqui se acomoda la estructura de la entidad Termino ya que en la
            // vista lo que se construyo fue un TerminoId nada mas y se uso el 
            // campo login para guardar el String combinador
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","admin");
                map.addAttribute("agregarTeoremaMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "agregarTeorema";
            }
            
            Usuario user = usuarioManager.getUsuario(username);
            
            TerminoId terminoid2=new TerminoId();
            terminoid2.setLogin(username);
            
            
            ANTLRStringStream in = new ANTLRStringStream(agregarTeorema.getTeorema());
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            Term teoTerm;
            try //si la sintanxis no es correcta ocurre una Exception
            {

                teoTerm =parser.start_rule(terminoid2,terminoManager);
                teoTerm.setAlias(0);
                Term izq = null;
                Term der = null;
                boolean esEq = true;
                Const relation=null;
                
                try {
                    relation = (Const)((App)((App)teoTerm).p).p;
                    esEq = relation.getCon().trim().equals("\\equiv");
                    izq = ((App)teoTerm).q;
                    der = ((App)((App)teoTerm).p).q;
                } 
                catch (java.lang.ClassCastException e) {
                    esEq = false;
                }
                
                if (!esEq){
                    izq = teoTerm;
                    der = new Const("true");
                }
                
                // ESTO DEBE MOSTRAR LAS CATEGORIAS
                Categoria categoria;
                categoria = categoriaManager.getCategoria(new Integer(agregarTeorema.getCategoriaSeleccionada()));
                if (categoria == null) {
                    throw new CategoriaException("Ese numero de categoria no existe");
                }

                Teorema teoremaAdd = new Teorema(categoria,izq.traducBD().toStringFinal(),der.traducBD().toStringFinal(),izq,der,relation.getCon().trim(),false);
                Teorema teorema = teoremaManager.addTeorema(teoremaAdd); 
                Resuelve resuelveAdd = new Resuelve(user,teorema,agregarTeorema.getNombreTeorema(),agregarTeorema.getNumeroTeorema(),agregarTeorema.isAxioma());
                Resuelve resuelve = resuelveManager.addResuelve(resuelveAdd);

                Metateorema metateoremaAdd = new Metateorema(teorema.getId(),categoria,teoTerm.traducBD().toStringFinal(),"true",SerializationUtils.serialize(teoTerm),SerializationUtils.serialize("true"),false);
                Metateorema metateorema = metateoremaManager.addMetateorema(metateoremaAdd);
                
                Dispone disponeAdd = new Dispone(resuelve.getId(),user,metateorema,agregarTeorema.getNumeroTeorema(),false);
                Dispone dispone = disponeManager.addDispone(disponeAdd);
                
//                PasoInferencia paso = new PasoInferencia(teoTerm, null, null, null, "");
//                Solucion solucion = new Solucion(resuelve,paso);
//                solucion.setResuelve(resuelve);
//                solucion.addArregloInferencias(paso);
//                solucionManager.addSolucion(solucion);
//             
//                System.out.println("El serializado es: "+SerializationUtils.serialize(paso));
//                solucion.addArregloInferencias(paso);
//                solucionManager.addSolucion(solucion);
                        
                        
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("mensaje", "Su teorema ha sido guardado con exito");
                map.addAttribute("guardarMenu","");
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("agregarTeoremaMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("misTeoremasMenu","");        
                map.addAttribute("agregarTeoremaMenu","");
                map.addAttribute("perfilMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");

                return "perfil";
            }
            catch(NullPointerException e)
            {
                map.addAttribute("usuario", user);
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("selected",agregarTeorema.getCategoria());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("mensaje", "No se puede ingresar su teorema porque es invalido");
                map.addAttribute("admin","admin");
                map.addAttribute("agregarTeoremaMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "agregarTeorema";
            }
            catch(CategoriaException e)
            {
                map.addAttribute("usuario",user);
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("mensaje", "No se puede ingresar su teorema porque "+e.alias);
                map.addAttribute("admin","admin");
                map.addAttribute("agregarTeoremaMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1100px");
                return "agregarTeorema";
            }
            catch(IsNotInDBException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
                map.addAttribute("admin","admin");
                map.addAttribute("guardarMenu","");
                map.addAttribute("agregarTeoremaMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "agregarTeorema";
            }
            catch(RecognitionException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario", user);
                map.addAttribute("infer",new InfersForm());
                map.addAttribute("mensaje", hdr+" "+msg);
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("admin","admin");
                map.addAttribute("agregarTeoremaMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "agregarTeorema";
            }
    }
        
        
    /**
     *
     * @param username
     * @param map
     * @return
     */
    @RequestMapping(value="/{username}/guardar", method=RequestMethod.GET)
    public String guardarView(@PathVariable String username,ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("usuarioGuardar",new UsuarioGuardar());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("termino","");
        map.addAttribute("alias","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","admin");
        map.addAttribute("guardarMenu","class=\"active\"");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        
        return "introducirTermino";
    }
    
@RequestMapping(value="/{username}/guardar", method=RequestMethod.POST)
    public String guardar(@Valid UsuarioGuardar usuarioGuardar, BindingResult bindingResult, @PathVariable String username, ModelMap map)
    {
            if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
            {
                return "redirect:/index";
            }
            //Aqui hay que validar sintaxis se puede hacer como un aspecto con 
            // un @Valid
            //aqui se acomoda la estructura de la entidad Termino ya que en la
            // vista lo que se construyo fue un TerminoId nada mas y se uso el 
            // campo login para guardar el String combinador
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("termino",usuarioGuardar.getTermino());
                map.addAttribute("alias",usuarioGuardar.getAlias());
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","admin");
                map.addAttribute("guardarMenu","class=\"active\"");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
            
            
            TerminoId terminoid = new TerminoId();
            Tokenizar tk = new Tokenizar();
            tk.tokenizacion(usuarioGuardar.getAlias());
            String alias=usuarioGuardar.getAlias();
            
            terminoid.setAlias(tk.getName());//alias);
            terminoid.setLogin(username);
            Termino termino = new Termino();
            Usuario user=usuarioManager.getUsuario(username);
            termino.setUsuario(user);
            termino.setId(terminoid);
            TerminoId terminoid2=new TerminoId();
            terminoid2.setLogin(username);
            String programa=usuarioGuardar.getTermino();
            
            //Hay que construir un Term aqui con el String termino.combinador
            //para luego traducir, hace falta construir un parse   
            ANTLRStringStream in = new ANTLRStringStream(programa);
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            Term term;
            try //si la sintanxis no es correcta ocurre una Exception
            {

            
                //aqui hay que hacer un query para verificar que el combinador 
                //es no esta ya en la BD, poner esta verificacion en el dig de sec

                Termino terminoEnBD=terminoManager.getTermino(terminoid); //arreglar solo consigue los tuyos mas no los de admin y publico
                if(terminoEnBD == null)
                {
                    //System.out.println(terminoManager.getTermino(terminoid));
                    term=parser.start_rule(terminoid2,terminoManager);
                    
                    term.setAlias(terminoid.getAlias());
                    //aqui se traduce y luego se llama a toString para tener el
                    //combinador en String
                    termino.setTermObject(term);//este metodo serializa de ademas de setear el terminoObject
                    termino.setCombinador(term.traducBD().toStringFinal());
                    Termino termino2=terminoManager.getCombinador(username, termino.getCombinador());
                    if(termino2 != null) 
                        throw new AlphaEquivalenceException(termino2.getId().getAlias());
                    //  termino.setSerializado(ToString.toString(term));
                    //verificar si el String combinador existe pero con otro alias
                    
                    Comprobacion comprobar = new Comprobacion();
                    Brackear bk = new Brackear();
                    Term res = bk.appBrack(tk.getVars(), term);
                    String check  = comprobar.bfs(res.traducBD());
                    String resultado;
                    if (check.equals("")) {
                        resultado  = " 1 Su t&eacute;rmino ha sido guardado con exito";
                    }else{
                        resultado = " 2 Su t&eacute;rmino usa variables como: "+check +" que no estan especificada";
                    }
                    
                    termino.getId().setLogin(username);
                    terminoManager.addTermino(termino);
                    map.addAttribute("usuarioGuardar", usuarioGuardar);
                    map.addAttribute("modificar",new Integer(0));
                    map.addAttribute("mensaje", resultado);
                    map.addAttribute("usuario", usuarioManager.getUsuario(username));
                    map.addAttribute("guardarMenu","");
                    map.addAttribute("listarTerminosMenu","");
                    map.addAttribute("verTerminosPublicosMenu","");
                    map.addAttribute("misPublicacionesMenu","");
                    map.addAttribute("computarMenu","");
                    map.addAttribute("perfilMenu","class=\"active\"");
                    map.addAttribute("overflow","hidden");
                    map.addAttribute("anchuraDiv","1200px");
                    return "introducirTermino";
                }
                else
                {
                    map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                    map.addAttribute("usuario",user);
                    map.addAttribute("modificar",new Integer(0));
                    map.addAttribute("mensaje", "Ya existe un t&eacute;rmino en la Base de Datos con este alias: ");
                    map.addAttribute("termino",programa);
                    map.addAttribute("admin","admin");
                    map.addAttribute("alias",alias);
                    map.addAttribute("guardarMenu","class=\"active\"");
                    map.addAttribute("listarTerminosMenu","");
                    map.addAttribute("verTerminosPublicosMenu","");
                    map.addAttribute("misPublicacionesMenu","");
                    map.addAttribute("computarMenu","");
                    map.addAttribute("perfilMenu","");
                    map.addAttribute("overflow","hidden");
                    map.addAttribute("anchuraDiv","1200px");
                    return "introducirTermino";
                }
            }
            catch(AlphaEquivalenceException e)
            {
                map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                map.addAttribute("usuario",user);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("mensaje", "Su t&eacute;rmino ya existe y es equivalente al t&eacute;rmino "+ e.alias);
                map.addAttribute("termino",programa);
                map.addAttribute("admin","admin");
                map.addAttribute("alias",alias);
                map.addAttribute("guardarMenu","class=\"active\"");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
            catch(IsNotInDBException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario",user);
                map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
                map.addAttribute("termino",programa);
                map.addAttribute("admin","admin");
                map.addAttribute("alias",alias);
                map.addAttribute("guardarMenu","class=\"active\"");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
            catch(RecognitionException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario",user);
                map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("mensaje", hdr+" "+msg);
                map.addAttribute("termino",programa);
                map.addAttribute("admin","admin");
                map.addAttribute("alias",alias);
                map.addAttribute("guardarMenu","class=\"active\"");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
    }
    
    @RequestMapping(value="/{username}/modificaralias", method=RequestMethod.GET)
    public String modificarAliasView(ModelMap map, @PathVariable String username, @RequestParam("aliasv") String aliasv) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        //map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("termino","");
        map.addAttribute("modificarAliasForm",new ModificarAliasForm());
        map.addAttribute("modificar",new Integer(2));
        if(username.equals("admin"))
            map.addAttribute("alias",aliasv+"_");
        else
            map.addAttribute("alias",aliasv);
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","admin");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        
        return "introducirTermino";
    }
    
    @RequestMapping(value="/{username}/modificar", method=RequestMethod.GET)
    public String modificarView(ModelMap map, @PathVariable String username, @RequestParam("alias") String alias) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        //map.addAttribute("usuario", usuarioManager.getUsuario(username));
        TerminoId id= new TerminoId();
        id.setAlias(alias);
        id.setLogin(username);
        Termino t=terminoManager.getTermino(id);
        String term=t.getTermObject().toStringFinal();
        String termino;
        termino = term.replace("\\","" ).replace("}", "").replaceAll("[_][{]", "");
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("termino",termino);
        map.addAttribute("modificarForm",new UsuarioGuardar());
        map.addAttribute("modificar",new Integer(1));
        map.addAttribute("alias","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","admin");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        
        return "introducirTermino";
    }
    
    @RequestMapping(value="/{username}/modificaralias", method=RequestMethod.POST)
    public String modificarAlias(@Valid ModificarAliasForm modificarAliasForm, BindingResult bindingResult, @PathVariable String username, @RequestParam("aliasv") String aliasv, ModelMap map)
    {
            if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
            {
                return "redirect:/index";
            }
            //Aqui hay que validar sintaxis se puede hacer como un aspecto con 
            // un @Valid
        
            //aqui se acomoda la estructura de la entidad Termino ya que en la
            // vista lo que se construyo fue un TerminoId nada mas y se uso el 
            // campo login para guardar el String combinador
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("modificar",new Integer(2));
                map.addAttribute("termino","");
                map.addAttribute("alias",modificarAliasForm.getAlias());
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","admin");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
        
            
            String aliasNuevo=modificarAliasForm.getAlias();
            if(username.equals("admin"))
                aliasNuevo=aliasNuevo.substring(0, aliasNuevo.length()-1);
            TerminoId nuevo=new TerminoId();
            TerminoId anterior=new TerminoId();
            nuevo.setAlias(aliasNuevo);
            nuevo.setLogin(username);
            anterior.setAlias(aliasv);
            anterior.setLogin(username);
            Usuario u =usuarioManager.getUsuario(username);
            
            
            Termino terminoEnBD=null;
            if(!aliasv.equals(aliasNuevo))
                terminoEnBD=terminoManager.getTermino(nuevo); //arreglar solo consigue los tuyos mas no los de admin y publico
            if(terminoEnBD == null)
            {
                nuevo.setLogin(username);
                terminoManager.modificarAlias(anterior,nuevo);
                map.addAttribute("mensaje", "Su Alias se ha modificado con exito");
                map.addAttribute("usuario",u);
                map.addAttribute("guardarMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "perfil";
            }
            else
            {
                map.addAttribute("modificarAliasForm",new ModificarAliasForm());
                map.addAttribute("usuario",u);
                map.addAttribute("modificar",new Integer(2));
                map.addAttribute("mensaje", "ya existe un t&eacute;rmino con el alias que usted ha colocado");
                map.addAttribute("termino","");
                map.addAttribute("admin","admin");
                if(username.equals("admin"))
                    map.addAttribute("alias",aliasNuevo+"_");
                else
                    map.addAttribute("alias",aliasNuevo);
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
    }
    
    @RequestMapping(value="/{username}/modificar", method=RequestMethod.POST)
    public String modificar(@Valid ModificarForm modificarForm, BindingResult bindingResult, @PathVariable String username, @RequestParam("alias") String alias, ModelMap map)
    {
            if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
            {
                return "redirect:/index";
            }
            //Aqui hay que validar sintaxis se puede hacer como un aspecto con 
            // un @Valid
        
            //aqui se acomoda la estructura de la entidad Termino ya que en la
            // vista lo que se construyo fue un TerminoId nada mas y se uso el 
            // campo login para guardar el String combinador
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("termino",modificarForm.getTermino());
                map.addAttribute("alias","");
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","admin");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
        
            TerminoId terminoid=new TerminoId();
            terminoid.setAlias(alias);
            terminoid.setLogin(username);
            Termino termino = new Termino();
            Usuario u =usuarioManager.getUsuario(username);
            termino.setUsuario(u);
            termino.setId(terminoid);
            TerminoId terminoid2=new TerminoId();
            terminoid2.setLogin(terminoid.getLogin());
            String programa=modificarForm.getTermino();
            
            //Hay que construir un Term aqui con el String termino.combinador
            //para luego traducir, hace falta construir un parse   
            ANTLRStringStream in = new ANTLRStringStream(programa);
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            Term term;
            try //si la sintanxis no es correcta ocurre una Exception
            {
                term=parser.start_rule(terminoid2,terminoManager);
                term.alias=alias;
                //aqui se traduce y luego se llama a toString para tener el
                //combinador en String
                termino.setTermObject(term);//este metodo serializa de ademas de setear el terminoObject
                termino.setCombinador(term.traducBD().toStringFinal());
                
            
                //verificar si el String combinador existe pero con otro alias
                Termino termino2=terminoManager.getCombinador(username, termino.getCombinador());
                //revisar si la instruccion de arriva arroja una excepcion para diferenciarla de las del parse
                if(termino2 != null) 
                {
                    if(!termino2.getId().getAlias().equals(alias))
                        throw new AlphaEquivalenceException(termino2.getId().getAlias());
                }

                terminoManager.modificarTermino(termino);
                map.addAttribute("mensaje", "Su t&eacute;rmino se ha modificado con exito");
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("guardarMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","class=\"active\"");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "perfil";
            }
            catch(AlphaEquivalenceException e)
            {
                map.addAttribute("terminoid",new TerminoId());
                map.addAttribute("usuario",usuarioManager.getUsuario(username));
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("mensaje", "No se puede ingresar su t&eacute;rmino ya que es alpha equivalente al t&eacute;rmino ya existente "+e.alias);
                map.addAttribute("termino",programa);
                map.addAttribute("alias","");
                map.addAttribute("admin","admin");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
            catch(IsNotInDBException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("terminoid",new TerminoId());
                map.addAttribute("usuario",usuarioManager.getUsuario(username));                
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
                map.addAttribute("termino",programa);
                map.addAttribute("alias","");
                map.addAttribute("admin","admin");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
            catch(RecognitionException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("terminoid",new TerminoId());
                map.addAttribute("usuario",usuarioManager.getUsuario(username));                
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("mensaje", hdr+" "+msg);
                map.addAttribute("termino",programa);
                map.addAttribute("alias","");
                map.addAttribute("admin","admin");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                return "introducirTermino";
            }
    }
    
    @RequestMapping(value="/{username}/listar", method=RequestMethod.GET)
    public String listarView(@PathVariable String username, ModelMap map, @RequestParam("comb") String comb) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }    
        map.addAttribute("titulo", "Mis Abreviaciones");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","admin");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("terminos", terminoManager.getAllTerminos(username));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","listar");
        map.addAttribute("perfil",new Integer(1));
        map.addAttribute("click","no");
        map.addAttribute("publicaciones",new Integer(0));
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","class=\"active\"");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("overflow","scroll");
        map.addAttribute("anchuraDiv","1163px");
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/mispublic", method=RequestMethod.GET)
    public String misPublicacionesView(@PathVariable String username, ModelMap map, @RequestParam("comb") String comb) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("titulo", "Mis Publicaciones");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","admin");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("terminos", terminoManager.getAllPublicaciones(username));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","mispublic");
        map.addAttribute("perfil",new Integer(1));
        map.addAttribute("click","no");
        map.addAttribute("publicaciones",new Integer(1));
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","class=\"active\"");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("overflow","scroll");
        map.addAttribute("anchuraDiv","1163px");
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/listarocult", method=RequestMethod.GET)
    public String listarOcultEdicionView(@PathVariable String username, ModelMap map, @RequestParam("comb") String comb) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("titulo", "Mis Abreviaciones");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","admin");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos(username));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","listarocult");
        map.addAttribute("perfil",new Integer(0));
        map.addAttribute("click","yes");
        map.addAttribute("publicaciones",new Integer(0));
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/publico", method=RequestMethod.GET)
    public String listarView(ModelMap map, @RequestParam("comb") String comb, @PathVariable String username) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("titulo", "Abreviaciones publicas");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","admin");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos("publico"));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","publico");
        map.addAttribute("perfil",new Integer(1));
        map.addAttribute("click","no");
        map.addAttribute("publicaciones",new Integer(0));
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","class=\"active\"");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("overflow","scroll");
        map.addAttribute("anchuraDiv","1163px");
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/publiconoclick", method=RequestMethod.GET)
    public String listarViewNoClick(ModelMap map, @RequestParam("comb") String comb, @PathVariable String username) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("titulo", "Abreviaciones publicas");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","admin");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos("publico"));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","publiconoclick");
        map.addAttribute("perfil",new Integer(0));
        map.addAttribute("click","yes");
        map.addAttribute("publicaciones",new Integer(0));
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/predef", method=RequestMethod.GET)
    public String predefView(ModelMap map, @RequestParam("comb") String comb, @PathVariable String username) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("titulo", "Abreviaciones predefinidas");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","admin");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos("admin"));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","predef");
        map.addAttribute("perfil",new Integer(0));
        map.addAttribute("click","yes");
        map.addAttribute("publicaciones",new Integer(0));
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/eliminar", 
            method=RequestMethod.GET)
    public String eliminarTermino(@PathVariable String username, ModelMap map, @RequestParam("alias") String alias)
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        TerminoId id=new TerminoId( alias, username);
        terminoManager.deleteTermino(id);
        return "redirect:../../perfil/"+username+"/listar?comb=n";
    }
    
    @RequestMapping(value="/{username}/eliminarpubl", 
            method=RequestMethod.GET)
    public String eliminarPublicacion(@PathVariable String username, ModelMap map, @RequestParam("alias") String alias)
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        TerminoId id=new TerminoId( alias, username);
        terminoManager.deletePublicacion(id);
        return "redirect:../../perfil/"+username+"/mispublic?comb=n";
    }
    
    @RequestMapping(value="/{username}/publicar", method=RequestMethod.GET)
    public String publicarTermino(@PathVariable String username, ModelMap map, @RequestParam("alias") String alias)
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        TerminoId terminoid = new TerminoId(alias,username);
        PublicacionId publicacionId = new PublicacionId(alias.substring(0, alias.length()-1),username);
        TerminoId publicTerminoid = new TerminoId(alias.substring(0, alias.length()-1),"publico");
        Termino termino0 = terminoManager.getTermino(publicTerminoid);
        if(termino0 != null)
        {
            map.addAttribute("titulo", "Mis Abreviaciones");
            map.addAttribute("publico", "publico");
            map.addAttribute("admin","admin");
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            map.addAttribute("terminos", terminoManager.getAllTerminos(username));
            map.addAttribute("comb", new Integer(0));
            map.addAttribute("perfil",new Integer(1));
            map.addAttribute("accion","listar");
            map.addAttribute("mensaje", "No se puede publicar su t&eacute;rmino ya que ya existe un t&eacute;rmino p&uacute;blico con el alias "+publicacionId.getAlias());
            map.addAttribute("publicaciones",new Integer(0));
            map.addAttribute("guardarMenu","");
            map.addAttribute("listarTerminosMenu","class=\"active\"");
            map.addAttribute("verTerminosPublicosMenu","");
            map.addAttribute("misPublicacionesMenu","");
            map.addAttribute("computarMenu","");
            map.addAttribute("perfilMenu","");
            map.addAttribute("overflow","scroll");
            map.addAttribute("anchuraDiv","1163px");
            return "listar";
        }
        Termino termino = terminoManager.getTermino(terminoid);
        Termino termino2 = terminoManager.getCombinador("publico", termino.getCombinador());
        Termino termino3 = terminoManager.getCombinador("admin", termino.getCombinador());
        try{
            if(termino2 != null)
                throw new AlphaEquivalenceException(termino2.getId().getAlias());
            else if(termino3 != null)
                throw new AlphaEquivalenceException(termino3.getId().getAlias());
        }
        catch(AlphaEquivalenceException e)
        {
            map.addAttribute("titulo", "Mis Abreviaciones");
            map.addAttribute("publico", "publico");
            map.addAttribute("admin","admin");
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            map.addAttribute("terminos", terminoManager.getAllTerminos(username));
            map.addAttribute("comb", new Integer(0));
            map.addAttribute("perfil",new Integer(1));
            map.addAttribute("accion","listar");
            map.addAttribute("mensaje", "No se puede publicar su t&eacute;rmino ya que es alpha equivalente al t&eacute;rmino p&uacute;blico ya existente "+e.alias);
            map.addAttribute("publicaciones",new Integer(0));
            map.addAttribute("guardarMenu","");
            map.addAttribute("listarTerminosMenu","class=\"active\"");
            map.addAttribute("verTerminosPublicosMenu","");
            map.addAttribute("misPublicacionesMenu","");
            map.addAttribute("computarMenu","");
            map.addAttribute("perfilMenu","");
            map.addAttribute("overflow","scroll");
            map.addAttribute("anchuraDiv","1163px");
            return "listar";
        }
        PublicacionId publicacionId2 = new PublicacionId(alias.substring(0, alias.length()-1),username);
        Publicacion publicacion = new Publicacion(publicacionId2, usuarioManager.getUsuario(username));
        Termino terminoPublico=new Termino();
        TerminoId publicTerminoid2 = new TerminoId(alias.substring(0, alias.length()-1),"publico");
        terminoPublico.setId(publicTerminoid2);
        terminoPublico.setCombinador(termino.getCombinador());
        Term cambioDeAlias = termino.getTermObject();
        cambioDeAlias.setAlias(alias.substring(0, alias.length()-1));
        terminoPublico.setTermObject(cambioDeAlias);
        terminoPublico.setUsuario(usuarioManager.getUsuario("publico"));
        terminoManager.addPublicacion(terminoPublico,publicacion);
        map.addAttribute("mensaje", "Su t&eacute;rmino ha sido publicado con exito");
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","class=\"active\"");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        
        return "perfil";
    }
    
    @RequestMapping(value="/{username}/ingresar", method=RequestMethod.GET)
    public String insertarEvaluarView(@PathVariable String username, ModelMap map)
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        //map.addAttribute("terminoid",new TerminoId());
        map.addAttribute("insertarEvaluar",new InsertarEvaluar());
        map.addAttribute("mensaje","");
        //map.addAttribute("modificar",new Integer(0));
        map.addAttribute("nombre","");
        map.addAttribute("termino","");
        map.addAttribute("admin","admin");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","class=\"active\"");
        map.addAttribute("perfilMenu","");
        map.addAttribute("hrefAMiMismo","href=ingresar#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        
        return "insertarEvaluar";
    }
    
    public void setUsuarioManager(UsuarioManager usuarioManager) 
    {
            this.usuarioManager = usuarioManager;
    }
    
    public void setTerminoManager(TerminoManager terminoManager) 
    {
            this.terminoManager = terminoManager;
    }

    private static class AlphaEquivalenceException extends Exception
    {

        public String alias;
                
        public AlphaEquivalenceException(String ali) 
        {
            alias=ali;
        }
    }
    
    public static class TeoremaException extends Exception
    {

        public String alias;
                
        public TeoremaException(String ali) 
        {
            alias=ali;
        }
    }

     
    private static class CategoriaException extends Exception
    {

        public String alias;
                
        public CategoriaException(String ali) 
        {
            alias=ali;
        }
    }   
}
