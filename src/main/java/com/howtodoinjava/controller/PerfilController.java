/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.controller;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.Dispone;
import com.howtodoinjava.entity.Materia;
import com.howtodoinjava.entity.Metateorema;
import com.howtodoinjava.entity.Publicacion;
import com.howtodoinjava.entity.PublicacionId;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Simbolo;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.entity.Teoria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.StaticApplicationContext;
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
import com.howtodoinjava.entity.MostrarCategoria;
import com.howtodoinjava.entity.Predicado;
import com.howtodoinjava.entity.PredicadoId;
import com.howtodoinjava.forms.AgregarSimbolo;
import com.howtodoinjava.forms.AgregarTeorema;
import com.howtodoinjava.forms.InferResponse;
import com.howtodoinjava.forms.InfersForm;
import com.howtodoinjava.forms.InsertarEvaluar;
import com.howtodoinjava.forms.ModificarAliasForm;
import com.howtodoinjava.forms.ModificarForm;
import com.howtodoinjava.forms.MostrarCategoriaForm;
import com.howtodoinjava.forms.Registro;
import com.howtodoinjava.forms.UsuarioGuardar;
import com.howtodoinjava.forms.teoremasSolucion;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Brackear;
import com.howtodoinjava.lambdacalculo.Comprobacion;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.Sust;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.UsuarioManager;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.lambdacalculo.Tokenizar;
import com.howtodoinjava.lambdacalculo.TypeVerificationException;
import com.howtodoinjava.lambdacalculo.TypedA;
import com.howtodoinjava.lambdacalculo.TypedApp;
import com.howtodoinjava.lambdacalculo.TypedI;
import com.howtodoinjava.lambdacalculo.TypedS;
import com.howtodoinjava.lambdacalculo.Var;
import com.howtodoinjava.parse.CombUtilities;
import com.howtodoinjava.parse.IsNotInDBException;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.CategoriaManager;
import com.howtodoinjava.service.DisponeManager;
import com.howtodoinjava.service.MateriaManager;
import com.howtodoinjava.service.MetateoremaManager;
import com.howtodoinjava.service.MostrarCategoriaManager;
import com.howtodoinjava.service.PredicadoManager;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SimboloManager;
import com.howtodoinjava.service.SolucionManager;
import com.howtodoinjava.service.TeoremaManager;
import com.howtodoinjava.service.TeoriaManager;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.http.MediaType;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value="/perfil")
public class PerfilController {
    
    @Autowired
    private UsuarioManager usuarioManager;
    @Autowired
    private TerminoManager terminoManager;
    @Autowired
    private PredicadoManager predicadoManager;
    @Autowired
    private SimboloManager simboloManager;
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
    @Autowired
    private MateriaManager materiaManager;
    @Autowired
    private TeoriaManager teoriaManager;
    @Autowired
    private MostrarCategoriaManager mostrarCategoriaManager;
    @Autowired
    private CombUtilities combUtilities;
    
    
    @RequestMapping(value="/{username}/close", method=RequestMethod.GET)
    public String closeSesion(@PathVariable String username, ModelMap map){
        map.addAttribute("usuariolog",new Usuario());
        map.addAttribute("mensaje", "");
        session.removeAttribute("user");
        return "redirect:../../index";
    }
    
    @RequestMapping(value="/{username}/home", method=RequestMethod.GET)
    public String perfilView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        
        map.addAttribute("usuario", usr);
        map.addAttribute("mensaje","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","");        
        map.addAttribute("agregarTeoremaMenu","");        
        map.addAttribute("perfilMenu","active");
        map.addAttribute("students","");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("helpMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1100px");

        return "perfil";
    }
    
    @RequestMapping(value="/{username}/students", method=RequestMethod.GET)
    public String studentsView(@PathVariable String username, ModelMap map){
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        if (!usr.isAdmin()){
            return "redirect:/index";
        }
        
        List<Usuario> studentsList = usuarioManager.getStudents();
        List<Materia> materiasList = materiaManager.getAllMaterias();

        map.addAttribute("studentsList",studentsList);
        map.addAttribute("materiasList",materiasList);
        map.addAttribute("usuario", usr);
        map.addAttribute("mensaje","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","");        
        map.addAttribute("agregarTeoremaMenu","");        
        map.addAttribute("perfilMenu","");
        map.addAttribute("students","active");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("helpMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1100px");
        return "students";
    }
    
    @RequestMapping(value="/{username}/student", method=RequestMethod.GET)
    public String studentView(@RequestParam(value="usr") String login, @PathVariable String username, ModelMap map){
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        if (!usr.isAdmin()){
            return "redirect:/index";
        }
        Usuario student = usuarioManager.getUsuario(login);
        if (student != null)
        {
            map.addAttribute("login",login);
            map.addAttribute("guardarMenu","");
            map.addAttribute("listarTerminosMenu","");
            map.addAttribute("misTeoremasMenu","");        
            map.addAttribute("agregarTeoremaMenu","");        
            map.addAttribute("perfilMenu","");
            map.addAttribute("students","active");
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            map.addAttribute("helpMenu","");
            return "student";
        }
        else
            return "redirect:/index";
    }
    
    @RequestMapping(value="/{username}/editar", method=RequestMethod.GET)
    public String editarView(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        List<Materia> list = materiaManager.getAllMaterias();
        Usuario user = usuarioManager.getUsuario(username);
        map.addAttribute("usuario",user);
        map.addAttribute("registro",new Registro(user.getNombre(), user.getApellido(), 
                                    user.getCorreo(), user.getLogin(), 
                                    user.getMateria().getId(), "", ""));
        map.addAttribute("materias", list);
        map.addAttribute("valueSubmit", "Edit");
        map.addAttribute("isRegistro", "0");
        map.addAttribute("perfilMenu","active");
        map.addAttribute("students","");
        map.addAttribute("helpMenu","");
        map.addAttribute("isAdmin",user.isAdmin()?new Integer(1):new Integer(0));
        return "editPerfil";
    }
    
    @RequestMapping(value="/{username}/editar", method=RequestMethod.POST)
    public String editar(@PathVariable String username, @Valid Registro registro, BindingResult bindingResult, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario user = usuarioManager.getUsuario(username);
        if( bindingResult.hasErrors() )
        {
            if (!registro.getPassword().equals(registro.getPasswordConf()))
               bindingResult.rejectValue("passwordConf","error.registro","The password does not match");
            List<Materia> list = materiaManager.getAllMaterias();
//                map.addAttribute("registro", registro);
            map.addAttribute("usuario",user);
            map.addAttribute("materias", list);
            map.addAttribute("valueSubmit", "Edit");
            map.addAttribute("isRegistro", "0");
            map.addAttribute("perfilMenu","active");
            map.addAttribute("students","");
            map.addAttribute("helpMenu","");
            map.addAttribute("isAdmin",user.isAdmin()?new Integer(1):new Integer(0));
            return "editPerfil";
        }
        else{
            if (!registro.getPassword().equals(registro.getPasswordConf()))
            {
               if (!registro.getPassword().equals(registro.getPasswordConf()))
                  bindingResult.rejectValue("passwordConf","error.registro","The password does not match");
               List<Materia> list = materiaManager.getAllMaterias();
//                  map.addAttribute("registro", registro);
               map.addAttribute("usuario",user);
               map.addAttribute("materias", list);
               map.addAttribute("valueSubmit", "Edit");
               map.addAttribute("isRegistro", "0");
               map.addAttribute("perfilMenu","active");
               map.addAttribute("students","");
               map.addAttribute("helpMenu","");
               map.addAttribute("isAdmin",user.isAdmin()?new Integer(1):new Integer(0));
               return "editPerfil";
            }

            Materia materia = materiaManager.getMateria(registro.getMateriaid());
            String randomchars = "hdfGLd6J4$&(3nd^{bHGF@fs";
            String pass = DigestUtils.sha512Hex(registro.getPassword()+randomchars);
            user.setNombre(registro.getNombre());
            user.setApellido(registro.getApellido());
            user.setCorreo(registro.getCorreo());
            user.setPassword(pass);
            user.setMateria(materia);

            usuarioManager.updateUsuario(user);
        }  
                       
        map.addAttribute("usuario", user);
        map.addAttribute("mensaje","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","");        
        map.addAttribute("agregarTeoremaMenu","");        
        map.addAttribute("perfilMenu","active");
        map.addAttribute("students","");
        map.addAttribute("helpMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1100px");
        map.addAttribute("isAdmin",user.isAdmin()?new Integer(1):new Integer(0));
        return "perfil";
    }
    
    @RequestMapping(value="/{username}/help", method=RequestMethod.GET)
    public String showHelp(@PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario user = usuarioManager.getUsuario(username);

        map.addAttribute("usuario", user);
        map.addAttribute("logout","logout");
        map.addAttribute("sesion","login");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("theoMenu","");
        map.addAttribute("helpMenu","active");
        map.addAttribute("isAdmin",user.isAdmin()?new Integer(1):new Integer(0));

        return "help";
    }
    
    @RequestMapping(value="/{username}/misTeoremas", method=RequestMethod.GET)
    public String misTeoremasView(@PathVariable String username, ModelMap map) {
        if (  ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).isAdmin()) 
           && ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username)) 
           )
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
        /*
        List<Teorema> teoremas = usuarioManager.getAllTeoremas(usuarioManager.getUsuario(username));
        for (Teorema t: teoremas)
        {
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const("\\equiv ",false,1,1),new Const("true ")),t.getTeoTerm()));
        }*/
        Usuario currentUser = (Usuario)session.getAttribute("user");
        Usuario usr = usuarioManager.getUsuario(username);        
        List <Categoria> showCategorias = new LinkedList<Categoria>();
        List<MostrarCategoria> mostrarCategoria = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(currentUser);
        for (int i = 0; i < mostrarCategoria.size(); i++ ){
            showCategorias.add(mostrarCategoria.get(i).getCategoria());
        }
        map.addAttribute("isDifferentUser", !((Usuario)session.getAttribute("user")).getLogin().equals(username)?new Integer(1):new Integer(0));
        map.addAttribute("usuario", usr);
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","active");
        map.addAttribute("agregarTeoremaMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("categorias",categoriaManager.getAllCategorias());
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("teoremas", resuelves);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("categoriaManager",categoriaManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("predicadoManager",predicadoManager);
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        return "misTeoremas";
    }
    
    @RequestMapping(value="/{username}/misTeoremas", method=RequestMethod.POST,produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody String misTeoremasConfigView(@PathVariable String username, ModelMap map,@RequestBody MostrarCategoriaForm answer) {
        if (  ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).isAdmin()) 
           && ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username)) 
           )
        {   
            JsonObject response = new JsonObject();
            response.addProperty("error", "Debes estar logueado en el sistema");
            return response.toString();
        }
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username);
        for (Resuelve r: resuelves)
        {
            Teorema t = r.getTeorema();
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),t.getTeoTerm()));
        }
        Usuario usuario = usuarioManager.getUsuario(answer.getUsername());
        Usuario currentUser = (Usuario)session.getAttribute("user");
        List<MostrarCategoria> mostrarCategorias = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(currentUser);
        List<Integer> categoriasIdListUser =  new LinkedList<Integer>();
        for (MostrarCategoria mc: mostrarCategorias){
           categoriasIdListUser.add(mc.getCategoria().getId());
        }
        for (int categoriaId :answer.getListaIdCategorias()){
            if (!categoriasIdListUser.contains(categoriaId)){
                Categoria categoria = categoriaManager.getCategoria(categoriaId);
                MostrarCategoria mostrarCategoriaNew = new MostrarCategoria(categoria, currentUser);
                mostrarCategoriaManager.addMostrarCategoria(mostrarCategoriaNew);
            }
        }
        for (int categoriaId: categoriasIdListUser){
            if (!answer.getListaIdCategorias().contains(categoriaId)){
                Categoria categoria = categoriaManager.getCategoria(categoriaId);
                MostrarCategoria mostrarCategoria = mostrarCategoriaManager.getMostrarCategoriaByCategoriaAndUsuario(categoria, currentUser);
                mostrarCategoriaManager.deleteMostrarCategoria(mostrarCategoria.getId());
            }
        }
        List<MostrarCategoria> mostrarCategorias1 = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(currentUser);
        JsonObject response = new JsonObject();
        JsonArray categories = new JsonArray();
        for (int i = 0; i < mostrarCategorias1.size(); i ++){
            JsonObject category = new JsonObject();
            category.addProperty("categoryid", mostrarCategorias1.get(i).getCategoria().getId());
            category.addProperty("categoryname",mostrarCategorias1.get(i).getCategoria().getNombre());
            categories.add(category);
        }
        JsonArray resuelves1 = new JsonArray();

        for (int i = 0; i < resuelves.size(); i++){
            JsonObject resuelve = new JsonObject();
            resuelve.addProperty("categoryid", resuelves.get(i).getCategoria().getId());
            resuelve.addProperty("isResuelto", resuelves.get(i).isResuelto());
            resuelve.addProperty("isAxioma", resuelves.get(i).isEsAxioma());
            resuelve.addProperty("numeroteorema", resuelves.get(i).getNumeroteorema());
            resuelve.addProperty("nombreteorema", resuelves.get(i).getNombreteorema());
            resuelve.addProperty("teoremaid", resuelves.get(i).getTeorema().getId());
            resuelve.addProperty("string", resuelves.get(i).getTeorema().getTeoTerm().toStringInf(simboloManager,""));
            resuelve.addProperty("stringNumero", resuelves.get(i).getTeorema().getTeoTerm().toStringInf(simboloManager, resuelves.get(i).getNumeroteorema()));
            resuelve.addProperty("metateoremastring", resuelves.get(i).getTeorema().getMetateoTerm().toStringInfFinal(simboloManager));
            resuelve.addProperty("demopendiente",resuelves.get(i).getDemopendiente());
            resuelves1.add(resuelve);
        }
        response.add("categories", categories);
        response.add("resuelves", resuelves1);
        return response.toString();
    }
    
    @RequestMapping(value="/{username}/misTeoremas/listaSolucion", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody teoremasSolucion listaSoluciones( @RequestParam(value="teoid") int teoid, @PathVariable String username)
    {   
        //validar si esta el usuario en sesion
        teoremasSolucion response = new teoremasSolucion();
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username,teoid);
        Integer resuelveId = resuelve.getId();
        
        response.soluciones = solucionManager.getAllSolucionesIdByResuelve(resuelveId);
        response.setIdTeo(teoid);
        return response;
    }
    
    @RequestMapping(value="/{username}/misTeoremas/buscarFormula", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse buscarFormula( @RequestParam(value="idSol") int idSol,@RequestParam(value="idTeo") int idTeo, @PathVariable String username)
    {   
        // validar que el usuario este en sesion
        InferResponse response = new InferResponse();
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username,idTeo);
        Term teorema = resuelve.getTeorema().getTeoTerm();
        String nTeo = resuelve.getNumeroteorema();
        Solucion solucion = solucionManager.getSolucion(idSol);
        
        //List<PasoInferencia> inferencias = solucion.getArregloInferencias();
        Term typedTerm = solucion.getTypedTerm();
        
        response.generarHistorial(username, teorema, nTeo,typedTerm, true,solucion.getMetodo(), resuelveManager, disponeManager, simboloManager);
        return response;
    }
    
    @RequestMapping(value="/{username}/misTeoremas/buscarMetaFormula", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse buscarMetaFormula(@RequestParam(value="idTeo") int idTeo, @PathVariable String username)
    {
        InferResponse response = new InferResponse();
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username,idTeo);
        Term teo = resuelve.getTeorema().getTeoTerm();
        Term teorema = new App(new App(new Const(1,"\\equiv",false,1,1),new Const("true")),resuelve.getTeorema().getTeoTerm());
        String nTeo = resuelve.getNumeroteorema();
        Term A1 = new TypedA( new App(new App(new Const(1,"\\equiv",false,1,1), new App(new App(new Const(1,"\\equiv ",false,1,1),new Var(112)),new Var(113)) ), new App(new App(new Const(1,"\\equiv",false,1,1),new Var(113)),new Var(112))) );
        Term A2 = new TypedA( new App(new App(new Const(1,"\\equiv",false,1,1),new Var(113)),
                                     new App(new App(new Const(1,"\\equiv",false,1,1),new Var(113)),
                                                               new Const("true"))));
        Term A3 = new TypedA(teo);
        List<Var> list1 = new ArrayList<Var>();
        list1.add(new Var(112));
        list1.add(new Var(113));
        List<Term> list2 = new ArrayList<Term>();
        list2.add(teo);
        list2.add(new Const("true "));
        Term I1 = new TypedI(new Sust(list1,list2));
        
        List<Var> lis1 = new ArrayList<Var>();
        lis1.add(new Var(113));
        List<Term> lis2 = new ArrayList<Term>();
        lis2.add(teo);
        Term I2 = new TypedI(new Sust(lis1,lis2));
        
        Term typedTerm = null;
        try {
          if (teo.equals(new Const("true ")))
            typedTerm = new TypedApp(I2,A2);
          else
            typedTerm = new TypedApp(new TypedApp(I1,A1), new TypedApp(I2,A2));
          typedTerm = new TypedApp(new TypedApp(new TypedS(typedTerm.type()), typedTerm),A3);
        }
        catch (TypeVerificationException e){
            Logger.getLogger(InferController.class.getName()).log(Level.SEVERE, null, e);
        }
        
        response.generarHistorial(username, teorema, nTeo,typedTerm, true,"", resuelveManager, disponeManager, simboloManager);
        return response;
    }
    
    @RequestMapping(value="/{username}/guardarteo", method=RequestMethod.GET)
    public String guardarTeoView(@PathVariable String username,ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimbolo();
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
        map.addAttribute("usuario",usr);
        map.addAttribute("agregarTeorema",new AgregarTeorema());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("teorema","");
        map.addAttribute("categoria",categoriaManager.getAllCategorias());
        map.addAttribute("numeroTeorema","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("agregarTeoremaMenu","active");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
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
            Usuario usr = usuarioManager.getUsuario(username);
            List<Simbolo> simboloList = simboloManager.getAllSimbolo();
            List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
            predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
            String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
            
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usr);
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("agregarTeoremaMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("predicadoList", predicadoList); map.addAttribute("predicadoList", predicadoList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "agregarTeorema";
            }
            
            Usuario user = usuarioManager.getUsuario(username);
            
            PredicadoId predicadoid2=new PredicadoId();
            predicadoid2.setLogin(username);
            
            
            CharStream in = CharStreams.fromString(agregarTeorema.getTeorema());
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            Term teoTerm;
            try //si la sintanxis no es correcta ocurre una Exception
            {

                teoTerm =parser.start_rule(predicadoid2,predicadoManager,simboloManager).value;
//                teoTerm.setAlias(0);
                
                // ESTO DEBE MOSTRAR LAS CATEGORIAS
                Categoria categoria;
                categoria = categoriaManager.getCategoria(new Integer(agregarTeorema.getCategoriaSeleccionada()));
                if (categoria == null) {
                    throw new CategoriaException("Ese numero de categoria no existe");
                }
                // public Teorema(Categoria categoria, String enunciado, Term teoTerm, boolean esquema)
                
                String aliases = teoTerm.aliases("");
                Teorema teoremaAdd = new Teorema(teoTerm.traducBD().toStringFinal(),teoTerm,false,aliases);
                Teorema teorema = teoremaManager.addTeorema(teoremaAdd); 
                Resuelve resuelveAdd = new Resuelve(user,teorema,agregarTeorema.getNombreTeorema(),agregarTeorema.getNumeroTeorema(),agregarTeorema.isAxioma(), categoria);
                Resuelve resuelve = resuelveManager.addResuelve(resuelveAdd);
                

                // public Metateorema(int id, Categoria categoria, String enunciado, byte[] metateoserializado)
                Term metateoTerm = new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),teoTerm);
                Metateorema metateoremaAdd = new Metateorema(teorema.getId(),metateoTerm.traducBD().toStringFinal(),SerializationUtils.serialize(metateoTerm));
                Metateorema metateorema = metateoremaManager.addMetateorema(metateoremaAdd);
                
                Dispone disponeAdd = new Dispone(resuelve.getId(),user,metateorema,agregarTeorema.getNumeroTeorema(),false);
                Dispone dispone = disponeManager.addDispone(disponeAdd);
                     
                map.addAttribute("usuario", usr);
                map.addAttribute("guardarMenu","");
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("agregarTeoremaMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("misTeoremasMenu","");        
                map.addAttribute("agregarTeoremaMenu","");
                map.addAttribute("perfilMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
                map.addAttribute("mensaje", "You cannot enter your theorem because it is invalid");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("agregarTeoremaMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("agregarTeoremaMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1100px");
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "agregarTeorema";
            }
            catch(IsNotInDBException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario", usr);
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("guardarMenu","");
                map.addAttribute("agregarTeoremaMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "agregarTeorema";
            }
            catch(RecognitionException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario", user);
                map.addAttribute("infer",new InfersForm());
                map.addAttribute("mensaje", hdr+" "+msg);
                map.addAttribute("agregarTeorema",agregarTeorema);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("teorema",agregarTeorema.getTeorema());
                map.addAttribute("categoria",categoriaManager.getAllCategorias());
                map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("agregarTeoremaMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
        
        List<Simbolo> simboloList = simboloManager.getAllSimbolo();
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        Usuario usr = usuarioManager.getUsuario(username);
        
        map.addAttribute("usuario", usr);
        map.addAttribute("usuarioGuardar",new UsuarioGuardar());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("termino","");
        map.addAttribute("alias","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("guardarMenu","active");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("students","");
        map.addAttribute("helpMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1100px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        
        return "introducirTermino";
    }
    
    /**
     * Author: Jean
     * This function takes a a list of symbols and returns a javascript dictionary 
     * formated string with the ket/value pair for arguments, precedence and a list of 
     * notation variables
     * @param simboloList symbol list to make the dictionary
     * @return string in dictionary format
     */
    public static String simboloDictionaryCode(List<Simbolo> simboloList, 	List<Predicado> predicadoList) {
    	
    	// List of char where we'll store the answer
    	StringBuilder result = new StringBuilder("{");
    	String idString;
    	String argumentsString;
    	String precedenceString;
    	String simboloString;
    	String notacionVariables;
    	String notacionString;
    	
    	//Add every symbol to the dictionary
    	for (Simbolo simbolo : simboloList) {
			
    		idString = String.valueOf(simbolo.getId());
    		argumentsString = String.valueOf(simbolo.getArgumentos());
    		precedenceString = String.valueOf(simbolo.getPrecedencia());
    		notacionVariables = simbolo.getNotacionVariables().toString();
    		notacionString = simbolo.getNotacion();
    		
    		simboloString = "{ arguments: " + argumentsString + ", precedence: " + precedenceString + ", notacionVariables: " + notacionVariables + "}"; 
    		result.append(idString+":  " + simboloString + ",");
		}
    	
    	precedenceString = "100";
    	//Add every alias to the dictionary
    	for(Predicado alias : predicadoList) {
    		
    		idString = alias.getId().getAlias();
    		argumentsString = String.valueOf(alias.getArgumentos().split(",").length);
    		notacionVariables = alias.getNotacionVariables().toString();
    		notacionString = alias.getNotacion();
    		
    		simboloString = "{ arguments: " + argumentsString + ", precedence: " + precedenceString + ", notacionVariables: " + notacionVariables + ", numericId: -1" +  "}"; 
    		result.append(idString+":  " + simboloString + ",");
    	}
    	result.append('}');
    	return result.toString();
    }
    
    @RequestMapping(value="/{username}/guardar", method=RequestMethod.POST)
    public String guardar(@Valid UsuarioGuardar usuarioGuardar, BindingResult bindingResult, @PathVariable String username, ModelMap map)
    {
            if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
            {
                return "redirect:/index";
            }
            
            Usuario usr = usuarioManager.getUsuario(username);
            List<Simbolo> simboloList = simboloManager.getAllSimbolo();
            List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
            predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
            String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
            //Aqui hay que validar sintaxis se puede hacer como un aspecto con 
            // un @Valid
            //aqui se acomoda la estructura de la entidad Termino ya que en la
            // vista lo que se construyo fue un TerminoId nada mas y se uso el 
            // campo login para guardar el String combinador
            if(bindingResult.hasErrors())
            {   
                map.addAttribute("usuario", usr);
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("termino",usuarioGuardar.getTermino());
                map.addAttribute("alias",usuarioGuardar.getAlias());
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("guardarMenu","active");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("predicadoList", predicadoList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                return "introducirTermino";
            }
            
            
            PredicadoId predicadoid = new PredicadoId();
            Tokenizar tk = new Tokenizar();
            tk.tokenizacion(usuarioGuardar.getAlias());
            String alias=usuarioGuardar.getAlias();
            
            predicadoid.setAlias(tk.getName());//alias);
            predicadoid.setLogin(username);
            Predicado predicado = new Predicado();
            Usuario user=usuarioManager.getUsuario(username);
            predicado.setUsuario(user);
            predicado.setId(predicadoid);
            PredicadoId predicadoid2=new PredicadoId();
            predicadoid2.setLogin(username);
            String programa=usuarioGuardar.getTermino();
            
            //Hay que construir un Term aqui con el String termino.combinador
            //para luego traducir, hace falta construir un parse   
            CharStream in = CharStreams.fromString(programa);
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            Term term;
            try //si la sintanxis no es correcta ocurre una Exception
            {

            
                //aqui hay que hacer un query para verificar que el combinador 
                //es no esta ya en la BD, poner esta verificacion en el dig de sec

                Predicado predicadoEnBD=predicadoManager.getPredicado(predicadoid2); //arreglar solo consigue los tuyos mas no los de admin y publico
                if(predicadoEnBD == null)
                {
                    //System.out.println(terminoManager.getTermino(terminoid));
                    term=parser.start_rule(predicadoid2,predicadoManager,simboloManager).value;
                    predicado.setAliases(term.aliases(""));
                    
                    //term.setAlias(predicadoid.getAlias());
                    //aqui se traduce y luego se llama a toString para tener el
                    //combinador en String
                    
                    //  termino.setSerializado(ToString.toString(term));
                    //verificar si el String combinador existe pero con otro alias
                    Comprobacion comprobar = new Comprobacion();
                    Brackear bk = new Brackear();
                    Term res = bk.appBrack(tk.getVars(), term).traducBD();
                    
                    String check  = comprobar.dfs(res);
                    String resultado;
                    if (check.equals("")) {
                     predicado.setPredicado(res.toStringFinal());
                     Predicado predicado2=predicadoManager.getPredicado(username, predicado.getPredicado());
                     if(predicado2 != null) 
                        throw new AlphaEquivalenceException(predicado2.getId().getAlias());
                     String pos = "";
                     int i = 0;
                     for (String var: tk.getVars())
                     {
                        pos += (i==0?"":", ")+var+"@"+term.position(new Var(var.trim().charAt(0)));
                        i++;
                     }
                     predicado.setArgumentos(pos);
                     predicado.setNotacion(usuarioGuardar.getNotacion());
                     predicadoManager.addPredicado(predicado);
                     resultado  = " 1 Su abreviaci&oacute;n ha sido guardado con exito";
                    }else{
                     resultado = " 2 Su abreviaci&oacute;n usa variables como: "+check +" que no estan especificada";
                    }
                    map.addAttribute("usuarioGuardar", usuarioGuardar);
                    map.addAttribute("modificar",new Integer(0));
                    map.addAttribute("mensaje", resultado);
                    map.addAttribute("usuario", usr);
                    map.addAttribute("guardarMenu","");
                    map.addAttribute("listarTerminosMenu","");
                    map.addAttribute("verTerminosPublicosMenu","");
                    map.addAttribute("misPublicacionesMenu","");
                    map.addAttribute("computarMenu","");
                    map.addAttribute("perfilMenu","active");
                    map.addAttribute("overflow","hidden");
                    map.addAttribute("anchuraDiv","1200px");
                    map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                    map.addAttribute("simboloList", simboloList);
                    map.addAttribute("predicadoList", predicadoList);
                    map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                    return "introducirTermino";
                }
                else
                {

                    map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                    map.addAttribute("usuario",user);
                    map.addAttribute("modificar",new Integer(0));
                    map.addAttribute("mensaje", "Ya existe un t&eacute;rmino en la Base de Datos con este alias: ");
                    map.addAttribute("termino",programa);
                    map.addAttribute("admin","AdminTeoremas");
                    map.addAttribute("alias",alias);
                    map.addAttribute("guardarMenu","active");
                    map.addAttribute("listarTerminosMenu","");
                    map.addAttribute("verTerminosPublicosMenu","");
                    map.addAttribute("misPublicacionesMenu","");
                    map.addAttribute("computarMenu","");
                    map.addAttribute("perfilMenu","");
                    map.addAttribute("overflow","hidden");
                    map.addAttribute("anchuraDiv","1200px");
                    map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                    map.addAttribute("simboloList", simboloList);
                    map.addAttribute("predicadoList", predicadoList);
                    map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
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
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("alias",alias);
                map.addAttribute("guardarMenu","active");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("predicadoList", predicadoList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                return "introducirTermino";
            }
            catch(IsNotInDBException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario",user);
                map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
                map.addAttribute("termino",programa);
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("alias",alias);
                map.addAttribute("guardarMenu","active");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("predicadoList", predicadoList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                return "introducirTermino";
            }
            catch(RecognitionException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario",user);
                map.addAttribute("usuarioGuardar",new UsuarioGuardar());
                map.addAttribute("modificar",new Integer(0));
                map.addAttribute("mensaje", hdr+" "+msg);
                map.addAttribute("termino",programa);
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("alias",alias);
                map.addAttribute("guardarMenu","active");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                map.addAttribute("simboloList", simboloList);
                map.addAttribute("predicadoList", predicadoList);
                map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
                return "introducirTermino";
            }
    }
    
    @RequestMapping(value="/{username}/modificaralias", method=RequestMethod.GET)
    public String modificarAliasView(ModelMap map, @PathVariable String username, @RequestParam("aliasv") String aliasv, @RequestParam("args") String args) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        //map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("usuario", usr);
        map.addAttribute("termino","");
        map.addAttribute("modificarAliasForm",new ModificarAliasForm());
        map.addAttribute("modificar",new Integer(2));
        //if(username.equals("AdminTeoremas"))
        //    map.addAttribute("alias",aliasv+"_");
        //else
            map.addAttribute("alias",aliasv);
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        return "introducirTermino";
    }
    
    @RequestMapping(value="/{username}/modificar", method=RequestMethod.GET)
    public String modificarView(ModelMap map, @PathVariable String username, @RequestParam("alias") String alias, @RequestParam("args") String args) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        //map.addAttribute("usuario", usuarioManager.getUsuario(username));
        PredicadoId id= new PredicadoId();
        id.setAlias(alias);
        id.setLogin(username);
        Predicado p=predicadoManager.getPredicado(id);
        Tokenizar tk = new Tokenizar();
        tk.tokenArgs(p.getArgumentos());
        Term aux = combUtilities.getTerm(p.getPredicado());
        for (String var : tk.getVars()) 
            aux=new App(aux,new Var(var.charAt(0)));
        aux = aux.evaluar();
        String term=aux.toStringInf(simboloManager,"").replace("\\", "\\\\");
        //String termino;
        //termino = term.replace("\\","" ).replace("}", "").replaceAll("[_][{]", "");
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("usuario", usr);
        map.addAttribute("termino",term);
        map.addAttribute("modificarForm",new UsuarioGuardar());
        map.addAttribute("modificar",new Integer(1));
        map.addAttribute("alias","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        
        return "introducirTermino";
    }
    
    @RequestMapping(value="/{username}/modificaralias", method=RequestMethod.POST)
    public String modificarAlias(@Valid ModificarAliasForm modificarAliasForm, BindingResult bindingResult, @PathVariable String username, @RequestParam("aliasv") String aliasv, @RequestParam("args") String args, ModelMap map)
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
            Usuario usr = usuarioManager.getUsuario(username);
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usr);
                map.addAttribute("modificar",new Integer(2));
                map.addAttribute("termino","");
                map.addAttribute("alias",modificarAliasForm.getAlias());
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "introducirTermino";
            }
        
            
            String aliasNuevo=modificarAliasForm.getAlias();
            if(username.equals("AdminTeoremas"))
                aliasNuevo=aliasNuevo.substring(0, aliasNuevo.length()-1);
            PredicadoId nuevo=new PredicadoId();
            PredicadoId anterior=new PredicadoId();
            nuevo.setAlias(aliasNuevo);
            nuevo.setLogin(username);
            anterior.setAlias(aliasv);
            anterior.setLogin(username);
            Usuario u =usuarioManager.getUsuario(username);
            
            
            Predicado predicadoEnBD=null;
            if(!aliasv.equals(aliasNuevo))
                predicadoEnBD=predicadoManager.getPredicado(nuevo); //arreglar solo consigue los tuyos mas no los de admin y publico
            if(predicadoEnBD == null)
            {
                nuevo.setLogin(username);
                predicadoManager.modificarAlias(anterior,nuevo);
                map.addAttribute("mensaje", "Su Alias se ha modificado con exito");
                map.addAttribute("usuario",u);
                map.addAttribute("guardarMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "perfil";
            }
            else
            {
                map.addAttribute("modificarAliasForm",new ModificarAliasForm());
                map.addAttribute("usuario",u);
                map.addAttribute("modificar",new Integer(2));
                map.addAttribute("mensaje", "ya existe un t&eacute;rmino con el alias que usted ha colocado");
                map.addAttribute("termino","");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                if(username.equals("AdminTeoremas"))
                    map.addAttribute("alias",aliasNuevo+"_");
                else
                    map.addAttribute("alias",aliasNuevo);
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                
                return "introducirTermino";
            }
    }
    
    @RequestMapping(value="/{username}/modificar", method=RequestMethod.POST)
    public String modificar(@Valid ModificarForm modificarForm, BindingResult bindingResult, @PathVariable String username, @RequestParam("alias") String alias, @RequestParam("args") String args,ModelMap map)
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
            Usuario usr = usuarioManager.getUsuario(username);
            if(bindingResult.hasErrors())
            {
                map.addAttribute("usuario", usr);
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("termino",modificarForm.getTermino());
                map.addAttribute("alias","");
                map.addAttribute("mensaje", "");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "introducirTermino";
            }
        
            PredicadoId predicadoid=new PredicadoId();
            predicadoid.setAlias(alias);
            predicadoid.setLogin(username);
            Predicado predicado = new Predicado();
            Usuario u =usuarioManager.getUsuario(username);
            predicado.setUsuario(u);
            predicado.setId(predicadoid);
            predicado.setArgumentos(args);
            PredicadoId predicadoid2=new PredicadoId();
            predicadoid2.setLogin(predicadoid.getLogin());
            String programa=modificarForm.getTermino();
            
            //Hay que construir un Term aqui con el String termino.combinador
            //para luego traducir, hace falta construir un parse   
            CharStream in = CharStreams.fromString(programa);
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            Term term;
            try //si la sintanxis no es correcta ocurre una Exception
            {
                term=parser.start_rule(predicadoid2,predicadoManager,simboloManager).value;
                //term.alias=alias;
                //aqui se traduce y luego se llama a toString para tener el
                //combinador en String
                
                Comprobacion comprobar = new Comprobacion();
                Brackear bk = new Brackear();
                Term res = bk.appBrack(args.split(","), term).traducBD();
                String check  = comprobar.dfs(res);
                String resultado;
                if (check.equals("")) {
                    predicado.setPredicado(res.toStringFinal());
                    Predicado predicado2=predicadoManager.getPredicado(username, predicado.getPredicado());
                    if(predicado2 != null && !predicado2.getId().getAlias().equals(alias)) 
                        throw new AlphaEquivalenceException(predicado2.getId().getAlias());
                    predicadoManager.updatePredicado(predicado);
                    resultado  = " 1 Su abreviaci&oacute;n ha sido guardado con exito";
                }else{
                    resultado = " 2 Su abreviaci&oacute;n usa variables como: "+check +" que no estan especificada";
                }

                map.addAttribute("mensaje", "Su t&eacute;rmino se ha modificado con exito");
                map.addAttribute("usuario", usr);
                map.addAttribute("guardarMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("computarMenu","");
                map.addAttribute("perfilMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "perfil";
            }
            catch(AlphaEquivalenceException e)
            {
                map.addAttribute("terminoid",new TerminoId());
                map.addAttribute("usuario",usr);
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("mensaje", "No se puede ingresar su t&eacute;rmino ya que es alpha equivalente al t&eacute;rmino ya existente "+e.alias);
                map.addAttribute("termino",programa);
                map.addAttribute("alias","");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "introducirTermino";
            }
            catch(IsNotInDBException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("terminoid",new TerminoId());
                map.addAttribute("usuario",usr);                
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
                map.addAttribute("termino",programa);
                map.addAttribute("alias","");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                return "introducirTermino";
            }
            catch(RecognitionException e)
            {
                String hdr = parser.getErrorHeader(e);
		String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("terminoid",new TerminoId());
                map.addAttribute("usuario",usr);                
                map.addAttribute("modificar",new Integer(1));
                map.addAttribute("mensaje", hdr+" "+msg);
                map.addAttribute("termino",programa);
                map.addAttribute("alias","");
                map.addAttribute("admin","AdminTeoremas");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("titulo", "My abbreviations");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usr);
        map.addAttribute("predicados", predicadoManager.getAllPredicadosByUser(username));
        map.addAttribute("simboloManager", simboloManager);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        if (comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","listar");
        map.addAttribute("perfil",new Integer(1));
        map.addAttribute("click","no");
        map.addAttribute("publicaciones",new Integer(0));
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","active");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("regex","@[12]*");
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
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("titulo", "Mis Publicaciones");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usr);
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
        map.addAttribute("misPublicacionesMenu","active");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("overflow","scroll");
        map.addAttribute("anchuraDiv","1163px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        return "listar";
    }
    
    @RequestMapping(value="/{username}/listarocult", method=RequestMethod.GET)
    public String listarOcultEdicionView(@PathVariable String username, ModelMap map, @RequestParam("comb") String comb) 
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("titulo", "Mis Abreviaciones");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usr);
        map.addAttribute("predicados", predicadoManager.getAllPredicadosByUser(username));
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        if(comb.equals("y"))
            map.addAttribute("comb", new Integer(1));
        else
            map.addAttribute("comb", new Integer(0));
        map.addAttribute("mensaje","");
        map.addAttribute("accion","listarocult");
        map.addAttribute("perfil",new Integer(0));
        map.addAttribute("click","yes");
        map.addAttribute("regex","@[12]*");
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
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("titulo", "Abreviaciones publicas");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos("publico"));
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
        map.addAttribute("verTerminosPublicosMenu","active");
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
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("titulo", "Abreviaciones publicas");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos("publico"));
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("titulo", "Abreviaciones predefinidas");
        map.addAttribute("publico", "publico");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("yes","yes");
        map.addAttribute("usuario", usuarioManager.getUsuario("publico"));
        map.addAttribute("terminos", terminoManager.getAllTerminos("AdminTeoremas"));
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
        PredicadoId id=new PredicadoId( alias, username);
        predicadoManager.deletePredicado(id);
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
        Usuario usr = usuarioManager.getUsuario(username);
        TerminoId terminoid = new TerminoId(alias,username);
        PublicacionId publicacionId = new PublicacionId(alias.substring(0, alias.length()-1),username);
        TerminoId publicTerminoid = new TerminoId(alias.substring(0, alias.length()-1),"publico");
        Termino termino0 = terminoManager.getTermino(publicTerminoid);
        if(termino0 != null)
        {
            map.addAttribute("titulo", "Mis Abreviaciones");
            map.addAttribute("publico", "publico");
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("usuario", usr);
            map.addAttribute("terminos", terminoManager.getAllTerminos(username));
            map.addAttribute("comb", new Integer(0));
            map.addAttribute("perfil",new Integer(1));
            map.addAttribute("accion","listar");
            map.addAttribute("mensaje", "No se puede publicar su t&eacute;rmino ya que ya existe un t&eacute;rmino p&uacute;blico con el alias "+publicacionId.getAlias());
            map.addAttribute("publicaciones",new Integer(0));
            map.addAttribute("guardarMenu","");
            map.addAttribute("listarTerminosMenu","active");
            map.addAttribute("verTerminosPublicosMenu","");
            map.addAttribute("misPublicacionesMenu","");
            map.addAttribute("computarMenu","");
            map.addAttribute("perfilMenu","");
            map.addAttribute("overflow","scroll");
            map.addAttribute("anchuraDiv","1163px");
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            return "listar";
        }
        Termino termino = terminoManager.getTermino(terminoid);
        Termino termino2 = terminoManager.getCombinador("publico", termino.getCombinador());
        Termino termino3 = terminoManager.getCombinador("AdminTeoremas", termino.getCombinador());
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
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("usuario", usr);
            map.addAttribute("terminos", terminoManager.getAllTerminos(username));
            map.addAttribute("comb", new Integer(0));
            map.addAttribute("perfil",new Integer(1));
            map.addAttribute("accion","listar");
            map.addAttribute("mensaje", "No se puede publicar su t&eacute;rmino ya que es alpha equivalente al t&eacute;rmino p&uacute;blico ya existente "+e.alias);
            map.addAttribute("publicaciones",new Integer(0));
            map.addAttribute("guardarMenu","");
            map.addAttribute("listarTerminosMenu","active");
            map.addAttribute("verTerminosPublicosMenu","");
            map.addAttribute("misPublicacionesMenu","");
            map.addAttribute("computarMenu","");
            map.addAttribute("perfilMenu","");
            map.addAttribute("overflow","scroll");
            map.addAttribute("anchuraDiv","1163px");
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
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
        map.addAttribute("usuario", usr);
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","");
        map.addAttribute("perfilMenu","active");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        return "perfil";
    }
    
    @RequestMapping(value="/{username}/ingresar", method=RequestMethod.GET)
    public String insertarEvaluarView(@PathVariable String username, ModelMap map)
    {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        map.addAttribute("usuario", usr);
        //map.addAttribute("terminoid",new TerminoId());
        map.addAttribute("insertarEvaluar",new InsertarEvaluar());
        map.addAttribute("mensaje","");
        //map.addAttribute("modificar",new Integer(0));
        map.addAttribute("nombre","");
        map.addAttribute("termino","");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("verTerminosPublicosMenu","");
        map.addAttribute("misPublicacionesMenu","");
        map.addAttribute("computarMenu","active");
        map.addAttribute("perfilMenu","");
        map.addAttribute("hrefAMiMismo","href=ingresar#!");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        return "insertarEvaluar";
    }
    
    @RequestMapping(value="/{username}/theo", method=RequestMethod.GET)
    public String TheoriesView(@PathVariable String username, ModelMap map) {
        if (  
            (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username)
                || !((Usuario)session.getAttribute("user")).isAdmin()
            )
        {
            return "redirect:/index";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> listaSimbolos = simboloManager.getAllSimbolo();
        List<Teoria> listaTeorias = teoriaManager.getAllTeoria();
        
        map.addAttribute("usuario", usr);
        map.addAttribute("mensaje","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","");        
        map.addAttribute("agregarTeoremaMenu","");        
        map.addAttribute("perfilMenu","");
        map.addAttribute("theoMenu","active");
        map.addAttribute("students","");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("helpMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1100px");
        map.addAttribute("listaSimbolos",listaSimbolos);
        map.addAttribute("listaTeorias",listaTeorias);
        map.addAttribute("agregarSimbolo",new AgregarSimbolo());
        map.addAttribute("modificarSimbolo",new AgregarSimbolo());
        
        
        return "theories";
    }
    
    @RequestMapping(value="/{username}/theo", method=RequestMethod.POST)
    public String guardarTeoria(@Valid AgregarSimbolo agregarSimbolo, BindingResult bindingResult, @PathVariable String username, ModelMap map)
    {
            if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
            {
                return "redirect:/index";
            }
        Teoria teoria = teoriaManager.getTeoria(agregarSimbolo.getTeoriaid());
        
        if (!agregarSimbolo.isModificar()){
            Simbolo simbolo = new Simbolo(agregarSimbolo.getNotacion_latex(),agregarSimbolo.getArgumentos(),agregarSimbolo.isEsInfijo(),
            agregarSimbolo.getAsociatividad(),agregarSimbolo.getPrecedencia(),agregarSimbolo.getNotacion(), teoria);
            simboloManager.addSimbolo(simbolo);
        }else{
            Simbolo simbolo = simboloManager.getSimbolo(agregarSimbolo.getId());
            simbolo.setNotacion_latex(agregarSimbolo.getNotacion_latex());
            simbolo.setArgumentos(agregarSimbolo.getArgumentos());
            simbolo.setAsociatividad(agregarSimbolo.getAsociatividad());
            simbolo.setEsInfijo(agregarSimbolo.isEsInfijo());
            simbolo.setPrecedencia(agregarSimbolo.getPrecedencia());
            simbolo.setTeoria(teoria);
            simbolo.setNotacion(agregarSimbolo.getNotacion());
            simboloManager.updateSimbolo(simbolo);
        }
        

        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> listaSimbolos = simboloManager.getAllSimbolo();
        List<Teoria> listaTeorias = teoriaManager.getAllTeoria();
        map.addAttribute("usuario", usr);
        map.addAttribute("mensaje","");
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("misTeoremasMenu","");        
        map.addAttribute("agregarTeoremaMenu","");        
        map.addAttribute("perfilMenu","");
        map.addAttribute("theoMenu","active");
        map.addAttribute("students","");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("helpMenu","");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1100px");
        map.addAttribute("listaSimbolos",listaSimbolos);
        map.addAttribute("listaTeorias",listaTeorias);
        map.addAttribute("agregarSimbolo",new AgregarSimbolo());
        map.addAttribute("modificarSimbolo",new AgregarSimbolo());
        return "theories";
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
