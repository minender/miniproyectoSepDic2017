/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.calclogic.forms;

/**
 * @author alejandro
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
