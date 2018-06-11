package pmedved;

import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleFloatProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;


public class Artikel {


    private final SimpleStringProperty artbez;
    private final SimpleFloatProperty bruttpr;
    private final SimpleBooleanProperty isvegetarisch;
    private final SimpleStringProperty katbez;
    private final SimpleIntegerProperty version;


    Artikel(String artbez, String katbez, float bruttpr, boolean isvegetarisch, int version) {
        this.artbez = new SimpleStringProperty(artbez);
        this.katbez = new SimpleStringProperty(katbez);
        this.bruttpr = new SimpleFloatProperty(bruttpr);
        this.isvegetarisch = new SimpleBooleanProperty(isvegetarisch);
        this.version = new SimpleIntegerProperty(version);
    }

    public String getArtbez() {
        return artbez.get();
    }

    public void setartbez(String artbez) {
        this.artbez.set(artbez);
    }

    public String getKatbez() {
        return katbez.get();
    }

    public void setkatbez(String katbez) {
        this.katbez.set(katbez);
    }

    public Float getBruttpr() {
        return bruttpr.get();
    }

    public void setBruttpr(float bruttpr) {
        this.bruttpr.set(bruttpr);
    }

    public boolean getIsvegetarisch() {
        return isvegetarisch.get();
    }

    public void setIsvegetarisch(boolean isvegetarisch) {
        this.isvegetarisch.set(isvegetarisch);
    }

    public Integer getVersion() {
        return version.get();
    }

    public void setVersion(int version) {
        this.version.set(version);
    }

}