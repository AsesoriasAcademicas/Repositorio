/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Alex
 */
public class Tutoria {
    private int CodigoTutoria;
    private String AsignaturaTutoria;
    private String TemaTutoria;
    private String DudasInquietudesTutoria;

    public void setCodigoTutoria(int CodigoTutoria) {
        this.CodigoTutoria = CodigoTutoria;
    }

    public void setAsignaturaTutoria(String AsignaturaTutoria) {
        this.AsignaturaTutoria = AsignaturaTutoria;
    }

    public void setTemaTutoria(String TemaTutorial) {
        this.TemaTutoria = TemaTutorial;
    }

    public void setDudasInquietudesTutoria(String DudasInquietudesTutoria) {
        this.DudasInquietudesTutoria = DudasInquietudesTutoria;
    }

    public int getCodigoTutoria() {
        return CodigoTutoria;
    }

    public String getAsignaturaTutoria() {
        return AsignaturaTutoria;
    }

    public String getTemaTutoria() {
        return TemaTutoria;
    }

    public String getDudasInquietudesTutoria() {
        return DudasInquietudesTutoria;
    }

    public Tutoria() {
    }

    public Tutoria(int CodigoTutoria, String AsignaturaTutoria, String TemaTutoria, String DudasInquietudesTutoria) {
        this.CodigoTutoria = CodigoTutoria;
        this.AsignaturaTutoria = AsignaturaTutoria;
        this.TemaTutoria = TemaTutoria;
        this.DudasInquietudesTutoria = DudasInquietudesTutoria;
    }
}
