package com.calclogic.entity;

import javax.persistence.*;

/** Class to map theorem_template entity. */
@Entity
public class ProofTemplate implements java.io.Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "proof_template_id_seq")
  @SequenceGenerator(
      name = "proof_template_id_seq",
      sequenceName = "proof_template_id_seq",
      allocationSize = 1)
  private int id;

  @Column(nullable = false)
  private String template;

  @Column(nullable = false)
  private String path_to_placeholders;

  public int getId() {
    return this.id;
  }

  public String getTemplate() {
    return this.template;
  }

  public void setId(int id) {
    this.id = id;
  }

  public void setTemplate(String template) {
    this.template = template;
  }

  public String getPath_to_placeholders() {
    return this.path_to_placeholders;
  }

  public void setPath_to_placeholders(String path_to_placeholders) {
    this.path_to_placeholders = path_to_placeholders;
  }

  public ProofTemplate() {}
}
