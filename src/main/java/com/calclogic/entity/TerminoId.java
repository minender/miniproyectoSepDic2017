package com.calclogic.entity;

// Generated Mar 20, 2017 12:50:11 PM by Hibernate Tools 3.2.1.GA

import javax.persistence.Embeddable;
import java.io.Serializable;

/**
 * @author alejandro
 */
@Embeddable
public class TerminoId implements Serializable {

  private String alias;
  private String login;

  public TerminoId() {}

  public TerminoId(String alias, String login) {
    this.alias = alias;
    this.login = login;
  }

  public String getAlias() {
    return this.alias;
  }

  public void setAlias(String alias) {
    this.alias = alias;
  }

  public String getLogin() {
    return this.login;
  }

  public void setLogin(String login) {
    this.login = login;
  }

  /**
   * @param other
   * @return
   */
  public boolean equals(Object other) {
    if ((this == other)) return true;
    if ((other == null)) return false;
    if (!(other instanceof TerminoId)) return false;
    TerminoId castOther = (TerminoId) other;

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
