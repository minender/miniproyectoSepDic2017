package com.calclogic.entity;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

/**
 * Class to map theorem_template entity.
 */
public class PlantillaTeorema implements java.io.Serializable {
   
    // table fields
    private int id;
    private String template;
    private String path_to_placeholders;

    @Id
    @Column(name="id")
    @GeneratedValue(
        strategy= GenerationType.SEQUENCE, 
        generator="teorema_id_seq"
    )
    @SequenceGenerator(name="teorema_id_seq", sequenceName="teorema_id_seq")

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

    public PlantillaTeorema() {}

}
