package com.calclogic.entity;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author alejandro
 */
@Entity
public class Incluye implements Serializable {

  @EmbeddedId private IncluyeId id;

  // Getters y setters
  public IncluyeId getId() {
    return id;
  }

  public void setId(IncluyeId id) {
    this.id = id;
  }

  //  @Id
  //  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "incluye_id_seq")
  //  @SequenceGenerator(name = "incluye_id_seq", sequenceName = "incluye_id_seq", allocationSize =
  // 1)
  //  private int id;

  //  @ManyToOne
  //  @JoinColumn(name = "padreid", nullable = false)
  //   Teoria padre;
  //
  //  @ManyToOne
  //  @JoinColumn(name = "hijoid", nullable = false)
  //   Teoria hijo;
  //
  //  public Incluye() {}
  //
  //  public Incluye(Teoria padre, Teoria hijo) {
  //    this.padre = padre;
  //    this.hijo = hijo;
  //  }
  //
  //  public int getId() {
  //    return id;
  //  }
  //
  //  public void setId(int id) {
  //    this.id = id;
  //  }
  //
  //  public Teoria getPadre() {
  //    return padre;
  //  }
  //
  //  public Teoria getHijo() {
  //    return hijo;
  //  }
  //
  //  public void setPadre(Teoria teoria) {
  //    this.padre = teoria;
  //  }
  //
  //  public void setHijo(Teoria teoria) {
  //    this.hijo = teoria;
  //  }
}
