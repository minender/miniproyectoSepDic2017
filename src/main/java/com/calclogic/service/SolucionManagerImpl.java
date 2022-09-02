package com.calclogic.service;

import com.calclogic.dao.ResuelveDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Teorema;
import com.calclogic.entity.Usuario;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.parse.CombUtilities;
import com.calclogic.proof.CrudOperations;
import com.calclogic.proof.FinishedProofMethod;

import java.util.HashMap;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "SolucionManager" queries.
 *
 * @author miguel
 */
@Service
public class SolucionManagerImpl implements SolucionManager {
       
    @Autowired
    private SolucionDAO solucionDAO;
    @Autowired
    private FinishedProofMethod finiPMeth;
    @Autowired
    private CrudOperations crudOp;
    @Autowired
    private ResuelveDAO resuelveDAO;
    
    //@Autowired
    //private CombUtilities combUtilities;
    
    /** 
     * Adds a new Solucion object to the table, but it is only if all previous ones
	 * for the same theorem where already completed. It is not possible to work in new solutions
     * if there is an incomplete one.
     * @param sol The new Solucion object to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public void addSolucion(Solucion sol){        
        List<Solucion> sols = solucionDAO.getAllSolucionesByResuelve(sol.getResuelve().getId());
        boolean allResuelto = true;
        for (Solucion otherSol: sols) {
            allResuelto = allResuelto && otherSol.getResuelto();
            if (!allResuelto)
                break;
        }
        if (allResuelto)
            solucionDAO.addSolucion(sol);
    }
    
    /*@Override
    @Transactional
    public void addPaso(int solucionId, PasoInferencia paso){
        Solucion sol = solucionDAO.getSolucion(solucionId);
        sol.addArregloInferencias(paso);
        solucionDAO.updateSolucion(sol);
    }*/
    
    /**
     * Updates one of the Solucion objects of the table, and makes that the new part
	 * has the structure established in this application.
     * @param solucionId Is the principal key of the Solucion object to be updated
	 * @param typedTerm Is the Term object that will be added to the demonstration.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void updateSolucion(int solucionId, Term typedTerm){
        Solucion sol = solucionDAO.getSolucion(solucionId);
        sol.setTypedTerm(typedTerm);
        solucionDAO.updateSolucion(sol);
    }
    
    /**
     * Updates one of the Solucion objects of the table.
     * @param sol Is the Solucion object to be updated.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void updateSolucion(Solucion sol){
        solucionDAO.updateSolucion(sol);
    }
    
    /**
     * Deletes one of the Solucion objects of the table.
     * @param id Is the principal key of the Solucion object to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public boolean deleteSolucion(int id, String username){
        Solucion solucion = solucionDAO.getSolucion(id);
        if (solucion == null) {
            return false;
        }
        Resuelve resuelve = solucion.getResuelve();
        Usuario user = resuelve.getUsuario();
        Teorema teorema = resuelve.getTeorema();
        if (user.getLogin().equals(username)) {
            Set<Solucion> li = resuelve.getSolucions();
            int nSol = li.size();
            if (nSol == 1) {
                Resuelve resuelveAdmin = resuelveDAO.getResuelveByUserAndTeorema("AdminTeoremas", teorema.getId());
                if (resuelveAdmin != null) {
                    solucionDAO.deleteSolucion(id);
                    resuelveDAO.deleteResuelve(resuelve.getId());
                }
                else {
                    if (!solucionDAO.solutionsWithAxiom(teorema.getId()).isEmpty()){
                        return false;
                    }
                    solucionDAO.deleteSolucion(id);
                    resuelve.setResuelto(false);
                    resuelveDAO.updateResuelve(resuelve);
                }
            }
            else {
                if (nSol == 2) {
                    for (Solucion sol: li) {
                        if (sol.getId() != id && !sol.getResuelto()) {
                            if (!solucionDAO.solutionsWithAxiom(teorema.getId()).isEmpty()){
                                return false;
                            }
                            solucionDAO.deleteSolucion(id);
                            resuelve.setResuelto(false);
                            resuelveDAO.updateResuelve(resuelve);
                            return true;
                        }
                    }
                }
                solucionDAO.deleteSolucion(id);
                return true;
            }
            return true;   
        }
        return false;
    }
    
    /**
     * Method to get a Solucion object by its principal key.
     * @param id Is the principal key of the Solucion object.
     */ 
    @Override
    @Transactional
    public Solucion getSolucion(int id, String user){
        Solucion solucion = solucionDAO.getSolucion(id);
        if (!solucion.getDemostracion().equals("")) {
            solucion.setTypedTerm(CombUtilities.getTerm(solucion.getDemostracion(),user));
            solucion.setFinishedProofMethod(finiPMeth);
            solucion.setProofCrudOperations(crudOp);
        }
        else // case when all the proof was erased by the go back button
            solucion.setTypedTerm(null);
        return solucion;
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific Resuelve object.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
     */
    @Override
    @Transactional
    public List<Solucion> getAllSolucionesByResuelve(int resuelveId){
        List<Solucion> sols = solucionDAO.getAllSolucionesByResuelve(resuelveId);
        for (Solucion sol: sols)
            if (!sol.getDemostracion().equals(""))
                sol.setTypedTerm(CombUtilities.getTerm(sol.getDemostracion(),null));
            else
                sol.setTypedTerm(null);
        return sols;
    }
    
    /**
     * Method to get a list of the identifiers of all the entries of the table 
     * that correspond to a specific Resuelve object, including the incomplete solutions.
     * @param resuelveId Is the identifier of the Resuelve object used to filter the search.
	 * @return listaSoluciones A HashMap that relates the solutions names with their id's.
     */
    @Override
    @Transactional
    public HashMap<String,Integer> getAllSolucionesIdByResuelve(int resuelveId){

        HashMap<String, Integer> listaSoluciones = new HashMap();
        
        List<Integer> idSoluciones = solucionDAO.getAllSolucionesIdByResuelve(resuelveId); 
        String nombreSolucion;
        int i = 1;
        for (int id : idSoluciones){
            
            nombreSolucion = "Proof " + i;
            listaSoluciones.put(nombreSolucion,id);
            i++;
        }
        List<Integer> idSoluciones2 = solucionDAO.getIncompleteSolucionIdByResuelve(resuelveId);
        for (int id : idSoluciones2){
            
            nombreSolucion = "(Incomplete) Proof " + i;
            listaSoluciones.put(nombreSolucion,id);
            i++;
        }
        
        return listaSoluciones;
    
    };
}
