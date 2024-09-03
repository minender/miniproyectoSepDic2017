package com.calclogic.dao;

import com.calclogic.entity.Resuelve;
import com.calclogic.entity.Teorema;
import com.calclogic.lambdacalculo.Term;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.SerializationUtils;

/**
 * This class has the implementation of the database queries that 
 * have to do with the table "Resuelve".
 *
 * That table implements the relation between the users and the
 * theorems, indicating if the user has solved their respective
 * demonstrations or not.
 *
 * @author miguel
 */
@Repository
public class ResuelveDaoImpl implements ResuelveDAO {
    
    @Autowired
    private SessionFactory sessionFactory;

    private String onlyUserQuery = " usuario.login = :userLogin ";
    private String userOrAdminQuery = " (usuario.login = :userLogin OR usuario.login = 'AdminTeoremas') ";

    private String resuelveOnlyUserQuery = " r.usuario.login = :userLogin ";
    private String resuelveUserOrAdminQuery = " (r.usuario.login = :userLogin OR r.usuario.login = 'AdminTeoremas') ";
    
    private String teoriaQuery = " (r.teoria IN (SELECT teoria FROM Usuario u WHERE u.login = :userLogin) OR EXISTS (SELECT i.padre FROM Usuario u, Incluye i WHERE u.login = :userLogin AND i.padre = r.teoria AND i.hijo = u.teoria)) ";
    
    /** 
     * Adds a new Resuelve object to the table.
     * This query is made using standard Hibernate library functions.
     * @param resuelve The new Resuelve object to be added.
     * @return Nothing.
     */
    @Override   
    @Transactional
    public void addResuelve(Resuelve resuelve){
        this.sessionFactory.getCurrentSession().save(resuelve);
    }
  
    /**
     * Updates one of the Resuelve objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param resuelve Is the Resuelve object to be updated.
     * @return Nothing.
     */   
    @Override   
    @Transactional
    public void updateResuelve(Resuelve resuelve){
        this.sessionFactory.getCurrentSession().update(resuelve);
    }
      
    /**
     * Deletes one of the Resuelve objects of the table.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Resuelve object to delete.
     * @return Nothing.
     */   
    @Override
    @Transactional
    public void deleteResuelve(int id){
        Resuelve resuelve = (Resuelve) sessionFactory.getCurrentSession().load(
				Resuelve.class, id);
        if (null != resuelve) {
        	this.sessionFactory.getCurrentSession().delete(resuelve);
        }
    }
    
    /**
     * Method to get a Resuelve object by its principal key.
     * This query is made using standard Hibernate library functions.
     * @param id Is the principal key of the Resuelve object.
     */ 
    @Override
    @Transactional
    public Resuelve getResuelve(int id){
        return (Resuelve)this.sessionFactory.getCurrentSession().get(Resuelve.class,id);
    }
    
    /**
     * Method to get a list of all the entries of the table.
     * This query is made using HQL (Hibernate Query Language).
     */  
    @Override
    @Transactional
    public List<Resuelve> getAllResuelve(){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve").list();
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUser(String userLogin, Boolean orAdmin){
        String user = orAdmin ? this.resuelveUserOrAdminQuery : this.resuelveOnlyUserQuery;
        String query = "FROM Resuelve r WHERE" + user + " AND "+this.teoriaQuery+" order by char_length(numeroteorema), numeroteorema";
        return this.sessionFactory.getCurrentSession().createQuery(query).setParameter("userLogin",userLogin).list();
    }
    
    /**
     * Method to get a list of all the theorems of a specific user that are axioms
     * or that were demonstrated without the use of the theorem that is passed as
     * an argument.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem, used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserWithoutAxiom(String userLogin, String teoNum, Boolean orAdmin){
        String user = orAdmin ? this.resuelveUserOrAdminQuery : this.resuelveOnlyUserQuery;
        String query = "FROM Resuelve r WHERE" + user +" AND "+this.teoriaQuery+" AND ((NOT EXISTS (SELECT s FROM Solucion s WHERE r.id = s.resuelve.id)) OR EXISTS (SELECT s FROM Solucion s, Resuelve e, Teorema t WHERE e.numeroteorema = :teoNum AND t.id = e.teorema.id AND r.id = s.resuelve.id AND NOT (s.demostracion LIKE '%A^{' || t.enunciado || '}%'))) ORDER BY char_length(r.numeroteorema), r.numeroteorema";
        return this.sessionFactory.getCurrentSession().createQuery(query).setParameter("userLogin",userLogin).setParameter("teoNum",teoNum).list();
      // TODO: revisa si este query se puede simplificar en caso en que no haga falta obtener en 
      // la lista el teorema teoNum
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user
     * having solved the demonstration of a theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin, Boolean orAdmin){
        String user = orAdmin ? this.userOrAdminQuery : this.onlyUserQuery;
        String query = "FROM Resuelve r WHERE" + user + " AND " + this.teoriaQuery + " AND resuelto = true";
        return this.sessionFactory.getCurrentSession().createQuery(query).setParameter("userLogin",userLogin).list();
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond 
     * to a specific theorem (Teorema object).
     * This query is made using HQL (Hibernate Query Language).
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    @Override
    @Transactional
    public List<Resuelve> getResuelveByTeorema(int teoremaID){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE teorema.id = :teoremaID").setParameter("teoremaID",teoremaID).list();
    }
    
    @Override
    @Transactional
    public List<Resuelve> getResuelveByTeoremas(List<Integer> teoremas){
        if (teoremas.size() == 0)
            return new ArrayList<Resuelve>();
        String tuple = "";
        for (Integer id: teoremas) {
            if (tuple == "") {
                tuple = "(" + id.toString();
            }
            else {
                tuple = tuple + "," + id.toString();
            }
        }
        tuple = tuple + ")";
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE teorema.id IN " + tuple).list();
    }

    /* 
     * Auxiliar function to return the Resuelve object associated with the user
     * and not the one associated with AdminTeoremas when a query returns both.
     * If the query returns a single one, we return that one
     */
    private Resuelve correctResuelve(List<Resuelve> list){
        if (list.isEmpty()) {
            return null;
        } 
        else if (list.size() == 1){
            return list.get(0);
        }
        else{ // At most, the list can have two elements
            if ("AdminTeoremas".equals(list.get(0).getUsuario().getLogin())){
                return list.get(1);
            }
            return list.get(0);
        }
    }
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the identifier of the theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin, int teoremaID, Boolean orAdmin){
        String user = orAdmin ? this.userOrAdminQuery : this.onlyUserQuery;
        String query = "FROM Resuelve r WHERE teorema.id = :teoremaID "+" AND "+this.teoriaQuery+" AND" + user;
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(query).setParameter("teoremaID",teoremaID).setParameter("userLogin",userLogin).list();
    
        return correctResuelve(list);
    }
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the statement of the theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teo Is the statement of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin, String teo, Boolean orAdmin){
        String user = orAdmin ? this.userOrAdminQuery : this.onlyUserQuery;
        String query = "FROM Resuelve r WHERE teorema.enunciado = :teo AND "+this.teoriaQuery+" AND" + user;
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(query).setParameter("teo",teo).setParameter("userLogin",userLogin).list();
    
        return correctResuelve(list);
    }
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the number of the theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem used to filter the search.
     * @param orAdmin Determines if in the query we must include the Resuelve objects of the admin of the app.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum, Boolean orAdmin){
        String user = orAdmin ? this.userOrAdminQuery : this.onlyUserQuery;
        String query = "FROM Resuelve r WHERE numeroteorema = :teoNum AND "+this.teoriaQuery + " AND " + user;
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(query).setParameter("teoNum",teoNum).setParameter("userLogin",userLogin).list();
    
        return correctResuelve(list);
    }

    /**
     * Method to get a list of all the entries of the table that correspond to a
     * specific category (Categoria object),
     * This query is made using HQL (Hibernate Query Language).
     * @param categoriaId Is the principal key of the category used to filter the search.
     */
    @Override
    public List<Resuelve> getResuelveByCategoria(int categoriaId) {
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE categoria.id = :categoriaId").setParameter("categoriaId", categoriaId).list();
    }
    
    @Override
    public List<Resuelve> getResuelveDependent(String userLogin, List<Resuelve> resuelves) {
        String enunciados = "";
        for (Resuelve r: resuelves) {
            String enunciado = "s.demostracion LIKE '%A^{" + r.getTeorema().getEnunciado() + "}%'";
            if (enunciados.equals("")) {
                enunciados = enunciado;
            }
            else {
                enunciados = enunciados + " OR " + enunciado;
            }
        }
        String queryStr = "FROM Resuelve r WHERE (r.usuario.login = :userLogin OR r.usuario.login = 'adminTeoremas') AND EXISTS (SELECT s.id FROM Solucion s WHERE s.resuelve.id = r.id) AND resuelto = 't' AND NOT EXISTS (SELECT s.id FROM Solucion s WHERE s.resuelve.id = r.id AND NOT ("+enunciados+"))";
        return this.sessionFactory.getCurrentSession().createQuery(queryStr).setParameter("userLogin",userLogin).list();
    }
    
    @Override
    public List<Resuelve> getResuelveDependentGlobal(List<Resuelve> resuelves) {
        String enunciados = "";
        for (Resuelve r: resuelves) {
            String enunciado = "s.demostracion LIKE '%A^{" + r.getTeorema().getEnunciado() + "}%'";
            if (enunciados.equals("")) {
                enunciados = enunciado;
            }
            else {
                enunciados = enunciados + " OR " + enunciado;
            }
        }
        String queryStr = "FROM Resuelve r WHERE resuelto = 't' AND EXISTS (SELECT s.id FROM Solucion s WHERE s.resuelve.id = r.id) AND NOT EXISTS (SELECT s.id FROM Solucion s WHERE s.resuelve.id = r.id AND NOT ("+enunciados+"))";
        return this.sessionFactory.getCurrentSession().createQuery(queryStr).list();
    }
    
}