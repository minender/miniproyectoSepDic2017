/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.howtodoinjava.entity.Usuario;
import com.howtodoinjava.service.UsuarioManager;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping(value="/index")
public class IndexController {
    
    @Autowired
    private UsuarioManager usuarioManager;
    @Autowired
    private HttpSession session;
    
    @RequestMapping(method=RequestMethod.GET)
    public String createLoginForm(ModelMap map)
    {
        
        map.addAttribute("usuariolog",new Usuario());
        map.addAttribute("mensaje", "");
        return "index";
    }

    @RequestMapping(method=RequestMethod.POST)
    public String validarUsuarioFromForm( Usuario usuariolog,ModelMap map)
    {

        Usuario usreal=usuarioManager.getUsuario(usuariolog.getLogin());
        if(usreal != null && usreal.getPassword() != null && 
                usreal.getPassword().equals(usuariolog.getPassword()) )
        {
            session.setAttribute("user", usreal);
            return "redirect:/perfil/"+usreal.getLogin();
        }
        else
        {
            map.addAttribute("usuariolog",new Usuario());
            map.addAttribute("mensaje", "Login o password errados");
            return "index";
        }

    }


    @RequestMapping(value="/{username}", method=RequestMethod.GET)
    public String showUsuarioProfile(@PathVariable String username, ModelMap map) {
        map.addAttribute("usuario", usuarioManager.getUsuario(username));
        return "registrado";
    }
    
    public void setUsuarioManager(UsuarioManager usuarioManager) 
    {
            this.usuarioManager = usuarioManager;
    }
}
