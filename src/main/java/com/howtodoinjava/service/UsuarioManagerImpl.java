package com.howtodoinjava.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.howtodoinjava.dao.ResuelveDAO;
import com.howtodoinjava.dao.UsuarioDAO;
import com.howtodoinjava.entity.Resuelve;
import com.howtodoinjava.entity.Teorema;
import com.howtodoinjava.entity.Usuario;
import java.util.Iterator;

@Service
public class UsuarioManagerImpl implements UsuarioManager {

    @Autowired
    private UsuarioDAO usuarioDAO;
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private TeoremaManager teoremaManager;

    @Override
    @Transactional
    public void addUsuario(Usuario usuario) {
        usuarioDAO.addUsuario(usuario);
    }
    
    @Override
    @Transactional
    public void updateUsuario(Usuario usuario) {
        usuarioDAO.updateUsuario(usuario);
    }

    @Override
    @Transactional
    public List<Usuario> getAllUsuarios() {
        return usuarioDAO.getAllUsuarios();
    }

    @Override
    @Transactional
    public void deleteUsuario(Integer usuarioId) {
        usuarioDAO.deleteUsuario(usuarioId);
    }

    public void setUsuarioDAO(UsuarioDAO usuarioDAO) {
        this.usuarioDAO = usuarioDAO;
    }

    @Override
    @Transactional
    public Usuario getUsuario(String login) {
        return usuarioDAO.getUsuario(login);
    }

    @Override
    @Transactional
    public List<Teorema> getAllTeoremas(Usuario usuario) {
        List<Resuelve> resuelveList = resuelveManager.getAllResuelveByUser(usuario.getLogin());
        List<Teorema> teoremaList = teoremaManager.getTeoremaByResuelveList(resuelveList);
        for (Teorema teo : teoremaList) {
//            System.out.println("Ya tiene el teorema de id:");
//            System.out.println(teo.getId());
        }
        return teoremaList;
    }

    @Override
    @Transactional
    public void deleteTeorema(Usuario usuario, Teorema teorema) {

        List<Resuelve> resuelveList = resuelveManager.getResuelveByTeorema(teorema.getId());
        if (resuelveList.size() > 1) {
            Iterator<Resuelve> resIter = resuelveList.iterator();
            Resuelve resuelve = resIter.next();
            while (resIter.hasNext()
                    && (resuelve.getTeorema().getId() != teorema.getId()
                    || !resuelve.getUsuario().getLogin().equals(usuario.getLogin()))) {
                resuelve = resIter.next();
            }
            resuelveManager.deleteResuelve(resuelve.getId());
        } else {
            Resuelve resuelve = resuelveList.get(0);
            if (resuelve != null) {
                resuelveManager.deleteResuelve(resuelve.getId());
                teoremaManager.deleteTeorema(resuelve.getTeorema().getId());
            }
        }
    }
    
    @Override
    @Transactional
    public List<Usuario> getStudents(){
        return usuarioDAO.getStudents();
    }
    
    
    //@Override
    //@Transactional
//    public void modificarTeorema(Usuario usuario, Teorema teorema) {
//        
//    }
    
    
}
