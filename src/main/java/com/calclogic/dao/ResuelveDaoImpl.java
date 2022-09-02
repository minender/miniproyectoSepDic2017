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
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUser(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE usuario.login = :userLogin order by char_length(numeroteorema), numeroteorema").setParameter("userLogin",userLogin).list();

    }
    
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserOrAdmin(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE usuario.login = :userLogin OR usuario.login = 'AdminTeoremas' order by char_length(numeroteorema), numeroteorema").setParameter("userLogin",userLogin).list();
    }
    
    /**
     * Method to get a list of all the theorems of a specific user that are axioms
     * or that were demonstrated without the use of the theorem that is passed as
     * an argument.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem, used to filter the search.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserWithoutAxiom(String userLogin, String teoNum){
        return this.sessionFactory.getCurrentSession()
                .createQuery("FROM Resuelve r WHERE r.usuario.login = :userLogin AND ((NOT EXISTS (SELECT s FROM Solucion s WHERE r.id = s.resuelve.id)) OR EXISTS (SELECT s FROM Solucion s, Resuelve e, Teorema t WHERE e.numeroteorema = :teoNum AND t.id = e.teorema.id AND r.id = s.resuelve.id AND NOT (s.demostracion LIKE '%A^{' || t.enunciado || '}%'))) ORDER BY char_length(r.numeroteorema), r.numeroteorema").setParameter("userLogin",userLogin).setParameter("teoNum",teoNum).list();
              // TODO: revisa si este query se puede simplificar en caso en que no haga falta eobtener en 
              // la lista el teorema teoNum
    }
    
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserOrAdminWithoutAxiom(String userLogin, String teoNum){
        return this.sessionFactory.getCurrentSession()
                .createQuery("FROM Resuelve r WHERE (r.usuario.login = :userLogin OR r.usuario.login = 'AdminTeoremas') AND ((NOT EXISTS (SELECT s FROM Solucion s WHERE r.id = s.resuelve.id)) OR EXISTS (SELECT s FROM Solucion s, Resuelve e, Teorema t WHERE e.numeroteorema = :teoNum AND t.id = e.teorema.id AND r.id = s.resuelve.id AND NOT (s.demostracion LIKE '%A^{' || t.enunciado || '}%'))) ORDER BY char_length(r.numeroteorema), r.numeroteorema").setParameter("userLogin",userLogin).setParameter("teoNum",teoNum).list();
              // TODO: revisa si este query se puede simplificar en caso en que no haga falta eobtener en 
              // la lista el teorema teoNum
    }
    
    /**
     * Method to get a list of all the entries of the table that correspond to a specific user
     * having solved the demonstration of a theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     */
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserResuelto(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE usuario.login = :userLogin AND resuelto = true").setParameter("userLogin",userLogin).list();
    }
    
    @Override
    @Transactional
    public List<Resuelve> getAllResuelveByUserOrAdminResuelto(String userLogin){
        return this.sessionFactory.getCurrentSession().createQuery("FROM Resuelve WHERE (usuario.login = :userLogin OR usuario.login = 'AdminTeoremas') AND resuelto = true").setParameter("userLogin",userLogin).list();
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
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the identifier of the theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoremaID Is the principal key of the theorem used to filter the search.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin,int teoremaID){

        String sql = "FROM Resuelve WHERE teorema.id = :teoremaID AND usuario.login = :userLogin";
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("teoremaID",teoremaID).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the statement of the theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teo Is the statement of the theorem used to filter the search.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeorema(String userLogin,String teo){
        String sql = "FROM Resuelve WHERE teorema.enunciado = :teo AND usuario.login = :userLogin";
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("teo",teo).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
    }
    
    /**
     * Method to get an entry that relates a user with a theorem, 
     * using the number of the theorem.
     * This query is made using HQL (Hibernate Query Language).
     * @param userLogin Is the string with which the user logs in, and that we use to filter the search.
     * @param teoNum Is the number of the theorem used to filter the search.
     */
    @Override
    @Transactional
    public Resuelve getResuelveByUserAndTeoNum(String userLogin,String teoNum){
        String sql = "FROM Resuelve WHERE numeroteorema = :teoNum AND usuario.login = :userLogin";
        List<Resuelve> list = this.sessionFactory.getCurrentSession().createQuery(sql).setParameter("teoNum",teoNum).setParameter("userLogin",userLogin).list();
    
        if (list.isEmpty()) {
            return null;
        } else {
            return list.get(0);
        }
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
        //System.out.println(queryStr);
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
        //System.out.println(enunciados);
        String queryStr = "FROM Resuelve r WHERE resuelto = 't' AND EXISTS (SELECT s.id FROM Solucion s WHERE s.resuelve.id = r.id) AND NOT EXISTS (SELECT s.id FROM Solucion s WHERE s.resuelve.id = r.id AND NOT ("+enunciados+"))";
        //System.out.println(queryStr);
        return this.sessionFactory.getCurrentSession().createQuery(queryStr).list();
    }
    
}
