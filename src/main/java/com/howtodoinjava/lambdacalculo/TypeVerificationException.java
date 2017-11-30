/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.howtodoinjava.lambdacalculo;

/**
 *
 * @author federico
 */
public class TypeVerificationException extends Exception {

    /**
     * Creates a new instance of <code>TypeVerificationException</code> without
     * detail message.
     */
    public TypeVerificationException() {
    }

    /**
     * Constructs an instance of <code>TypeVerificationException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public TypeVerificationException(String msg) {
        super(msg);
    }
}
