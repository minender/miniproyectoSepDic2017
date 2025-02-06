package com.calclogic.service;

import com.calclogic.entity.Incluye;
import com.calclogic.entity.Teoria;
import java.util.List;

public interface IncluyeManager {
    
    public void addIncluye(Incluye incluye);

    public void addIncluyeByChildTheory(Teoria childTheory, List<Integer> parentTheoryIds);
    
    public void deleteIncluye(Incluye incluye);

    public Incluye getIncluye(Teoria padre, Teoria hijo);
    
    public List<Incluye> getAllIncluye();
  
    public List<Incluye> getAllIncluyeByPadre(Teoria padre);
    
    public List<Incluye> geAlltIncluyeByHijo(Teoria hijo);
}
