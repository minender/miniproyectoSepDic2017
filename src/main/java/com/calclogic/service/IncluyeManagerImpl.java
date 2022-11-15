
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.IncluyeDAO;
import com.calclogic.entity.Incluye;
import com.calclogic.entity.Teoria;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IncluyeManagerImpl implements IncluyeManager {
       
    @Autowired
    private IncluyeDAO incluyeDAO;
    
    @Override
    @Transactional
    public void addIncluye(Incluye incluye) {
        incluyeDAO.addIncluye(incluye);
    }
    
    @Override
    @Transactional
    public void deleteIncluye(Incluye incluye) {
        incluyeDAO.deleteIncluye(incluye);
    }

    @Override
    @Transactional
    public Incluye getIncluye(Teoria padre, Teoria hijo) {
        return incluyeDAO.getIncluye(padre, hijo);
    }
    
    @Override
    @Transactional
    public List<Incluye> getAllIncluye() {
        return incluyeDAO.getAllIncluye();
    }
  
    @Override
    @Transactional
    public List<Incluye> getAllIncluyeByPadre(Teoria padre) {
        return incluyeDAO.getAllIncluyeByPadre(padre);
    }
    
    @Override
    @Transactional
    public List<Incluye> geAlltIncluyeByHijo(Teoria hijo) {
        return incluyeDAO.geAlltIncluyeByHijo(hijo);
    }
}
