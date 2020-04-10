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
import org.apache.commons.codec.digest.DigestUtils;

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
        String randomchars = "hdfGLd6J4$&(3nd^{bHGF@fs";
        String pass = DigestUtils.sha512Hex(usuariolog.getPassword()+randomchars);
        if(usreal != null && usreal.getPassword() != null && 
                usreal.getPassword().equals(pass) )
        {
            session.setAttribute("user", usreal);
            return "redirect:/perfil/"+usreal.getLogin()+"/home";
        }
        else
        {
            map.addAttribute("usuariolog",new Usuario());
            map.addAttribute("mensaje", "Login o password errados");
            return "index";
        }

    }
    
    @RequestMapping(value="/help", method=RequestMethod.GET)
    public String showHelp(ModelMap map) {
   //     map.addAttribute("logout","logout");
        map.addAttribute("sesion","logout");
        return "help";
    }
}
