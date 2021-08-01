package com.calclogic.dao;

import com.calclogic.entity.Categoria;
import com.calclogic.entity.MostrarCategoria;
import com.calclogic.entity.PlantillaTeorema;
import com.calclogic.entity.Usuario;
import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Manuel Faria and Juan Oropeza
 */
@Repository
public class PlantillaTeoremaDaoImpl implements PlantillaTeoremaDAO {
    
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public PlantillaTeorema getPlantillaTeoremaById(int id) {
        return (PlantillaTeorema)this.sessionFactory.getCurrentSession()
                                     .get(PlantillaTeorema.class, id);           
    };


}