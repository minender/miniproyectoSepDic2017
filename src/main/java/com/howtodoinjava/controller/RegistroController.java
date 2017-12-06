package com.howtodoinjava.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import com.howtodoinjava.dao.ResuelveDAO;
import com.howtodoinjava.entity.Resuelve;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.howtodoinjava.entity.Usuario;
import com.howtodoinjava.service.ResuelveManager;
import com.howtodoinjava.service.UsuarioManager;
import java.util.List;
import javax.validation.Valid;

@Controller
@RequestMapping(value="/registro")
public class RegistroController {
	
	@Autowired
	private UsuarioManager usuarioManager;
        @Autowired
        private ResuelveDAO resuelveDAO;
        @Autowired
        private ResuelveManager resuelveManager;
        
        @RequestMapping(method=RequestMethod.GET, params="new")
        public String createUsuarioProfile(ModelMap map)
        {
            map.addAttribute("usuario",new Usuario());
            return "registro";
        }
        
        @RequestMapping(method=RequestMethod.POST)
        public String addUsuarioFromForm(@Valid Usuario usuario,BindingResult bindingResult)
        {
            if( bindingResult.hasErrors() )
            {
                return "registro";
            }
            else{
                List<Resuelve> resuelves = resuelveDAO.getAllResuelveByUser("AdminTeoremas");
                usuarioManager.addUsuario(usuario);
                for(Resuelve resuelve : resuelves){
                    resuelve.setUsuario(usuario);
                    resuelveManager.addResuelve(resuelve);
                }
            }  
                
                return "redirect:registro/"+usuario.getLogin();
        }
        
        @RequestMapping(value="/{username}", method=RequestMethod.GET)
        public String showUsuarioProfile(@PathVariable String username, ModelMap map) {
            map.addAttribute("usuario", usuarioManager.getUsuario(username));
            return "registrado";
        }
        public void setUsuarioManager(UsuarioManager usuarioManager) {
		this.usuarioManager = usuarioManager;
        }
}
