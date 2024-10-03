package br.com.dio.utils;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ConnectionUtil {

    public final static String url ="jdbc:mysql://localhost:3306/jdbc_test";
    public final static String user ="root";
    public final static String pwd="$NEVER_BLANK";

    public static Connection getConnection() throws SQLException {

        try {
            return DriverManager.getConnection(url,user,pwd);
        }catch(SQLException e) {
            throw new SQLException(" Error:",e);
        }
    }
}
