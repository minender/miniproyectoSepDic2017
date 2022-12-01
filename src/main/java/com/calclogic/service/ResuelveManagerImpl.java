package com.calclogic.service;

import com.calclogic.dao.ResuelveDAO;
import com.calclogic.dao.SolucionDAO;
import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Solucion;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Var;
import com.calclogic.parse.CombUtilities;
import com.calclogic.parse.TermUtilities;

import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "ResuelveManager" queries.
 *
 * @author miguel
 */
@Service
public class ResuelveManagerImpl implements ResuelveManager {
       
    @Autowired
    private ResuelveDAO resuelveDAO;
    
    @Autowired
    private SolucionDAO solucionDAO;

    //@Autowired
    //private CombUtilities combUtilities;

    /*
     * Since many methods of this class will get both the current user's resuleves 
     * and the admin's resuelves, later removing duplicates, we encapsulate that
     * part in this method.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param resuelves List of Resuelve objects to remove duplicates from
     * @return The mentioned list of Resuelve objects.
     */
    private List<Resuelve> removeResuelveDuplicates(String userLogin, List<Resuelve> resuelves){
        List<Resuelve> toRemove = new ArrayList(); // List of rows to remove

        // Copy of the original list that we sort according to theorems' ids in order that duplicates appear contiguous
        List<Resuelve> resuelvesCopy = new ArrayList<>(resuelves); 
        Collections.sort(resuelvesCopy, Resuelve.CompareByTheoremId);

        Teorema prevTeo = null;
        Resuelve prevResuelve = null;

        for (Resuelve r: resuelvesCopy) {
            Teorema t = r.getTeorema();
            if (prevTeo == t) {
                if (r.getUsuario().getLogin().equals(userLogin)){
                    toRemove.add(prevResuelve);
                } else {
                    toRemove.add(r);
                }
                continue;
            }
            prevTeo = t;
            prevResuelve = r;
        }
        resuelves.removeAll(toRemove);
        return resuelves;     
    }

    /*
     * Here we parse the corresponding theorem of a Resuelve object.
     *
     * @param resuelve The mentioned Resuelve object.
     * throws Exception
     */
    private void parseTheoremFromResuelveObject(Resuelve resuelve){
        Teorema teo = resuelve.getTeorema();
        teo.setTeoTerm(CombUtilities.getTerm(teo.getEnunciado(),null));
    }

    /*
     * Here we get parsed all the corresponding theorems of a list of Resuelve objects.
     *
     * @param resuelves The list of Resuelve objects.
     * @return The list of Resuelve objects with their theorems parsed.
     * throws Exception
     */
    private List<Resuelve> parseTheoremsFromResuelves(List<Resuelve> resuelves) throws Exception{
        for (Resuelve resuelve : resuelves) {
            this.parseTheoremFromResuelveObject(resuelve);
        }
        return resuelves;
    }

    /*
     * Takes a Resuelve object, gets all its solutions and stablishes if there is 
     * a pending demonstration in it ot not.

     * @param resuelve The mentioned Resuelve object.
     * @return The number of solutions in the Resuelve object.
     */
    private int setDemopendienteToSolsFromResuelve(Resuelve resuelve){
        List<Solucion> sols = solucionDAO.getAllSolucionesByResuelve(resuelve.getId());
        resuelve.setDemopendiente(-1);                
        int numberOfSolutions = 0;

        for (Solucion sol: sols){
            if (!sol.isResuelto()){
                resuelve.setDemopendiente(sol.getId());
            }
            numberOfSolutions ++;
        } 
        return numberOfSolutions;
    }

    /*
     * Here we get parsed the corresponding theorems of a list of Resuelve objects, but only those
     * that already have solution (the "resuelto" attribute is true).
     *
     * So also, we must set in them if they are axioms or not, because an axiom always have "resuelto"
     * as true but it doesn't have solutions.
     *
     * @param resuelves The list of Resuelve objects.
     * @return The list of Resuelve objects with their theorems parsed.
     * throws Exception
     */
    private List<Resuelve> parseTheoremsWithSolFromResuelves(List<Resuelve> resuelves) throws Exception{
        for (Resuelve resuelve : resuelves) {              
            int numberOfSolutions = this.setDemopendienteToSolsFromResuelve(resuelve);
            Boolean isAxiom = (resuelve.isResuelto()) && (numberOfSolutions == 0);
            resuelve.setEsAxioma(isAxiom);
            this.parseTheoremFromResuelveObject(resuelve);
        }
        return resuelves;
    }

    /*
     * Receives a list of Resuelve objects and invokes a function to parse all the
     * corresponding theorems. Also, it previously invokes a function to remove the 
     * possible duplicates if the "resuelves" of 'AdminTeoremas' are considered.
     *
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param resuelves The original list of Resuelve objects.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The modified list of Resuelve objects
     */
    private List<Resuelve> parsedResuelvesList(String userLogin, List<Resuelve> resuelves, Boolean orAdmin){
        if (orAdmin){
            resuelves = this.removeResuelveDuplicates(userLogin, resuelves);
        }
        try {
            resuelves = this.parseTheoremsWithSolFromResuelves(resuelves);
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        return resuelves;
    }
    
    /** 
     * Adds a new object entry to the table only if an equivalent one has not been added yet,
     * and if so then returns again the object. Otherwise, it returns the equivalent object that was previously added.
     * @param resuelve The new Resuelve object to be added.
     * @return The added Resuelve object
     */
    @Override
    @Transactional
    public Resuelve addResuelve(Resuelve resuelve){
        Resuelve res = this.getResuelveByUserAndTeorema(resuelve.getUsuario().getLogin(),resuelve.getTeorema().getId(),false);
        if (res != null){
            return res;
        }
        resuelveDAO.addResuelve(resuelve);
        return resuelve;
    }
    
    /**
     * Updates one of the Resuelve objects of the table.
     * @param resuelve Is the Resuelve object to be updated.
     */   
    @Override   
    @Transactional
    public void updateResuelve(Resuelve resuelve){
        resuelveDAO.updateResuelve(resuelve);
    }

    /**
     * Deletes one of the Resuelve objects of the table.
     * @param id Is the principal key of the Resuelve object to delete.
     */   
    @Override
    @Transactional
    public void deleteResuelve(int id){
        resuelveDAO.deleteResuelve(id);
    }
    
    /**
     * Method to get a Resuelve object by its principal key.
     * @param id Is the principal key of the Resuelve object.
     * @return The Resuelve object.
     */ 
    @Override
    @Transactional
    public Resuelve getResuelve(int id){
        return resuelveDAO.getResuelve(id);
    }
    
    /**
     * Method to get a list of all the entries of the table.
     * @return All the Resuelve objects of the database.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelve(){
        return resuelveDAO.getAllResuelve();
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @return The mentioned list of Resuelve objects.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUser(String userLogin){
        List<Resuelve> resuelves = resuelveDAO.getAllResuelveByUser(userLogin, false);
        return resuelves;
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user, and also
     * establishes for each one if it is an axiom or not.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The mentioned list of Resuelve objects.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserWithSol(String userLogin, Boolean orAdmin){
        List<Resuelve> resuelves = resuelveDAO.getAllResuelveByUser(userLogin, orAdmin);
        return this.parsedResuelvesList(userLogin, resuelves, orAdmin);
    }
    
    /**
     * Method to get a list of all the theorems of a specific user that are axioms
     * or that were demonstrated without the use of the theorem that is passed as
     * an argument.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem, used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The list of the Resuelve objects in which the theorems fulfill the mentioned condition.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserWithSolWithoutAxiom(String userLogin, String teoNum, Boolean orAdmin){
        List<Resuelve> resuelves = resuelveDAO.getAllResuelveByUserWithoutAxiom(userLogin, teoNum, orAdmin);
        return this.parsedResuelvesList(userLogin, resuelves, orAdmin);
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user
     * having solved the demonstration of a theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     * @return The mentioned list of Resuelve objects.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin, Boolean orAdmin){
        List<Resuelve> resuelves = resuelveDAO.getAllResuelveByUserResuelto(userLogin, orAdmin);
        return this.parsedResuelvesList(userLogin, resuelves, orAdmin);
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific theorem (Teorema object).
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    @Override
    @Transactional
    public List<Resuelve> getResuelveByTeorema(int teoremaID){
        return resuelveDAO.getResuelveByTeorema(teoremaID);
    }
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the statement of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teo Is the statement of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin, String teo, Boolean orAdmin){
        return resuelveDAO.getResuelveByUserAndTeorema(userLogin, teo, orAdmin);
    }
	
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the identifier of the theorem.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin, int teoremaID, Boolean orAdmin){
        Resuelve resuelve = resuelveDAO.getResuelveByUserAndTeorema(userLogin, teoremaID, orAdmin);
        if (resuelve != null) {
            this.parseTheoremFromResuelveObject(resuelve);
        }
        return resuelve;
    }
	
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the number of the theorem.
	 * If it exists, it parses the string associated with the object.
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeoNum(String userLogin, String teoNum, Boolean orAdmin){
        Resuelve resuelve = resuelveDAO.getResuelveByUserAndTeoNum(userLogin, teoNum, orAdmin);
        if (resuelve != null) {
            this.setDemopendienteToSolsFromResuelve(resuelve);
            this.parseTheoremFromResuelveObject(resuelve);
        }
        return resuelve;
    }
    
    @Override
    @Transactional
    public List<Resuelve> getResuelveDependent(String userLogin, List<Resuelve> resuelves){
        HashMap<Integer, Resuelve> dependent = new HashMap<>();
        for (Resuelve r: resuelves) {
            dependent.put(r.getId(), r);
        }
        int prevSize = 0;
        while (prevSize != dependent.size()) {
            prevSize = dependent.size();
            List<Resuelve> current = new ArrayList<>(dependent.values());
            List<Resuelve> toAdd = resuelveDAO.getResuelveDependent(userLogin, current);
            for (Resuelve r: toAdd) {
                dependent.put(r.getId(), r);
            }
        }
        return new ArrayList<>(dependent.values());
    }
    
    @Override
    @Transactional
    public List<Resuelve> getResuelveDependentGlobal(List<Resuelve> resuelves){
        HashMap<Integer, Resuelve> dependent = new HashMap<>();
        for (Resuelve r: resuelves) {
            dependent.put(r.getId(), r);
        }
        int prevSize = 0;
        while (prevSize != dependent.size()) {
            prevSize = dependent.size();
            List<Resuelve> current = new ArrayList<>(dependent.values());
            List<Resuelve> toAdd = resuelveDAO.getResuelveDependentGlobal(current);
            for (Resuelve r: toAdd) {
                dependent.put(r.getId(), r);
            }
        }
        return new ArrayList<>(dependent.values());
    }

    /**
     * Method to determine if a symbol represents a reflexive operator.
     * (The result will depend on whether the user has already demonstrated
     *  that it is reflexive or not; that's the reason why this function
     *  is in this class and not in SimboloManagerImpl).
     * 
     * @param username Is the string with which the user logs in, and that we use to filter the search.
     * @param symbolNotation Like c_{1}
     * @return If the symbolNotation represents a reflexive operator or not
     */ 
    @Override
    @Transactional
    public int isReflexiveOperatorForUser(String username, String symbolNotation){
        String comb = "= (\\Phi_{K} T) (\\Phi_{(b,)} "+ symbolNotation + ")"; // P op P
        Resuelve resuelve1 = getResuelveByUserAndTeorema(username, comb, true);
        if (resuelve1 != null && resuelve1.isResuelto())
            return 1;
        else {
            comb = "= (\\Phi_{K} c_{8}) (\\Phi_{(b,)} "+symbolNotation + ")"; // P op P == true (DOES NOT WORK YET)
            Resuelve resuelve2 = getResuelveByUserAndTeorema(username, comb, true);
            if (resuelve2 != null && resuelve2.isResuelto())
                return 2;
        }
        return 0;
    } 
}