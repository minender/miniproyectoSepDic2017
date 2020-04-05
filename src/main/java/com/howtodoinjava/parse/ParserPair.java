package com.howtodoinjava.parse;

import com.howtodoinjava.lambdacalculo.Term;

public class ParserPair
{
    public int symbolId;
    public Term term;

    public ParserPair(int symbol,Term term)
    {
        this.symbolId = symbol;
        this.term = term;
    }
}
