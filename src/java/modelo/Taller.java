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
public class Taller {

    private int CodigoTaller;
    private String FechaEntregaTaller;
    private String HoraEntregaTaller;
    private String NombreArchivo;

    public String getNombreArchivo() {
        return NombreArchivo;
    }

    public void setNombreArchivo(String NombreArchivo) {
        this.NombreArchivo = NombreArchivo;
    }
    private Tutoria Tutoria;

    public void setCodigoTaller(int CodigoTaller) {
        this.CodigoTaller = CodigoTaller;
    }

    public void setFechaEntregaTaller(String FechaEntregaTaller) {
        this.FechaEntregaTaller = FechaEntregaTaller;
    }

    public void setHoraEntregaTaller(String HoraEntregaTaller) {
        this.HoraEntregaTaller = HoraEntregaTaller;
    }

    public void setTutoria(Tutoria Tutoria) {
        this.Tutoria = Tutoria;
    }

    public int getCodigoTaller() {
        return CodigoTaller;
    }

    public String getFechaEntregaTaller() {
        return FechaEntregaTaller;
    }

    public String getHoraEntregaTaller() {
        return HoraEntregaTaller;
    }

    public Tutoria getTutoria() {
        return Tutoria;
    }

    public Taller() {
    }

    public Taller(int CodigoTaller, String FechaEntregaTaller, String HoraEntregaTaller, Tutoria Tutoria) {
        this.CodigoTaller = CodigoTaller;
        this.FechaEntregaTaller = FechaEntregaTaller;
        this.HoraEntregaTaller = HoraEntregaTaller;
        this.Tutoria = Tutoria;
    }

}
