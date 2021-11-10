package com.calclogic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.calclogic.dao.ResuelveDAO;
import com.calclogic.dao.UsuarioDAO;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Teorema;
import com.calclogic.entity.Usuario;
import java.util.Iterator;

/**
 * This class has the implementation of "UsuarioManager" queries.
 */
 
@Service
public class UsuarioManagerImpl implements UsuarioManager {

    @Autowired
    private UsuarioDAO usuarioDAO;
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private TeoremaManager teoremaManager;

    /** 
     * Adds a new user to the table.
     * @param usuario The new user to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void addUsuario(Usuario usuario) {
        usuarioDAO.addUsuario(usuario);
    }
    
    /**
     * Updates one of the users of the table.
     * @param usuario Is the user to be updated.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void updateUsuario(Usuario usuario) {
        usuarioDAO.updateUsuario(usuario);
    }

    /**
     * Method to get a list of all the entries of the table (all the users).
     */
    @Override
    @Transactional
    public List<Usuario> getAllUsuarios() {
        return usuarioDAO.getAllUsuarios();
    }
	
    /**
     * Method to get a specific user.
     * @param login Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public Usuario getUsuario(String login) {
        return usuarioDAO.getUsuario(login);
    }

    /**
     * Deletes one of the users of the table.
     * @param usuarioId Is the principal key of the user to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public void deleteUsuario(Integer usuarioId) {
        usuarioDAO.deleteUsuario(usuarioId);
    }

    public void setUsuarioDAO(UsuarioDAO usuarioDAO) {
        this.usuarioDAO = usuarioDAO;
    }

    /**
     * Method to get a list of all the theorems that correspond to a specific user.
	 * @param usuario Is the user whose theorems will be returned.
     */
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

    /**
     * Deletes one of the theorems from the list of those that correspond
	 * to a specific user.
     * @param usuario Is user whose theorem will be the deleted.
	 * @param teorema Theorem to be deleted.
     * @return Nothing.
     */ 
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
    
    /**
     * Method to get a list of all entries of the table that represent students, that is,
     * users that are not administrators.
     */
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
