package com.calclogic.service;

import com.calclogic.entity.ProofTemplate;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.calclogic.dao.ProofTemplateDAO;

/**
 * This class has the implementation of "PlantillaTeoremaManager" queries.
 *
 * @author Manuel Faria and Juan Oropeza
 */
@Service
public class ProofTemplateManagerImpl implements ProofTemplateManager {

    @Autowired
    private ProofTemplateDAO proofTemplateDAO;

    /**
     * Method to get a PlantillaTeorema object by its principal key.
     * @param id Is the principal key of the MostrarCategoria object.
     */
    @Override
    @Transactional
    public ProofTemplate getProofTemplateById(int id) {
        return proofTemplateDAO.getProofTemplateById(id);
    };
    

}
