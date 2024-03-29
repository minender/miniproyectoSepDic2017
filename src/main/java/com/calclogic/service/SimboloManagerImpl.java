package com.calclogic.service;

import com.calclogic.dao.IncluyeDAO;
import com.calclogic.dao.ResuelveDAO;
import com.calclogic.dao.SimboloDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.dao.TeoremaDAO;
import com.calclogic.dao.TeoriaDAO;
import com.calclogic.entity.Incluye;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Simbolo;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import com.calclogic.entity.Teoria;
import java.sql.BatchUpdateException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "SimboloManager" queries.
 *
 * @author jt
 */
@Service
public class SimboloManagerImpl implements SimboloManager {
       
    // @Autowired
    private SimboloDAO simboloDAO;
    @Autowired
    private SolucionDAO solucionDAO;
    @Autowired
    private TeoremaDAO teoremaDAO;
    @Autowired
    private ResuelveDAO resuelveDAO;
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private TeoriaDAO teoriaDAO;
    @Autowired
    private IncluyeDAO incluyeDAO;
    private int propFunApp;
    private int termFunApp;
    Simbolo[] symbolsCache; 
    
    @Autowired
    public SimboloManagerImpl(SimboloDAO simboloDAO) {
        this.simboloDAO = simboloDAO;
        List<Simbolo> l = simboloDAO.getAllSimbolo();
        Simbolo last = l.get(l.size()-1);
        int lastIndex = last.getId();
        symbolsCache = new Simbolo[lastIndex + 1];
        for (Simbolo s: l)
            symbolsCache[s.getId()] = s;
    }
    
    public int getPropFunApp() {
        return propFunApp;
    }
    
    public int getTermFunApp() {
        return termFunApp;
    }
    
    public String propFunAppSym() {
        return "c_{"+ propFunApp +"}";
    }
    
    public String termFunAppSym() {
        return "c_{"+ termFunApp +"}";
    }
	
    public void setPropFunApp(int propFunApp) {
        this.propFunApp = propFunApp;
    }
    
    public void setTermFunApp(int termFunApp) {
        this.termFunApp = termFunApp;
    }
    
    /** 
     * Adds a new symbol (Simbolo object) to the table.
     * @param simbolo The new symbol to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public Simbolo addSimbolo(Simbolo simbolo){
        simboloDAO.addSimbolo(simbolo);
        List<Simbolo> l = simboloDAO.getAllSimbolo();
        Simbolo last = l.get(l.size()-1);
        int lastIndex = last.getId();
        symbolsCache = new Simbolo[lastIndex + 1];
        for (Simbolo s: l)
            symbolsCache[s.getId()] = s;
        //for (int i=0; i < l.size(); i++)
        //    symbolsCache[i] = l.get(i);
        return simbolo;
    }
    
    /**
     * This method let us update the entry that corresponds to an already 
     * stored symbol. For example, to update the code that creates it.
     * @param simbolo Is the Simbolo object to be updated.
     * @return Nothing.
     */ 
    @Override   
    @Transactional
    public void updateSimbolo(Simbolo simbolo){
        int id = simbolo.getId();
        if (0 < id && id <= symbolsCache.length) {
            symbolsCache[id] = simbolo;
        }
        simboloDAO.updateSimbolo(simbolo);
    }
    
    /**
     * Deletes one of the symbols of the table.
     * @param id Is the principal key of the symbol to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public String deleteSimbolo(int id, String username){
        List<Teorema> orphans = teoremaDAO.getAllTeoremasWithSimbolo(id);
        List<Integer> orphanIds = new ArrayList<Integer>();
        for (Teorema t: orphans) {
            orphanIds.add(t.getId());
        }
        List<Resuelve> resuelves = resuelveDAO.getResuelveByTeoremas(orphanIds);
        List<Resuelve> resuelves_user = new ArrayList<>();
        for (Resuelve r: resuelves) {
            if (r.getUsuario().getLogin().equals(username)) {
                resuelves_user.add(r);
            }
        }
        //List<Resuelve> dependents_user = resuelveManager.getResuelveDependent(username, resuelves);
        if (resuelves_user.size() > 0) {
            String numsTeo = "";
            for (Resuelve r: resuelves_user) {
                if (numsTeo.equals("")) {
                    numsTeo = r.getNumeroteorema();
                }
                else {
                    numsTeo = numsTeo + ", " + r.getNumeroteorema();
                }
            }
            return "Couldn't delete Symbol because the following theorems use it:\n" + numsTeo;
        }
        
        List<Resuelve> dependents = resuelveManager.getResuelveDependentGlobal(resuelves);
        List<Integer> dependentsIds = new ArrayList<>();
        for (Resuelve r: dependents) {
            dependentsIds.add(r.getId());
        }
        List<Solucion> soluciones = solucionDAO.getAllSolucionesByResuelves(dependentsIds);
        
        for (Solucion s: soluciones) {
            solucionDAO.deleteSolucion(s.getId());
        }
        for (Resuelve r: dependents) {
            r.setResuelto(false);
        }
        for (Resuelve r: dependents) {
            resuelveDAO.deleteResuelve(r.getId());
        }
        for (Teorema t: orphans) {
            teoremaDAO.deleteTeorema(t.getId());
        }
        simboloDAO.deleteSimbolo(id);
        symbolsCache[id] = null;
        return "Symbol deleted";
    }
    
    /**
     * Method to get a Simbolo object by its principal key.
     * @param id Is the principal key of the Simbolo object.
     */ 
    @Override
    @Transactional
    public Simbolo getSimbolo(int id){
        if (0 < id && id < symbolsCache.length)
            return symbolsCache[id];
        else
            return null;
    }
    
    /**
     * Method to get a list of all the entries of the table.
     */
    @Override
    @Transactional
    public List<Simbolo> getAllSimbolo(){
        List<Simbolo> list = new ArrayList<Simbolo>();
        for (int i= 0; i < symbolsCache.length; i++)
            if (i >= 0 && symbolsCache[i] != null)
                list.add(symbolsCache[i]);
        return list;
    }
    
    @Override
    @Transactional
    public List<Simbolo> getAllSimboloByTeoria(int teoriaid){
        Teoria teoria = teoriaDAO.getTeoria(teoriaid);
        List<Incluye> incluyes = incluyeDAO.geAlltIncluyeByHijo(teoria);
        HashSet teoriaids = new HashSet();
        for (Incluye inc: incluyes) {
            teoriaids.add(inc.getPadre().getId());
        }
        teoriaids.add(teoriaid);
        List<Simbolo> list = new ArrayList<Simbolo>();
        for (int i= 0; i < symbolsCache.length; i++)
            if (i >= 0 && symbolsCache[i] != null && (teoriaids.contains(symbolsCache[i].getTeoria().getId())))
                list.add(symbolsCache[i]);
        return list;
    }
    
}
