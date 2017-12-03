/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.controller;

import com.howtodoinjava.entity.Categoria;
import com.howtodoinjava.entity.Dispone;
import com.howtodoinjava.entity.Metateorema;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Solucion;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.entity.TerminoId;
import com.howtodoinjava.entity.Usuario;
import com.howtodoinjava.forms.AgregarTeorema;
import com.howtodoinjava.forms.InsertarEvaluar;
import com.howtodoinjava.lambdacalculo.App;
import com.howtodoinjava.lambdacalculo.Const;
import com.howtodoinjava.lambdacalculo.Bracket;
import com.howtodoinjava.lambdacalculo.TypedA;
import com.howtodoinjava.lambdacalculo.TypedL;
import com.howtodoinjava.lambdacalculo.TypedApp;
import com.howtodoinjava.lambdacalculo.Corrida;
import com.howtodoinjava.lambdacalculo.PasoInferencia;
import com.howtodoinjava.lambdacalculo.Sust;
import com.howtodoinjava.lambdacalculo.Term;
import com.howtodoinjava.lambdacalculo.Tripla;
import com.howtodoinjava.parse.IsNotInDBException;
import com.howtodoinjava.lambdacalculo.TypeVerificationException;
import com.howtodoinjava.lambdacalculo.TypedI;
import com.howtodoinjava.lambdacalculo.Var;
import com.howtodoinjava.parse.TermLexer;
import com.howtodoinjava.parse.TermParser;
import com.howtodoinjava.service.CategoriaManager;
import com.howtodoinjava.service.DisponeManager;
import com.howtodoinjava.service.MetateoremaManager;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.SolucionManager;
import com.howtodoinjava.service.TeoremaManager;
import com.howtodoinjava.service.TerminoManager;
import com.howtodoinjava.service.UsuarioManager;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.SerializationUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author federico
 */
@Controller
@RequestMapping(value = "/eval")
public class EvaluarController {


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

    @RequestMapping(value = "/{username}/pruebaPredicado/{id}", method = RequestMethod.GET)
    public String pruebaPredicadoView(@PathVariable String username, @PathVariable String id, ModelMap map) {
            
            
            /*AgregarTeorema agregarTeorema = new AgregarTeorema("(p == p) == (q == q)", "45", "3.23", "El 3.23");
        
            Usuario user = usuarioManager.getUsuario(username);
            usuarioManager.getAllTeoremas(user);
            */
            TerminoId terminoid2 = new TerminoId();
            terminoid2.setLogin(username);

            ANTLRStringStream in = new ANTLRStringStream("p,q:=p/\\r,r\\/r"); //"p \\/ q /\\(r ==> p /\\ (r \\/ q))");
            TermLexer lexer = new TermLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            TermParser parser = new TermParser(tokens);
            //Term teoTerm;
            ANTLRStringStream in2 = new ANTLRStringStream("(p == q) == (q == p)"); //"p \\/ q /\\(r ==> p /\\ (r \\/ q))");
            TermLexer lexer2 = new TermLexer(in2);
            CommonTokenStream tokens2 = new CommonTokenStream(lexer2);
            TermParser parser2 = new TermParser(tokens2);
            Term teoTerm2;
            ArrayList<Object> teoTerm;
            try //si la sintanxis no es correcta ocurre una Exception
            {

                teoTerm = parser.instantiate(terminoid2, terminoManager);
//                teoTerm.setAlias(0);
                teoTerm2 = parser2.start_rule(terminoid2, terminoManager);
                teoTerm2.setAlias(0);
                // inicializando pa q no ladille java
                /*Term izq = null;
                Term der = null;
                boolean esEq = true;
                Const relation = null;

                try {
                    relation = (Const) ((App) ((App) teoTerm).p).p;
                    esEq = relation.getCon().trim().equals("\\equiv");
                    izq = teoTerm;
                    der = ((App) ((App) teoTerm).p).q;
                } catch (java.lang.ClassCastException e) {
                    esEq = false;
                }

                if (!esEq) {
                    izq = teoTerm;
                    der = new Const("true");
                }

            
                // Este teorema sera utilizado para ver si ya existe en la BD
                Teorema teorema2 = teoremaManager.getTeoremaByEnunciados(izq.toString());
                if (teorema2 != null) {
                    System.out.println("el teorema ya existe");
                } else {
                    // Este teorema sera utilizado para ver si el inverso ya existe en la BD
                    Teorema teorema3 = teoremaManager.getTeoremaByEnunciados(der.toString(), izq.toString());
                    if (teorema3 != null) {
                        System.out.println("el teorema ya existe aplicando conmutatividad (p == q) == (q == p)");
                    }
                }


                // ESTO DEBE MOSTRAR LAS CATEGORIAS
                // Se busca si existe la cat, si no existe se crea
                Categoria categoria = categoriaManager.getCategoria(new Integer(agregarTeorema.getCategoria()));
                if (categoria == null) {
                    categoria = new Categoria("Equivalencia");
//                    categoriaManager.addCategoria(categoria);
                }

//              Teorema(Categoria categoria, String enunciado, Term teoTerm, boolean esquema)
                Teorema teorema = new Teorema(categoria, izq.traducBD().toStringFinal(), izq, false);
//                teoremaManager.addTeorema(teorema);

//                Resuelve resuelve = new Resuelve(user, teorema, agregarTeorema.getNombreTeorema(), agregarTeorema.getNumeroTeorema(), false);
                Resuelve resuelve = new Resuelve(user, teorema, "", "Teo de prueba", false);
//                resuelveManager.addResuelve(resuelve);

                // public Metateorema(int id, Categoria categoria, String enunciado, byte[] metateoserializado)
                Metateorema metateorema = new Metateorema(teorema.getId(), categoria, teoTerm.traducBD().toStringFinal(), SerializationUtils.serialize(teoTerm));
//                metateoremaManager.addMetateorema(metateorema);

                // public Dispone(int id, Usuario usuario, Metateorema metateorema, String numerometateorema, boolean resuelto)
                Dispone dispone = new Dispone(resuelve.getId(), user, metateorema, agregarTeorema.getNumeroTeorema(), false);
//                disponeManager.addDispone(dispone);
                
                Teorema teo = teoremaManager.getTeorema(1);
                
                usuarioManager.getAllTeoremas(user);*/
//                TypedL L = new TypedL((Bracket)teoTerm);
                TypedI I = new TypedI(new Sust((ArrayList<Var>)teoTerm.get(0), (ArrayList<Term>)teoTerm.get(1)));
                TypedA A = new TypedA(teoTerm2);
                System.out.println((new TypedApp(I, A)).type().toStringInfFinal());
                map.addAttribute("id", id);
                map.addAttribute("usuario", username);
                map.addAttribute("alias", I.type().toStringInfFinal());//(new TypedApp(I, A)).type().toStringInfFinal());//teoTerm.toStringInfLabeled());
                map.addAttribute("predserializado", categoriaManager.getAllCategorias().toString());
                return "PagParaVerPredicado";
            }
            catch (TypeVerificationException e)
            {
                map.addAttribute("usuario", usuarioManager.getUsuario(username));
                map.addAttribute("alias", "TypeVerificationException");
                map.addAttribute("agregarTeoremaMenu", "class=\"active\"");
                map.addAttribute("listarTerminosMenu", "");
                map.addAttribute("verTerminosPublicosMenu", "");
                map.addAttribute("misPublicacionesMenu", "");
                map.addAttribute("computarMenu", "");
                map.addAttribute("perfilMenu", "");
                map.addAttribute("overflow", "hidden");
                map.addAttribute("anchuraDiv", "1100px");
                return "PagParaVerPredicado";
            }
            catch (IsNotInDBException e) {
                String hdr = parser.getErrorHeader(e);
                String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario", usuarioManager.getUsuario(username));

                map.addAttribute("agregarTeoremaMenu", "class=\"active\"");
                map.addAttribute("listarTerminosMenu", "");
                map.addAttribute("verTerminosPublicosMenu", "");
                map.addAttribute("misPublicacionesMenu", "");
                map.addAttribute("computarMenu", "");
                map.addAttribute("perfilMenu", "");
                map.addAttribute("overflow", "hidden");
                map.addAttribute("anchuraDiv", "1100px");
                return "PagParaVerPredicado";
            } catch (RecognitionException e) {
                String hdr = parser.getErrorHeader(e);
                String msg = parser.getErrorMessage(e, TermParser.tokenNames);
                map.addAttribute("usuario", usuarioManager.getUsuario(username));

                map.addAttribute("admin", "admin");
                map.addAttribute("guardarMenu", "");
                map.addAttribute("agregarTeoremaMenu", "class=\"active\"");
                map.addAttribute("listarTerminosMenu", "");
                map.addAttribute("verTerminosPublicosMenu", "");
                map.addAttribute("misPublicacionesMenu", "");
                map.addAttribute("computarMenu", "");
                map.addAttribute("perfilMenu", "");
                map.addAttribute("overflow", "hidden");
                map.addAttribute("anchuraDiv", "1100px");
                return "PagParaVerPredicado";
            }
        }

    @RequestMapping(value = "/{username}", method = RequestMethod.POST)
    public String evaluarPasoAPasoView(@Valid InsertarEvaluar insertarEvaluar, BindingResult bindingResult, @PathVariable String username, ModelMap map) {
        if ((Usuario) session.getAttribute("user") == null || !((Usuario) session.getAttribute("user")).getLogin().equals(username)) {
            return "redirect:/index";
        }
        if (bindingResult.hasErrors()) {
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            map.addAttribute("mensaje", "");
            map.addAttribute("termino", insertarEvaluar.getAlgoritmo());
            map.addAttribute("nombre", insertarEvaluar.getNombre());
            map.addAttribute("guardarMenu", "");
            map.addAttribute("admin", "admin");
            map.addAttribute("listarTerminosMenu", "");
            map.addAttribute("verTerminosPublicosMenu", "");
            map.addAttribute("misPublicacionesMenu", "");
            map.addAttribute("computarMenu", "class=\"active\"");
            map.addAttribute("perfilMenu", "");
            map.addAttribute("hrefAMiMismo", "href=../../eval/" + username + "#!");
            map.addAttribute("overflow", "hidden");
            map.addAttribute("anchuraDiv", "1100px");
            return "insertarEvaluar";
        }

        String programa = insertarEvaluar.getAlgoritmo();
        TerminoId terminoid = new TerminoId();
        terminoid.setLogin(username);

        //Hay que construir un Term aqui con el String termino.combinador
        //para luego traducir, hace falta construir un parse   
        ANTLRStringStream in = new ANTLRStringStream(programa);
        TermLexer lexer = new TermLexer(in);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        TermParser parser = new TermParser(tokens);
        Term term;
        try //si la sintanxis no es correcta ocurre una Exception
        {

            term = parser.start_rule(terminoid, terminoManager);
            term.setAlias(0);

        } catch (IsNotInDBException e) {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            map.addAttribute("insertarEvaluar", new InsertarEvaluar());
            map.addAttribute("mensaje", hdr + ((IsNotInDBException) e).message);
            map.addAttribute("nombre", insertarEvaluar.getNombre());
            map.addAttribute("termino", programa);
            map.addAttribute("admin", "admin");
            map.addAttribute("guardarMenu", "");
            map.addAttribute("listarTerminosMenu", "");
            map.addAttribute("verTerminosPublicosMenu", "");
            map.addAttribute("misPublicacionesMenu", "");
            map.addAttribute("computarMenu", "class=\"active\"");
            map.addAttribute("perfilMenu", "");
            map.addAttribute("hrefAMiMismo", "href=../../eval/" + username + "#!");
            map.addAttribute("overflow", "hidden");
            map.addAttribute("anchuraDiv", "1100px");
            return "insertarEvaluar";
        } catch (RecognitionException e) {
            String hdr = parser.getErrorHeader(e);
            String msg = parser.getErrorMessage(e, TermParser.tokenNames);
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            map.addAttribute("insertarEvaluar", new InsertarEvaluar());
            map.addAttribute("mensaje", hdr + " " + msg);
            map.addAttribute("nombre", insertarEvaluar.getNombre());
            map.addAttribute("termino", programa);
            map.addAttribute("guardarMenu", "");
            map.addAttribute("admin", "admin");
            map.addAttribute("listarTerminosMenu", "");
            map.addAttribute("verTerminosPublicosMenu", "");
            map.addAttribute("misPublicacionesMenu", "");
            map.addAttribute("computarMenu", "class=\"active\"");
            map.addAttribute("perfilMenu", "");
            map.addAttribute("hrefAMiMismo", "href=../../eval/" + username + "#!");
            map.addAttribute("overflow", "hidden");
            map.addAttribute("anchuraDiv", "1100px");
            return "insertarEvaluar";
        }

        Tripla tripla = term.toStringAbrvFinal();
        List<String> alias = tripla.alias;
        List<String> valores = tripla.valores;
        Corrida corr = term.evaluarFinal();
        corr.operations.add(new Integer(7));//agrego cualquier cosa

        //corr.terminos.set(0, tripla.term.replace("\\", "\\\\"));

        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        map.addAttribute("nReducciones", new Float(((float) corr.reducciones / (float) (corr.reducciones + corr.traducciones)) * 100));
        map.addAttribute("nTraduc", new Float(((float) corr.traducciones / (float) (corr.reducciones + corr.traducciones)) * 100));
        map.addAttribute("nTerms", new Integer(corr.terminos.size() - 1));
        map.addAttribute("nTermsPuros", new Integer(corr.lambdaTerms.size() - 1));
        map.addAttribute("terminos", corr.terminos);
        map.addAttribute("operations", corr.operations);
        map.addAttribute("termPuros", corr.lambdaTerms);
        if (alias.size() != 0) {
            map.addAttribute("nAlias", new Integer(alias.size() - 1));
        } else {
            map.addAttribute("nAlias", new Integer(0));
            alias.add("");
            valores.add("");
        }
        map.addAttribute("alias", alias);
        map.addAttribute("valores", valores);
        return "evaluar";
    }

    public void setUsuarioManager(UsuarioManager usuarioManager) {
        this.usuarioManager = usuarioManager;
    }

    public void setTerminoManager(TerminoManager terminoManager) {
        this.terminoManager = terminoManager;
    }
}
