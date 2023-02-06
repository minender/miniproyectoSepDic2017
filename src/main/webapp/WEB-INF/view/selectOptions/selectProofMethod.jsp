<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- It is not allowed to put HTML elements inside others with the "option" tag, but the title
     property serves as a tooltip.

    Source: https://stackoverflow.com/questions/3249591/how-can-i-display-a-tooltip-on-an-html-option-tag
-->

<div id="metodosDiv">
    <h3 style="color:#08c; margin:0px; padding:0px; height:40px;">Proof method</h3>
    <!-- Some methods should only be visible after the user unlocks them by doing the
         necessary demonstrations -->
    <select class="form-control" id="metodosDemostracion">
        <option title="Reset the chosen method" value="0">Select a method</option>
        <option title="Start from the theorem to be proved and end in an already proven theorem, or viceversa" value="DM">Direct method</option>
        <option title="When having an equality or equivalence, start from the desired side of it and end in the other" value="SS">Starting from one side</option>
        <option title="Like starting from one side, but having the possibility of applying a transitive operator in any step that is not =, ≡, => or <=" value="TR">Transitivity</option>
        <option title="Start from one side of an implication or consequence, and end in the other" value="WS">Weakening/Strengthening</option>
        <!--<option value="ND">Natural deduction</option>-->
        <option title="Prove that the negation of the theorem implies false" value="CO">Proof by contradiction</option>
        <option title="When having an implication or consequence, invert the direction of the arrow, negating the operands" value="CR">Counter-reciprocal</option>
        <option title="Having a conjunction, prove each operand separately" value="AI">Conjunction by parts</option>
        <option title="Transform an equivalence in a conjuntion of an implication and a consequence" value="MI">Mutual implication</option>
        <option title="Formulate some expressions (cases), prove that each one implies the theorem, and prove that the disjuntion of all the cases is true" value="CA">Case analysis</option>
        <option title="Prove (exists x | R : P) => Q by introducing a witness x' and proving (R and P)[x:=x'] => Q" value="WI">Witness</option>
    </select>
</div>