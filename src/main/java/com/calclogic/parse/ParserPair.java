package com.calclogic.parse;

import com.calclogic.lambdacalculo.Term;

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
