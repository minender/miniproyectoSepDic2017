package com.calclogic.dao;
import com.calclogic.entity.PlantillaTeorema;
import java.util.List;

/**
 * This interface is the API of the database queries that 
 * have to do with the table "PlantillaTeorema". 
 *
 * @author Manuel Faria and Juan Oropeza
 */
public interface PlantillaTeoremaDAO {
    
    /**
     * Method to get a PlantillaTeorema object by its principal key.
     * @param id Is the principal key of the PlantillaTeorema object.
     */
    public PlantillaTeorema getPlantillaTeoremaById(int id);
}