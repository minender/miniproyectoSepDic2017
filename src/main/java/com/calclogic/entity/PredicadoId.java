package com.calclogic.entity;

import javax.persistence.Embeddable;
import java.io.Serializable;

/**
 * @author alejandro
 */
@Embeddable
public class PredicadoId implements Serializable {

  private String alias;
  private String login;

  public PredicadoId() {}

  public PredicadoId(String alias, String loginusuario) {
    this.alias = alias;
    login = loginusuario;
  }

  public String getAlias() {
    return alias;
  }

  public void setAlias(String alias) {
    this.alias = alias;
  }

  public String getLogin() {
    return this.login;
  }

  public void setLogin(String loginusuario) {
    this.login = loginusuario;
  }

  @Override
  public boolean equals(Object other) {
    if ((this == other)) return true;
    if ((other == null)) return false;
    if (!(other instanceof PredicadoId)) return false;
    PredicadoId castOther = (PredicadoId) other;

    return ((this.getAlias() == null
                ? castOther.getAlias() == null
                : this.getAlias().equals(castOther.getAlias()))
            || (this.getAlias() != null
                && castOther.getAlias() != null
                && this.getAlias().equals(castOther.getAlias())))
        && ((this.getLogin() == null
                ? castOther.getLogin() == null
                : this.getLogin().equals(castOther.getLogin()))
            || (this.getLogin() != null
                && castOther.getLogin() != null
                && this.getLogin().equals(castOther.getLogin())));
  }

  @Override
  public int hashCode() {
    int result = 17;

    result = 37 * result + (getAlias() == null ? 0 : this.getAlias().hashCode());
    result = 37 * result + (getLogin() == null ? 0 : this.getLogin().hashCode());
    return result;
  }
}