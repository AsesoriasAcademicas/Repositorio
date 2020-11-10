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
public class Persona {
    private int CodigoPersona;
    private String NombrePersona;
    private String EmailPersona;
    private String PasswordPersona;
    private String TipoPersona;
    private String TelefonoPersona;
    private String DireccionPersona;

    public void setCodigoPersona(int CodigoPersona) {
        this.CodigoPersona = CodigoPersona;
    }

    public void setNombrePersona(String NombrePersona) {
        this.NombrePersona = NombrePersona;
    }

    public void setEmailPersona(String EmailPersona) {
        this.EmailPersona = EmailPersona;
    }

    public void setPasswordPersona(String PasswordPersona) {
        this.PasswordPersona = PasswordPersona;
    }

    public void setTipoPersona(String TipoPersona) {
        this.TipoPersona = TipoPersona;
    }

    public void setTelefonoPersona(String TelefonoPersona) {
        this.TelefonoPersona = TelefonoPersona;
    }

    public void setDireccionPersona(String DireccionPersona) {
        this.DireccionPersona = DireccionPersona;
    }

    public void setBarrioResidenciaPersona(String BarrioResidenciaPersona) {
        this.BarrioResidenciaPersona = BarrioResidenciaPersona;
    }

    public int getCodigoPersona() {
        return CodigoPersona;
    }

    public String getNombrePersona() {
        return NombrePersona;
    }

    public String getEmailPersona() {
        return EmailPersona;
    }

    public String getPasswordPersona() {
        return PasswordPersona;
    }

    public String getTipoPersona() {
        return TipoPersona;
    }

    public String getTelefonoPersona() {
        return TelefonoPersona;
    }

    public String getDireccionPersona() {
        return DireccionPersona;
    }

    public String getBarrioResidenciaPersona() {
        return BarrioResidenciaPersona;
    }

    public Persona() {
    }

    public Persona(int CodigoPersona, String NombrePersona, String EmailPersona, String PasswordPersona, String TipoPersona, String TelefonoPersona, String DireccionPersona, String BarrioResidenciaPersona) {
        this.CodigoPersona = CodigoPersona;
        this.NombrePersona = NombrePersona;
        this.EmailPersona = EmailPersona;
        this.PasswordPersona = PasswordPersona;
        this.TipoPersona = TipoPersona;
        this.TelefonoPersona = TelefonoPersona;
        this.DireccionPersona = DireccionPersona;
        this.BarrioResidenciaPersona = BarrioResidenciaPersona;
    }
    private String BarrioResidenciaPersona;
}
