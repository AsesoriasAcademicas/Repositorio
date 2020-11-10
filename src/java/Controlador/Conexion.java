/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Alex
 */
public class Conexion {
    private Connection cn;

    public Connection getCn() {
        return cn;
    }

    public void setCn(Connection cn) {
        this.cn = cn;
    }
    
    public void conectar() throws Exception {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://node58556-env-0941534.ric.jelastic.vps-host.net:3306/bdasesoriasacademicas?useUnicode=true&characterEncoding=utf-8&user=root&password=ISFbrh80716");
            //cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdasesoriasacademicas?useUnicode=true&characterEncoding=utf-8&user=root&password=");
        }catch(ClassNotFoundException e){
            System.err.printf("Error: " + e);
        }catch(SQLException e){
            System.err.printf("Error: " + e);
        }
    }
    
    public void cerrar() throws Exception{
        try{
            if(cn != null){
                if(cn.isClosed() == false){
                    cn.close();
                }
            }
        }catch(Exception e){
            throw e;
        }
    }
}
