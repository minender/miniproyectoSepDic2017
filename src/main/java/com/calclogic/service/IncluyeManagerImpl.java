
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.service;

import com.calclogic.dao.IncluyeDAO;
import com.calclogic.entity.Incluye;
import com.calclogic.entity.IncluyeId;
import com.calclogic.entity.Teoria;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IncluyeManagerImpl implements IncluyeManager {
       
    @Autowired
    private IncluyeDAO incluyeDAO;
    
    @Autowired
    private TeoriaManager teoriaManager;
    
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
    
    @Override
    @Transactional
    public void addIncluyeByChildTheory(Teoria childTheory, List<Integer> parentTheoryIds) {
      
        for (int i = 0; i < parentTheoryIds.size(); i++) {

          // Get the theory
          Teoria parent = teoriaManager.getTeoria(parentTheoryIds.get(i));
          
          if (parent == null) {
            
            try {
              throw new Exception("Parent theory with id " + parentTheoryIds.get(i) + " not found");
            } catch (Exception ex) {
              Logger.getLogger(IncluyeManagerImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
            
          }
          
          // Create Incluye relationships
          Incluye incluye = new Incluye();
          IncluyeId incluyeId = new IncluyeId();
          incluyeId.setPadre(parent);
          incluyeId.setHijo(childTheory);
          incluye.setId(incluyeId);

          // Save the Incluye relationship
          this.addIncluye(incluye);


        }
    }
}
