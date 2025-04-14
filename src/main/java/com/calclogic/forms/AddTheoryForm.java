/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.calclogic.forms;

/**
 *
 * @author feder
 */
import org.hibernate.validator.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

public class AddTheoryForm {
    
  @NotEmpty(message = "The name of the theory cannot be empty.")
  private String name;

  @NotNull(message = "Please select at least one parent theory.")
  private List<Integer> parentTheories;

  // Constructor
  public AddTheoryForm(String name, List<Integer> parentTheories) {
    this.name = name;
    this.parentTheories = parentTheories;
  }

  public AddTheoryForm() {}

  // Getters and setters
  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public List<Integer> getParentTheories() {
    return parentTheories;
  }

  public void setParentTheories(List<Integer> parentTheories) {
    this.parentTheories = parentTheories;
  }
}
