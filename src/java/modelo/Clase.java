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
public class Clase {
    private int CodigoClase;
    private String FechaClase;
    private String HoraClase;
    private int DuracionClase;
    private Tutoria Tutoria;

    public void setCodigoClase(int CodigoClase) {
        this.CodigoClase = CodigoClase;
    }

    public void setFechaClase(String FechaClase) {
        this.FechaClase = FechaClase;
    }

    public void setHoraClase(String HoraClase) {
        this.HoraClase = HoraClase;
    }

    public void setDuracionClase(int DuracionClase) {
        this.DuracionClase = DuracionClase;
    }

    public void setTutoria(Tutoria Tutoria) {
        this.Tutoria = Tutoria;
    }

    public int getCodigoClase() {
        return CodigoClase;
    }

    public String getFechaClase() {
        return FechaClase;
    }

    public String getHoraClase() {
        return HoraClase;
    }

    public int getDuracionClase() {
        return DuracionClase;
    }

    public Tutoria getTutoria() {
        return Tutoria;
    }

    public Clase() {
    }

    public Clase(int CodigoClase, String FechaClase, String HoraClase, int DuracionClase, Tutoria Tutoria) {
        this.CodigoClase = CodigoClase;
        this.FechaClase = FechaClase;
        this.HoraClase = HoraClase;
        this.DuracionClase = DuracionClase;
        this.Tutoria = Tutoria;
    }
    
}
