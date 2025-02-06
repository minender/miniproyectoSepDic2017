/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;


import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
//import javax.annotation.PostConstruct;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

/**
 *
 * @author feder
 */
@Component
public class StaticContextInitializer {
    
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private SimboloManager simboloManager;
    @Autowired
    private ApplicationContext context;
    
    @PostConstruct
    public void init() {
        TypedA.setResuelveManager(resuelveManager, simboloManager);
    }
}
