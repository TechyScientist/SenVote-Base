package com.johnnyconsole.senvote.servlet.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {

    private static final String URL = "jdbc:mysql://johnnyconsole.com:3306/johnnyco_enterprise?serverTimezone=America/Toronto",
            USER = "johnnyco_enterprise",
            PASSWORD = "Marbles1999";

    public static Connection connect() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch(ClassNotFoundException e) {
            throw new SQLException(e);
        }
    }

}
