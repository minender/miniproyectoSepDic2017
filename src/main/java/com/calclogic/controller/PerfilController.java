/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.controller;
import com.calclogic.entity.Categoria;
import com.calclogic.entity.Materia;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import com.calclogic.entity.Teoria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.calclogic.entity.Usuario;
import com.calclogic.entity.TerminoId;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.Predicado;
import com.calclogic.entity.PredicadoId;
import com.calclogic.forms.AgregarCategoria;
import com.calclogic.forms.AgregarSimbolo;
import com.calclogic.forms.AgregarTeorema;
import com.calclogic.forms.InferResponse;
import com.calclogic.forms.InfersForm;
import com.calclogic.forms.InsertarEvaluar;
import com.calclogic.forms.ModificarAliasForm;
import com.calclogic.forms.ModificarForm;
import com.calclogic.forms.MostrarCategoriaForm;
import com.calclogic.forms.Registro;
import com.calclogic.forms.UsuarioGuardar;
import com.calclogic.forms.teoremasSolucion;
import com.calclogic.lambdacalculo.App;
import com.calclogic.lambdacalculo.Brackear;
import com.calclogic.lambdacalculo.Comprobacion;
import com.calclogic.lambdacalculo.Const;
import com.calclogic.lambdacalculo.Sust;
import com.calclogic.service.TerminoManager;
import com.calclogic.service.UsuarioManager;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.lambdacalculo.Tokenizar;
import com.calclogic.lambdacalculo.TypeVerificationException;
import com.calclogic.lambdacalculo.TypedA;
import com.calclogic.lambdacalculo.TypedApp;
import com.calclogic.lambdacalculo.TypedI;
import com.calclogic.lambdacalculo.TypedS;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.IsNotInDBException;
import com.calclogic.parse.ProofMethodUtilities;
import com.calclogic.parse.TermLexer;
import com.calclogic.parse.TermParser;
import com.calclogic.proof.CrudOperations;
import com.calclogic.service.CategoriaManager;
import com.calclogic.service.DisponeManager;
import com.calclogic.service.MateriaManager;
import com.calclogic.service.MetateoremaManager;
import com.calclogic.service.MostrarCategoriaManager;
import com.calclogic.service.PredicadoManager;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import com.calclogic.service.SolucionManager;
import com.calclogic.service.TeoremaManager;
import com.calclogic.service.TeoriaManager;
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
    private CrudOperations crudOp;
    //@Autowired
    //private CombUtilities combUtilities;
    
    
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
        List<Teoria> teorias = teoriaManager.getAllTeoria();
        
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
        map.addAttribute("teorias", teorias);

        return "perfil";
    }
    
    @ResponseBody
    @RequestMapping(value="/{username}/home/changeTheory/{teoriaid}", method=RequestMethod.POST)
    public String changeTeoria(@PathVariable String username, @PathVariable String teoriaid, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "Session expired, login again";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        
        int tid = Integer.parseInt(teoriaid);
        Teoria teoria = teoriaManager.getTeoria(tid);
        usr.setTeoria(teoria);
        usuarioManager.updateUsuario(usr);

        return "Theory changed to "+teoria.getNombre();
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
        map.addAttribute("teorias", teoriaManager.getAllTeoria());
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
        map.addAttribute("proveMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("theoMenu","");
        map.addAttribute("helpMenu","active");
        map.addAttribute("isAdmin",user.isAdmin()?new Integer(1):new Integer(0));

        return "help";
    }
    
    @RequestMapping(value="/{username}/myTheorems", method=RequestMethod.GET)
    public String myTheoremsView(@PathVariable String username, ModelMap map) {
        if (  ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).isAdmin()) 
           && ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username)) 
           )
        {
            return "redirect:/index";
        }
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username, true);
        for (Resuelve r: resuelves){
            Teorema t = r.getTeorema();
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),t.getTeoTerm()));
        }
        Usuario currentUser = (Usuario)session.getAttribute("user");
        Usuario usr = usuarioManager.getUsuario(username);        
        List <Categoria> showCategorias = new LinkedList<>();
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
        map.addAttribute("categorias",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("resuelves", resuelves);
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("categoriaManager",categoriaManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("predicadoManager",predicadoManager);
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");

        return "myTheorems";
    }

    /* 
     * Used to store the new checked categories in the database and to show them in the Prove 
     * or in the My Theorems view again (Ex: Equivalence and True, etc.)
     *
     * @return The "theoremsListProve" or the "theoremsListMyTheorems" view, with the categories updated.
     */
    @RequestMapping(value="/{username}/theoremsList", method=RequestMethod.POST)
    public String theoremsListController(@PathVariable String username, ModelMap map, @RequestBody MostrarCategoriaForm answer) {
        if (  ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).isAdmin()) 
           && ((Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username)) 
           )
        {
            return "redirect:/index";
        }
        List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol(username, true);
        for (Resuelve r: resuelves){
            Teorema t = r.getTeorema();
            t.setTeoTerm(t.getTeoTerm());
            t.setMetateoTerm(new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),t.getTeoTerm()));
        }
        Usuario currentUser = (Usuario)session.getAttribute("user");
        Usuario usr = usuarioManager.getUsuario(username);        
        List <Categoria> showCategorias = new LinkedList<>();
        List<MostrarCategoria> mostrarCategorias = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(currentUser);
        List<Integer> categoriasIdListUser =  new LinkedList<>();

        for (MostrarCategoria mc: mostrarCategorias){
           categoriasIdListUser.add(mc.getCategoria().getId());
        }
        // We add the new categories that were checked
        for (int categoriaId :answer.getListaIdCategorias()){
            if (!categoriasIdListUser.contains(categoriaId)){
                Categoria categoria = categoriaManager.getCategoria(categoriaId);
                MostrarCategoria mostrarCategoriaNew = new MostrarCategoria(categoria, currentUser);
                mostrarCategoriaManager.addMostrarCategoria(mostrarCategoriaNew);
            }
        }
        // We delete the categories that were unchecked
        for (int categoriaId: categoriasIdListUser){
            if (!answer.getListaIdCategorias().contains(categoriaId)){
                Categoria categoria = categoriaManager.getCategoria(categoriaId);
                MostrarCategoria mostrarCategoria = mostrarCategoriaManager.getMostrarCategoriaByCategoriaAndUsuario(categoria, currentUser);
                mostrarCategoriaManager.deleteMostrarCategoria(mostrarCategoria);
            }
        }
        
        mostrarCategorias = mostrarCategoriaManager.getAllMostrarCategoriasByUsuario(currentUser);
        for (int i = 0; i < mostrarCategorias.size(); i++ ){
            showCategorias.add(mostrarCategorias.get(i).getCategoria());
        }

        map.addAttribute("isDifferentUser", !((Usuario)session.getAttribute("user")).getLogin().equals(username)?new Integer(1):new Integer(0));
        map.addAttribute("usuario", usr);
        map.addAttribute("guardarMenu","");
        map.addAttribute("listarTerminosMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("resuelveManager",resuelveManager);
        map.addAttribute("categoriaManager",categoriaManager);
        map.addAttribute("simboloManager",simboloManager);
        map.addAttribute("predicadoManager",predicadoManager);
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("selecTeo",answer.getSelecTeo());
        map.addAttribute("showCategorias",showCategorias);
        map.addAttribute("resuelves", resuelves);
        
        if ("prove".equals(answer.getCurrentView())){
            return "theoremsList/theoremsListProve";
        }
        return "theoremsList/theoremsListMyTheorems";  
    }
    
    @RequestMapping(value="/{username}/myTheorems/listaSolucion", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody teoremasSolucion listaSoluciones( @RequestParam(value="teoid") int teoid, @PathVariable String username)
    {   
        //validar si esta el usuario en sesion
        teoremasSolucion response = new teoremasSolucion();
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username,teoid,false);
        Integer resuelveId = resuelve.getId();
        
        response.soluciones = solucionManager.getAllSolucionesIdByResuelve(resuelveId);
        response.setIdTeo(teoid);
        return response;
    }
    
    @RequestMapping(value="/{username}/myTheorems/buscarFormula", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse buscarFormula( @RequestParam(value="idSol") int idSol,@RequestParam(value="idTeo") int idTeo, @PathVariable String username)
    {   
        InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);
        try{
            // Validate that the user is in session
            Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username,idTeo,false);
            Term teorema = resuelve.getTeorema().getTeoTerm().evaluar(resuelve.getVariables());//.setToPrinting(resuelve.getVariables(),simboloManager);
            String nTeo = resuelve.getNumeroteorema();
            Solucion solucion = solucionManager.getSolucion(idSol,username);

            Term typedTerm = solucion.getTypedTerm();

            response.generarHistorial(username, teorema, nTeo,typedTerm, true,false,ProofMethodUtilities.getTerm(solucion.getMetodo()));
            return response;
        }
        catch(Exception e){
            return response;
        }
    }
    
    @RequestMapping(value="/{username}/myTheorems/buscarMetaFormula", method=RequestMethod.POST, produces= MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody InferResponse buscarMetaFormula(@RequestParam(value="idTeo") int idTeo, @PathVariable String username)
    {
        InferResponse response = new InferResponse(crudOp, resuelveManager, disponeManager, simboloManager);
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username,idTeo,false);
        Term teo = resuelve.getTeorema().getTeoTerm();
        Simbolo s = simboloManager.getSimbolo(1);
        Simbolo s2 = simboloManager.getSimbolo(8);
        Term teorema = new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new Const(8,"c_{8}",!s2.isEsInfijo(),s2.getPrecedencia(),s2.getAsociatividad())),resuelve.getTeorema().getTeoTerm());
        String nTeo = resuelve.getNumeroteorema();
        Term A1 = new TypedA( new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()), new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new Var(112)),new Var(113)) ), new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new Var(113)),new Var(112))) );
        Term A2 = new TypedA( new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new Var(113)),
                                     new App(new App(new Const(1,"c_{1}",!s.isEsInfijo(),s.getPrecedencia(),s.getAsociatividad()),new Var(113)),
                                                               new Const(8,"c_{8}",!s2.isEsInfijo(),s2.getPrecedencia(),s2.getAsociatividad()))));
        Term A3 = new TypedA(teo);
        List<Var> list1 = new ArrayList<>();
        list1.add(new Var(112));
        list1.add(new Var(113));
        List<Term> list2 = new ArrayList<>();
        list2.add(teo);
        list2.add(new Const(8,"c_{8}",!s2.isEsInfijo(),s2.getPrecedencia(),s2.getAsociatividad()));
        Term I1 = new TypedI(new Sust(list1,list2));
        
        List<Var> lis1 = new ArrayList<>();
        lis1.add(new Var(113));
        List<Term> lis2 = new ArrayList<>();
        lis2.add(teo);
        Term I2 = new TypedI(new Sust(lis1,lis2));
        Term typedTerm = null;
        try {
            if (teo.equals(new Const(8,"c_{8}",!s2.isEsInfijo(),s2.getPrecedencia(),s2.getAsociatividad()))){
                typedTerm = new TypedApp(I2,A2);
            }
            else{
                typedTerm = new TypedApp(new TypedApp(I1,A1), new TypedApp(I2,A2));
            }
            typedTerm = new TypedApp(new TypedApp(new TypedS(), typedTerm),A3);
        }
        catch (TypeVerificationException e){
            Logger.getLogger(PerfilController.class.getName()).log(Level.SEVERE, null, e);
        }
        
        response.generarHistorial(username, teorema, nTeo,typedTerm, true,false,new Const("DM"));
        return response;
    }
    
    @RequestMapping(value="/{username}/guardarcat", method=RequestMethod.GET)
    public String guardarCatView(@PathVariable String username,ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
        map.addAttribute("usuario",usr);
        map.addAttribute("agregarCategoria",new AgregarCategoria());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("teorema","");
        map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
        map.addAttribute("numeroTeorema","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("teorias", teoriaManager.getAllTeoria());
        map.addAttribute("catMenu", "active");
        
        return "agregarCategoria";
    }
    
    @RequestMapping(value="/{username}/guardarcat", method=RequestMethod.POST)
    public String guardarCatViewPOST(@Valid AgregarCategoria agregarCategoria, BindingResult bindingResult, @PathVariable String username, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
        Categoria cat = new Categoria(agregarCategoria.getNombre(), teoriaManager.getTeoria(agregarCategoria.getTeoriaid()));
        categoriaManager.addCategoria(cat);
        
        map.addAttribute("usuario",usr);
        map.addAttribute("agregarCategoria",new AgregarCategoria());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("teorema","");
        map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
        map.addAttribute("numeroTeorema","");
        map.addAttribute("mensaje", "");
        map.addAttribute("admin","AdminTeoremas");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("simboloList", simboloList);
        map.addAttribute("predicadoList", predicadoList);
        map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        map.addAttribute("teorias", teoriaManager.getAllTeoria());
        map.addAttribute("catMenu", "active");
        
        return "perfil";
    }
    
    @RequestMapping(value="/{username}/guardarteo", method=RequestMethod.GET)
    public String guardarTeoView(@PathVariable String username,ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
        map.addAttribute("usuario",usr);
        map.addAttribute("agregarTeorema",new AgregarTeorema());
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("teorema","");
        map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
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
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
        boolean nTheoExists = false;
        if (resuelveManager.getResuelveByUserAndTeoNum(username, agregarTeorema.getNumeroTeorema(),false) != null)
            nTheoExists = true;
        
        if(nTheoExists || bindingResult.hasErrors()){
            map.addAttribute("usuario", usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
            map.addAttribute("mensaje", "");
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("agregarTeoremaMenu","active");
            map.addAttribute("overflow","hidden");
            map.addAttribute("anchuraDiv","1200px");
            map.addAttribute("simboloList", simboloList);
            if (nTheoExists)
                bindingResult.rejectValue("numeroTeorema","error.agregarTeorema","Theorem number already exists");
            map.addAttribute("predicadoList", predicadoList); map.addAttribute("predicadoList", predicadoList);
            map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            return "agregarTeorema";
        }
        
        Usuario user = usuarioManager.getUsuario(username);
        
        PredicadoId predicadoid2 = new PredicadoId();
        predicadoid2.setLogin(username);
        
        CharStream in = CharStreams.fromString(agregarTeorema.getTeorema());
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        Term teoTerm;
        try{ //si la sintanxis no es correcta ocurre una Exception
            String[] boundVars = {""};
            String freeVars;
            teoTerm = parser.start_rule(predicadoid2,predicadoManager,simboloManager,boundVars).value;
            freeVars = teoTerm.stFreeVars();
            String variables = boundVars[0] + ";" + freeVars;
            teoTerm = teoTerm.toEquality(freeVars);
            
            teoTerm.getType(simboloManager);
            
            Resuelve test = resuelveManager.getResuelveByUserAndTeorema(username, teoTerm.traducBD().toString(), false);
            if (null != test) {
                throw new CategoriaException("An equal one already exists in "+test.getNumeroteorema());
            }
            // ESTO DEBE MOSTRAR LAS CATEGORIAS
            Categoria categoria;
            categoria = categoriaManager.getCategoria(new Integer(agregarTeorema.getCategoriaSeleccionada()));
            if (categoria == null) {
                throw new CategoriaException("That category number does not exist");
            }
            // public Teorema(Categoria categoria, String enunciado, Term teoTerm, boolean esquema)
            
            String aliases = teoTerm.aliases("");
            Teorema teoremaAdd = teoremaManager.getTeoremaByEnunciados(teoTerm.traducBD().toString());
            Teorema teorema;
            if (teoremaAdd == null) 
                teorema = teoremaManager.addTeorema(new Teorema(teoTerm.traducBD().toString(),teoTerm,false,aliases)); 
            else
                teorema = teoremaAdd;
            Resuelve resuelveAdd = new Resuelve(user,teorema,agregarTeorema.getNombreTeorema(),agregarTeorema.getNumeroTeorema(),
                                            agregarTeorema.isAxioma(), categoria, variables, usr.getTeoria());
            Resuelve resuelve = resuelveManager.addResuelve(resuelveAdd);

            // public Metateorema(int id, Categoria categoria, String enunciado, byte[] metateoserializado)
            /*Metateorema metateorema;
            Term metateoTerm = new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),teoTerm);
            Metateorema metateoremaAdd = metateoremaManager.getMetateoremaByEnunciados(metateoTerm.traducBD().toString());
            if (metateoremaAdd == null)
              metateorema = metateoremaManager.addMetateorema(new Metateorema(teorema.getId(),metateoTerm.traducBD().toString(),SerializationUtils.serialize(metateoTerm)));
            else
              metateorema = metateoremaAdd;
            
            Dispone disponeAdd = new Dispone(resuelve.getId(),user,metateorema,agregarTeorema.getNumeroTeorema(),false);
            Dispone dispone = disponeManager.addDispone(disponeAdd);*/
                 
            map.addAttribute("usuario", usr);
            map.addAttribute("guardarMenu","");
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
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
            map.addAttribute("teorias", teoriaManager.getAllTeoria());
            return "perfil";
        }
        catch(NullPointerException e){
            map.addAttribute("usuario", user);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(user.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
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
        catch (TypeVerificationException ex) {
            map.addAttribute("usuario", user);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(user.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
            map.addAttribute("mensaje", "You cannot enter your theorem because it contains a type error");
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("agregarTeoremaMenu","active");
            map.addAttribute("overflow","hidden");
            map.addAttribute("anchuraDiv","1200px");
            map.addAttribute("simboloList", simboloList);
            map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            return "agregarTeorema";
        }
        catch(CategoriaException e){
            map.addAttribute("usuario",user);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(user.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
            map.addAttribute("mensaje", "The theorem can't be save because "+e.alias);
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("agregarTeoremaMenu","active");
            map.addAttribute("overflow","hidden");
            map.addAttribute("anchuraDiv","1100px");
            map.addAttribute("simboloList", simboloList);
            map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            return "agregarTeorema";
        }
        catch(IsNotInDBException e){
            String hdr = "";//parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("usuario", usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
            map.addAttribute("mensaje", hdr +((IsNotInDBException)e).message);
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
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
        catch(RecognitionException e){
            String hdr = ""; //parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("usuario", user);
            map.addAttribute("infer",new InfersForm());
            map.addAttribute("mensaje", hdr+" "+msg);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(user.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
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
    
    @RequestMapping(value="/{username}/editarteo/{idTeo:.+}", method=RequestMethod.GET)
    public String editarTeoView(@PathVariable String username, @PathVariable String idTeo, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username))
        {
            return "redirect:/index";
        }
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        int teoId = Integer.parseInt(idTeo);
        Teorema teorema = teoremaManager.getTeorema(teoId);
        Term teoTerm = teorema.getTeoTerm();
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username, teoId, false);
        
        String teoC = teoTerm.evaluar(resuelve.getVariables()).toStringFormatC(simboloManager,"",0,"teoremaSymbolsId_").replace("\\", "\\\\");
        String teoInputs = teoTerm.toStringLaTeXWithInputs(simboloManager,"","teoremaSymbolsId_").replace("\\", "\\\\");
        
        /*
        try {
            Term testTerm = teoTerm;
            System.out.println(testTerm);
            System.out.println(testTerm.getType(simboloManager));
        } catch (TypeVerificationException ex) {
            System.out.println("error de tipo");
        }//*/
        AgregarTeorema agregarTeorema = new AgregarTeorema();
        agregarTeorema.setAxioma(resuelve.isResuelto());
        
        map.addAttribute("navUrlPrefix", "../");
        map.addAttribute("usuario",usr);
        map.addAttribute("agregarTeorema", agregarTeorema);
        map.addAttribute("modificar",new Integer(0));
        map.addAttribute("editar", true);
        map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
        map.addAttribute("selected",resuelve.getCategoria().getId());
        map.addAttribute("numeroTeorema", resuelve.getNumeroteorema());
        map.addAttribute("nombreTeorema", resuelve.getNombreteorema());
        map.addAttribute("teorema", "");
        map.addAttribute("teoremaC", teoC);
        map.addAttribute("teoremaInputs", teoInputs);
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
    
    @RequestMapping(value="/{username}/editarteo/{idTeo:.+}", method=RequestMethod.POST)
    public String editarTeo(@Valid AgregarTeorema agregarTeorema,
                            BindingResult bindingResult,
                            @PathVariable String username,
                            @PathVariable String idTeo,
                            ModelMap map)
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
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        int intIdTeo = Integer.parseInt(idTeo);
        Resuelve resuelve = resuelveManager.getResuelveByUserAndTeorema(username, intIdTeo, false);
        
        boolean nTheoExists = false;
        if (resuelveManager.getResuelveByUserAndTeoNum(username, agregarTeorema.getNumeroTeorema(), false) != null)
            nTheoExists = true;
        
        if(bindingResult.hasErrors()){
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario", usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
            map.addAttribute("mensaje", "");
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("agregarTeoremaMenu","active");
            map.addAttribute("overflow","hidden");
            map.addAttribute("anchuraDiv","1200px");
            map.addAttribute("simboloList", simboloList);
            if (nTheoExists)
                bindingResult.rejectValue("numeroTeorema","error.agregarTeorema","Theorem number already exists");
            map.addAttribute("predicadoList", predicadoList); map.addAttribute("predicadoList", predicadoList);
            map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            return "agregarTeorema";
        }
        
        PredicadoId predicadoid2=new PredicadoId();
        predicadoid2.setLogin(username);
        
        CharStream in = CharStreams.fromString(agregarTeorema.getTeorema());
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        Term teoTerm;

        try{ //si la sintanxis no es correcta ocurre una Exception
        
            String[] boundVars = {""};
            teoTerm =parser.start_rule(predicadoid2,predicadoManager,simboloManager,boundVars).value;
            
            // Guardando info en caso de error
            String teoC = teoTerm.evaluar(resuelve.getVariables()).toStringFormatC(simboloManager,"",0,"teoremaSymbolsId_").replace("\\", "\\\\");
            String teoInputs = teoTerm.toStringLaTeXWithInputs(simboloManager,"","teoremaSymbolsId_").replace("\\", "\\\\");
            map.addAttribute("teoremaC", teoC);
            map.addAttribute("teoremaInputs", teoInputs);
//                teoTerm.setAlias(0);
            
            // Verificando el tipo de la expresi�n
            System.out.println(teoTerm.getType(simboloManager));
            

            // ESTO DEBE MOSTRAR LAS CATEGORIAS
            Categoria categoria;
            categoria = categoriaManager.getCategoria(new Integer(agregarTeorema.getCategoriaSeleccionada()));
            if (categoria == null) {
                throw new CategoriaException("Ese numero de categoria no existe");
            }
            // public Teorema(Categoria categoria, String enunciado, Term teoTerm, boolean esquema)
            
            /**
            String aliases = teoTerm.aliases("");
            Teorema teoremaAdd = teoremaManager.getTeoremaByEnunciados(teoTerm.traducBD().toString());
            Teorema teorema;
            if (teoremaAdd == null) 
             teorema = teoremaManager.addTeorema(new Teorema(teoTerm.traducBD().toString(),teoTerm,false,aliases)); 
            else
                teorema = teoremaAdd;
            */
           
            Teorema teorema = teoremaManager.getTeorema(intIdTeo);
            String vars = null;
            if (!teorema.getEnunciado().equals(agregarTeorema.getTeorema())) {
                Resuelve test = resuelveManager.getResuelveByUserAndTeorema(username, teoTerm.traducBD().toString(), false);
                if (null != test && test.getId() != resuelve.getId()) {
                    throw new CategoriaException("An equal one already exists in "+test.getNumeroteorema());
                }
                vars = teoTerm.stFreeVars();
                teoTerm = teoTerm.toEquality(vars);
                vars = boundVars[0] + ";" + vars;
                teorema = teoremaManager.updateTeorema(intIdTeo, username, teoTerm.traducBD().toString(), teoTerm, vars);
                if (teorema == null) {
                    throw new CategoriaException("Couldn't edit theorem");
                }
                intIdTeo = teorema.getId();
            }
      
            resuelve.setTeorema(teorema);
            resuelve.setNombreteorema(agregarTeorema.getNombreTeorema());
            resuelve.setNumeroteorema(agregarTeorema.getNumeroTeorema());
            resuelve.setEsAxioma(agregarTeorema.isAxioma());
            resuelve.setCategoria(categoria);
            if (vars != null) {
                resuelve.setVariables(vars);
            }
            resuelveManager.updateResuelve(resuelve);
            
            //Resuelve resuelveAdd = new Resuelve(usr,teorema,agregarTeorema.getNombreTeorema(),agregarTeorema.getNumeroTeorema(),agregarTeorema.isAxioma(), categoria);
            //Resuelve resuelve = resuelveManager.addResuelve(resuelveAdd);
            

            // public Metateorema(int id, Categoria categoria, String enunciado, byte[] metateoserializado)
            /*Metateorema metateorema;
            Term metateoTerm = new App(new App(new Const(1,"\\equiv ",false,1,1),new Const("true")),teoTerm);
            Metateorema metateoremaAdd = metateoremaManager.getMetateoremaByEnunciados(metateoTerm.traducBD().toString());
            if (metateoremaAdd == null)
              metateorema = metateoremaManager.addMetateorema(new Metateorema(teorema.getId(),metateoTerm.traducBD().toString(),SerializationUtils.serialize(metateoTerm)));
            else
              metateorema = metateoremaAdd;
            
            Dispone disponeAdd = new Dispone(resuelve.getId(),user,metateorema,agregarTeorema.getNumeroTeorema(),false);
            Dispone dispone = disponeManager.addDispone(disponeAdd);*/
            
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario", usr);
            map.addAttribute("guardarMenu","");
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
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
            map.addAttribute("teorias", teoriaManager.getAllTeoria());
            return "perfil";
        }
        catch(NullPointerException e){
            e.printStackTrace();
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario", usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
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
        catch(CategoriaException e){
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario",usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
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
        catch (TypeVerificationException ex) {
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario", usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
            map.addAttribute("mensaje", "You cannot enter your theorem because it contains a type error");
            map.addAttribute("admin","AdminTeoremas");
            map.addAttribute("agregarTeoremaMenu","active");
            map.addAttribute("overflow","hidden");
            map.addAttribute("anchuraDiv","1200px");
            map.addAttribute("simboloList", simboloList);
            map.addAttribute("simboloDictionaryCode", simboloDictionaryCode);
            map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
            return "agregarTeorema";
        }
        catch(IsNotInDBException e){
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario", usr);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
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
        catch(RecognitionException e){
            String hdr = parser.getErrorHeader(e);
            String msg = e.getMessage(); //parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("navUrlPrefix", "../");
            map.addAttribute("usuario", usr);
            map.addAttribute("infer",new InfersForm());
            map.addAttribute("mensaje", hdr+" "+msg);
            map.addAttribute("agregarTeorema",agregarTeorema);
            map.addAttribute("selected",agregarTeorema.getCategoriaSeleccionada());
            map.addAttribute("modificar",new Integer(0));
            map.addAttribute("teorema",agregarTeorema.getTeorema());
            map.addAttribute("categoria",categoriaManager.getAllCategoriasByTeoria(usr.getTeoria()));
            map.addAttribute("numeroTeorema",agregarTeorema.getNumeroTeorema());
            map.addAttribute("nombreTeorema", agregarTeorema.getNombreTeorema());
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
        
        Usuario usr = usuarioManager.getUsuario(username);
        List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
        List<Predicado> predicadoList = predicadoManager.getAllPredicadosByUser(username);
        predicadoList.addAll(predicadoManager.getAllPredicadosByUser("AdminTeoremas"));
        String simboloDictionaryCode = simboloDictionaryCode(simboloList, predicadoList);
        
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
        map.addAttribute("proveMenu","");
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
    public static String simboloDictionaryCode(List<Simbolo> simboloList, List<Predicado> predicadoList) {
    	
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

            simboloString = "{ arguments: " + argumentsString + ", precedence: " + precedenceString + ", notacionVariables: " + notacionVariables + ", notacionString: '" + notacionString + "'}"; 
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
            List<Simbolo> simboloList = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
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
                map.addAttribute("proveMenu","");
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
                    String[] boundVars = {""};
                    term=parser.start_rule(predicadoid2,predicadoManager,simboloManager,boundVars).value;
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
                     predicado.setPredicado(res.toString());
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
                    map.addAttribute("proveMenu","");
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
                    map.addAttribute("proveMenu","");
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
                map.addAttribute("proveMenu","");
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
                map.addAttribute("proveMenu","");
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
                map.addAttribute("proveMenu","");
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
        Term aux = CombUtilities.getTerm(p.getPredicado(),null);
        for (String var : tk.getVars()) 
            aux=new App(aux,new Var(var.charAt(0)));
        aux = aux.evaluar();
        String term=aux.toStringLaTeX(simboloManager,"").replace("\\", "\\\\");
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
                map.addAttribute("proveMenu","");
                map.addAttribute("perfilMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                map.addAttribute("teorias", teoriaManager.getAllTeoria());
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
                String[] boundVars = {""};
                term=parser.start_rule(predicadoid2,predicadoManager,simboloManager,boundVars).value;
                //term.alias=alias;
                //aqui se traduce y luego se llama a toString para tener el
                //combinador en String
                
                Comprobacion comprobar = new Comprobacion();
                Brackear bk = new Brackear();
                Term res = bk.appBrack(args.split(","), term).traducBD();
                String check  = comprobar.dfs(res);
                String resultado;
                if (check.equals("")) {
                    predicado.setPredicado(res.toString());
                    Predicado predicado2=predicadoManager.getPredicado(username, predicado.getPredicado());
                    if(predicado2 != null && !predicado2.getId().getAlias().equals(alias)) 
                        throw new AlphaEquivalenceException(predicado2.getId().getAlias());
                    predicadoManager.updatePredicado(predicado);
                    resultado  = " 1 Su abreviaci&oacute;n ha sido guardado con exito";
                }
                else{
                    resultado = " 2 Su abreviaci&oacute;n usa variables como: "+check +" que no estan especificada";
                }

                map.addAttribute("mensaje", "Su t&eacute;rmino se ha modificado con exito");
                map.addAttribute("usuario", usr);
                map.addAttribute("guardarMenu","");
                map.addAttribute("listarTerminosMenu","");
                map.addAttribute("verTerminosPublicosMenu","");
                map.addAttribute("misPublicacionesMenu","");
                map.addAttribute("proveMenu","");
                map.addAttribute("perfilMenu","active");
                map.addAttribute("overflow","hidden");
                map.addAttribute("anchuraDiv","1200px");
                map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
                map.addAttribute("teorias", teoriaManager.getAllTeoria());
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
        map.addAttribute("proveMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("regex","@[12]*");
        map.addAttribute("anchuraDiv","1163px");

        
        return "listar";
    }
/*    
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
        map.addAttribute("proveMenu","");
        map.addAttribute("perfilMenu","");
        map.addAttribute("overflow","scroll");
        map.addAttribute("anchuraDiv","1163px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        return "listar";
    }
*/

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
        map.addAttribute("proveMenu","");
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
/*    
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
*/
/*  
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
            map.addAttribute("proveMenu","");
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
            map.addAttribute("proveMenu","");
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
        map.addAttribute("proveMenu","");
        map.addAttribute("perfilMenu","active");
        map.addAttribute("overflow","hidden");
        map.addAttribute("anchuraDiv","1200px");
        map.addAttribute("isAdmin",usr.isAdmin()?new Integer(1):new Integer(0));
        
        return "perfil";
    }
*/

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
        map.addAttribute("proveMenu","active");
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
        List<Simbolo> listaSimbolos = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
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
        Usuario usr = usuarioManager.getUsuario(username);
        //Teoria teoria = usr.getTeoria();
        
        if (!agregarSimbolo.isModificar()){
            Simbolo simbolo = new Simbolo(agregarSimbolo.getNotacion_latex(),agregarSimbolo.getArgumentos(),agregarSimbolo.isEsInfijo(),
            agregarSimbolo.getAsociatividad(),agregarSimbolo.getPrecedencia(),agregarSimbolo.getNotacion(), teoria, agregarSimbolo.getTipo());
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
            //simbolo.setTipo(agregarSimbolo.getTipo());
            simboloManager.updateSimbolo(simbolo);
        }
        

        List<Simbolo> listaSimbolos = simboloManager.getAllSimboloByTeoria(usr.getTeoria().getId());
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
    
    @RequestMapping(value="/{username}/theo/deleteSymbol/{symbolId}", method=RequestMethod.GET)
    @ResponseBody
    public String DeleteSymbol(@PathVariable String username, @PathVariable String symbolId, ModelMap map) {
        if (  
            (Usuario)session.getAttribute("user") == null || !((Usuario)session.getAttribute("user")).getLogin().equals(username)
                || !((Usuario)session.getAttribute("user")).isAdmin()
            )
        {
            return "authentication failed";
        }
        Usuario usr = usuarioManager.getUsuario(username);
        return simboloManager.deleteSimbolo(Integer.parseInt(symbolId), username);
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
    
    @RequestMapping(value="/{username}/myTheorems/deleteSol/{idSol:.+}", method=RequestMethod.POST)
    @ResponseBody
    public String deleteSolucion(@PathVariable String username, @PathVariable String idSol, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null 
              || !((Usuario)session.getAttribute("user")).getLogin().equals(username)) {
            return "Error deleting proof";
        }
        try {
            int idSolInt = Integer.parseInt(idSol);
            if (this.solucionManager.deleteSolucion(idSolInt, username)) {
                return "Proof deleted";
            }
            return "Couldn't delete proof\nMake sure the theorem isn't used in any other proofs";
        }
        catch (NumberFormatException e) {
            return "error";
        }
    }
    
    @RequestMapping(value="/{username}/myTheorems/deleteTeo/{idTeo:.+}", method=RequestMethod.POST)
    @ResponseBody
    public String deleteTeoremaOrResuelve(@PathVariable String username, @PathVariable String idTeo, ModelMap map) {
        if ( (Usuario)session.getAttribute("user") == null 
              || !((Usuario)session.getAttribute("user")).getLogin().equals(username)) {
            return "error";
        }
        try {
            int idTeoInt = Integer.parseInt(idTeo);
            if (this.teoremaManager.deleteTeorema(idTeoInt, username)) {
                return "Theorem deleted";
            }
            return "Couldn't delete theorem\nMake sure the theorem has no proofs";
        }
        catch (NumberFormatException e) {
            return "error";
        }
    }

    /* 
     * This is just a provisional controller to transform some theorems
     * It occurs that the variables names are not assigned in the desired order (in-order),
     * so to do not make the changes manually, we will automate it with this controller
     */
    @RequestMapping(value="/{username}/transformTheoremWithAppropiateVariables", method=RequestMethod.GET)
    public void transformTheoremWithAppropiateVariables(@PathVariable String username)
    {
        // List<Resuelve> resuelves = resuelveManager.getAllResuelveByUserWithSol("AdminTeoremas");

        // for (Resuelve r: resuelves){                       
        //     Teorema t = r.getTeorema();
        //     t.setTeoTerm(t.getTeoTerm());
        // }

    }
}
