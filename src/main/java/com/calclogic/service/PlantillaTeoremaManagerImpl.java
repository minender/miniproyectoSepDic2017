package com.calclogic.service;

import com.calclogic.dao.PlantillaTeoremaDAO;
import com.calclogic.entity.PlantillaTeorema;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Manuel Faria and Juan Oropeza
 */
@Service
public class PlantillaTeoremaManagerImpl implements PlantillaTeoremaManager {

    @Autowired
    private PlantillaTeoremaDAO plantillaTeoremaDAO;

    @Override
    @Transactional
    public List<PlantillaTeorema> getAllPlantillaTeorema() {
        List<PlantillaTeorema> teoList = plantillaTeoremaDAO
                                            .getAllPlantillaTeorema();
        return teoList;
    }

}
