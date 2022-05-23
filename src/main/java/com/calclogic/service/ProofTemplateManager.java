package com.calclogic.service;

import com.calclogic.entity.ProofTemplate;
import java.util.List;

/**
 * This interface is the use of the "PlantillaTeoremaDAO" 
 * API in this application.
 *
 * @author Manuel Faria and Juan Oropeza
 */
public interface ProofTemplateManager {

    /**
     * Method to get a PlantillaTeorema object by its principal key.
     * @param id Is the principal key of the MostrarCategoria object.
     */    
    public ProofTemplate getProofTemplateById(int id);
}
