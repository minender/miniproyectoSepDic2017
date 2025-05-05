/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.lambdacalculo;

import com.calclogic.externalservices.MicroServices;
import com.calclogic.service.ResuelveManager;
import com.calclogic.service.SimboloManager;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 *
 * @author feder
 */
@Component
@Configuration
public class StaticContextInitializer {
    
    @Autowired
    private ResuelveManager resuelveManager;
    @Autowired
    private SimboloManager simboloManager;
    @Value("${nodejs.url}")// en produccion es "http://nodejs:83/example"
    private String url_latex_to_html;
    @Autowired
    private ApplicationContext context;
    
    @PostConstruct
    public void init() {
        TypedA.setResuelveManager(resuelveManager, simboloManager);
        MicroServices.setURL_LATEX_TO_HTML(url_latex_to_html);
    }
    
    public void setUrl_latex_to_html(String URL_LATEX_TO_HTML) {
        url_latex_to_html = URL_LATEX_TO_HTML;
    }
}
