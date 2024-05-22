package com.calclogic.service;
import com.calclogic.dao.TeoremaDAO;
import com.calclogic.dao.ResuelveDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Term;
import com.calclogic.parse.CombUtilities;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Iterator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of "TeoremaManager" queries.
 *
 * @author miguel
 */
@Service
public class TeoremaManagerImpl implements TeoremaManager {

    @Autowired
    private TeoremaDAO teoremaDAO;
    @Autowired
    private ResuelveDAO resuelveDAO;
    @Autowired
    private SolucionDAO solucionDAO;
    
    //@Autowired
    //private CombUtilities combUtilities;

    /** 
     * Adds a new theorem to the table.
     * @param teorema The new theorem to be added.
     * @return Nothing.
     */
    @Override
    @Transactional
    public Teorema addTeorema(Teorema teorema) {
        // Este teorema sera utilizado para ver si ya existe en la BD
        Teorema teorema2 = this.getTeoremaByEnunciados(teorema.getEnunciado().toString());
        if (teorema2 != null) {
            return teorema2;
        } /*else {
            // Este teorema sera utilizado para ver si el inverso ya existe en la BD
            Teorema teorema3 = this.getTeoremaByEnunciados(teorema.getEnunciadoder().toString(), teorema.getEnunciadoizq().toString());
            if (teorema3 != null) {
                return teorema3;
            }
        }*/
        teoremaDAO.addTeorema(teorema);
        return teorema;
    }

	/**
     * Deletes one of the theorems of the table.
     * @param id Is the principal key of the theorem to delete.
     * @return Nothing.
     */ 
    @Override
    @Transactional
    public boolean deleteTeorema(int id, String username) {

        // Si solo hay 1 usuario usandolo, entonces aplica teoremaDAO.deleteTeorema(id)
        List <Resuelve> resuelves = resuelveDAO.getResuelveByTeorema(id);
        if (resuelves == null || resuelves.size() == 0) {
            teoremaDAO.deleteTeorema(id);
            return true;
        }
        if (resuelves.size() == 1) {
            Resuelve resuelve = resuelves.get(0);
            // Verificar que el resuelve pertenezca al usuario actual
            if (!resuelve.getUsuario().getLogin().equals(username)){
                return false;
            }
            // Evitar que se borre el resuelve si tiene soluciones
            if (solucionDAO.getAllSolucionesByResuelve(resuelve.getId()).size() > 0){
                return false;
            }
            if (resuelve.getUsuario().getLogin().equals(username)) {
                resuelveDAO.deleteResuelve((resuelve.getId()));
                teoremaDAO.deleteTeorema(id);
                return true;
            }
        }
        // Si no, se borra solo el resuelve si no hay demostraciones
        else if (resuelves.size() > 1){
            Iterator<Resuelve> resIter = resuelves.iterator();
            Resuelve resuelve = resIter.next();
            while (resIter.hasNext()
                    && (resuelve.getTeorema().getId() != id
                        || !resuelve.getUsuario().getLogin().equals(username)
                    )
                  ) {
                resuelve = resIter.next();
            }
            if (resuelve.getTeorema().getId() == id && resuelve.getUsuario().getLogin().equals(username)) {
                resuelveDAO.deleteResuelve((resuelve.getId()));
               return true;
            }
        }
        return false;
        
    }
    
    @Transactional
    public Teorema updateTeorema(int id, String username, String statement, Term teoterm, String vars) {
        Teorema teorema = teoremaDAO.getTeorema(id);
        
        if (teorema.getEnunciado().equals(statement)) {
            return teorema;
        }
        List <Resuelve> resuelves = resuelveDAO.getResuelveByTeorema(id);
        if (resuelves.size() == 1) {
            Resuelve resuelve = resuelves.get(0);
            // Verificar que el resuelve pertenezca al usuario actual
            if (!resuelve.getUsuario().getLogin().equals(username)){
                return null;
            }
            // Evitar que se borre el resuelve si tiene soluciones
            if (solucionDAO.getAllSolucionesByResuelve(resuelve.getId()).size() > 0){
                return null;
            }
            if (resuelve.getUsuario().getLogin().equals(username)) {
                //resuelveDAO.deleteResuelve((resuelve.getId()));
                //Teorema teorema = teoremaDAO.getTeorema(id);
                resuelve.setVariables(vars);
                Teorema teorema2 = teoremaDAO.getTeoremaByEnunciados(statement);
                if (teorema2 == null) {
                    teorema.setEnunciado(statement);
                    teoremaDAO.updateTeorema(teorema);
                    resuelveDAO.updateResuelve(resuelve);
                    return teorema;
                }
                else {
                    resuelve.setTeorema(teorema2);
                    resuelveDAO.updateResuelve(resuelve);
                    //teoremaDAO.deleteTeorema(id);
                    return teorema2;
                }
            }
        }
        // Si no, se borra solo el resuelve si no hay demostraciones
        else if (resuelves.size() > 1){
            Iterator<Resuelve> resIter = resuelves.iterator();
            Resuelve resuelve = resIter.next();
            while (resIter.hasNext()
                    && (resuelve.getTeorema().getId() != id
                        || !resuelve.getUsuario().getLogin().equals(username)
                    )
                  ) {
                resuelve = resIter.next();
            }
            resuelve.setVariables(vars);
            resuelveDAO.updateResuelve(resuelve);
            if (resuelve.getTeorema().getId() == id && resuelve.getUsuario().getLogin().equals(username)) {
               //Teorema teorema = teoremaDAO.getTeorema(id);
               Teorema teorema2 = this.getTeoremaByEnunciados(statement);
               if (teorema2 == null) {
                    teorema = new Teorema(statement, teoterm, false, "");
                    //teorema.setEnunciado(statement);
                    //teorema.setId(0);
                    teoremaDAO.addTeorema(teorema);
                    return teorema;
               }
               else {
                    return teorema2;
               }
            }
        }
        return null;
        
    }

	/**
     * Method to get a theorem by its principal key.
	 * If it exists, it parses the string associated with the object.
     * @param id Is the principal key of the theorem.
     */
    @Override
    @Transactional
    public Teorema getTeorema(int id, SimboloManager s) {
        Teorema teo = teoremaDAO.getTeorema(id);
        if (teo != null) {
            teo.setTeoTerm(CombUtilities.getTerm(teo.getEnunciado(),null,s));
        }
        return teo;
    }

    /**
     * Method to get a list of all the entries of the table (all the theorems),
	 * and parsing them in order to be used.
     */
    @Override
    @Transactional
    public List<Teorema> getAllTeoremas() {
        List<Teorema> teoList = teoremaDAO.getAllTeoremas();
        try {
            for (Teorema teo : teoList) {
                //ter.setTermObject((Term)ToString.fromString(ter.getSerializado()));
                teo.setTeoTerm(CombUtilities.getTerm(teo.getEnunciado(),null,null));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teoList;
    }

    /**
     * Method to get a theorem that corresponds to a statement, and then parsing it.
     * @param enunciado Is the statement used to filter the search.
     */
    @Override
    @Transactional
    public Teorema getTeoremaByEnunciados(String enunciado) {
        Teorema teo = teoremaDAO.getTeoremaByEnunciados(enunciado);
        if (teo != null) {
            teo.setTeoTerm(CombUtilities.getTerm(teo.getEnunciado(),null,null));
        }
        return teo;
    }

    /**
     * Method to get a list of theorems that correspond 
	 * to a list of Resuelve objects, and then parsing them.
     * @param resList Is the list of Resuelve objects used to filter the search.
     */
    @Override
    @Transactional
    public List<Teorema> getTeoremaByResuelveList(List<Resuelve> resList) {
        List<Teorema> teoList = new ArrayList<Teorema>();
        Teorema teorema;
        
        Collections.sort(resList, new ResuelveComparator());
        
        for (Resuelve res : resList) {
            teorema = res.getTeorema();
            teorema.setTeoTerm(CombUtilities.getTerm(teorema.getEnunciado(),null,null));
            teoList.add(teorema);
        }

        return teoList;
    }

    /**
     * Auxiliar class to implement a method that compares two Resuelve objects.
     */
    class ResuelveComparator implements Comparator<Resuelve> {

		/**
		 * Method that takes two Resuelve objects and returns the arithmetic difference
		 * of the id's of their categories.
		 * @param res1 Minuend of the difference.
		 * @param res2 Subtrahend of the difference.
		 */
        public int compare(Resuelve res1, Resuelve res2) {
            return res1.getCategoria().getId() - res2.getCategoria().getId();
        }
    }

    /**
     * Method to get a list of theorems that corresponds to a specific category.
     * @param categoriaId Is the principal key of the category (Categoria object).
     */
    @Override
    @Transactional
    public List<Teorema> getTeoremasByCategoria(int categoriaId) {
        List<Resuelve> res = resuelveDAO.getResuelveByCategoria(categoriaId);
        List<Teorema> teos = new ArrayList<Teorema>();
        for (int i=0;i<=res.size();i++){
            teos.add(res.get(i).getTeorema());
        }
        if (teos != null) {
            for (Teorema teo : teos){
               teo.setTeoTerm(CombUtilities.getTerm(teo.getEnunciado(),null,null));
            }
        }
        return teos;
    }
}
