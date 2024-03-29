package com.calclogic.dao;

import com.calclogic.entity.Teoria;
import com.calclogic.entity.Incluye;
import java.util.List;

public interface IncluyeDAO {

    public void addIncluye(Incluye incluye);
    
    public void deleteIncluye(Incluye incluye);

    public Incluye getIncluye(Teoria padre, Teoria hijo);
    
    public List<Incluye> getAllIncluye();
  
    public List<Incluye> getAllIncluyeByPadre(Teoria padre);
    
    public List<Incluye> geAlltIncluyeByHijo(Teoria hijo);
}