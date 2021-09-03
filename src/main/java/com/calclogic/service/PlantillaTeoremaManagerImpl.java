package com.calclogic.service;

import com.calclogic.dao.PlantillaTeoremaDAO;
import com.calclogic.entity.PlantillaTeorema;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * This class has the implementation of "PlantillaTeoremaManager" queries.
 *
 * @author Manuel Faria and Juan Oropeza
 */
@Service
public class PlantillaTeoremaManagerImpl implements PlantillaTeoremaManager {

    @Autowired
    private PlantillaTeoremaDAO plantillaTeoremaDAO;

    /**
     * Method to get a PlantillaTeorema object by its principal key.
     * @param id Is the principal key of the MostrarCategoria object.
     */
    @Override
    @Transactional
    public PlantillaTeorema getPlantillaTeoremaById(int id) {
        return plantillaTeoremaDAO.getPlantillaTeoremaById(id);
    };
    

}
