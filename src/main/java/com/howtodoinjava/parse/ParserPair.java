package com.howtodoinjava.parse;

import com.howtodoinjava.lambdacalculo.Term;

public class ParserPair
{
    public String symbol;
    public Term term;

    public ParserPair(String symbol,Term term)
    {
        this.symbol = symbol;
        this.term = term;
    }
}
