/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.calclogic.entity;

import java.io.Serializable;
import javax.persistence.*;

/**
 * @author alejandro
 */
@Embeddable
public class MostrarCategoriaId implements Serializable {

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "usuariologin", nullable = false)
  private Usuario usuario;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "categoriaid", nullable = false)
  private Categoria categoria;

  public MostrarCategoriaId() {
  }

  public MostrarCategoriaId(Usuario usuario, Categoria categoria) {
    this.usuario = usuario;
    this.categoria = categoria;
  }

  public Categoria getCategoria() {
    return categoria;
  }

  public Usuario getUsuario() {
    return usuario;
  }

  public void setCategoria(Categoria categoria) {
    this.categoria = categoria;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }
}
