package com.calclogic.entity;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;
import java.util.Objects;

/**
 * @author alejandro
 */
@Embeddable
public class IncluyeId implements Serializable {

  @ManyToOne
  @JoinColumn(name = "padreid", nullable = false)
  private Teoria padre;

  @ManyToOne
  @JoinColumn(name = "hijoid", nullable = false)
  private Teoria hijo;

  // Getters, Setters, equals, and hashCode
  public Teoria getPadre() {
    return padre;
  }

  public void setPadre(Teoria padre) {
    this.padre = padre;
  }

  public Teoria getHijo() {
    return hijo;
  }

  public void setHijo(Teoria hijo) {
    this.hijo = hijo;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    Incluye that = (Incluye) o;
    return Objects.equals(padre, that.getId().padre) && Objects.equals(hijo, that.getId().hijo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(padre, hijo);
  }
}
