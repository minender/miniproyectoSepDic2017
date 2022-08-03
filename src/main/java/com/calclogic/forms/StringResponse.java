/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

/**
 * This is only used to send a simple String to an AJAX
 * 
 * @author ronald
 */


public class StringResponse {
    
    private String string;
    
    public StringResponse(String string) {
        this.string = string;
    }
    
    public String getString() {
        return string;
    }
}