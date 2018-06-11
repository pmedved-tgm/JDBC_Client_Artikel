//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package pmedved;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class JDBCClient {
    Connection con;
    Hashtable<Artikel, Integer> versions = new Hashtable();

    JDBCClient() {
        try {
            this.con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/restaurant4a2017?useSSL=false", "insy4", "blabla");
        } catch (SQLException var2) {
            System.out.println("Fehler beim Verbinden zur Datenbank!");
            var2.printStackTrace();
            System.exit(0);
        }

    }

    List<Artikel> getAllArticles(String input) {
        ArrayList l = new ArrayList();

        try {
            Statement stmt = this.con.createStatement();
            String query = "create or replace view alkoholfreie as (select * from artikel where katbez = 'Alkoholfreie Getränke')";
            stmt.executeUpdate(query);
            if (input == null) {
                query = "Select * from alkoholfreie";
            } else {
                query = "Select * from alkoholfreie where artbez like '%" + input + "%'";
            }

            ResultSet rs = stmt.executeQuery(query);
            System.out.println(query);

            while(rs.next()) {
                Artikel a = new Artikel(rs.getString("artbez"), rs.getString("katbez"), rs.getFloat("bruttpr"), rs.getBoolean("isvegetarisch"), rs.getInt("version"));
                l.add(a);
            }
        } catch (SQLException var7) {
            var7.printStackTrace();
            System.exit(0);
        }

        return l;
    }

    void addArticle(Artikel a) {
        try {
            Statement stmt = this.con.createStatement();
            String query = "insert into artikel (artbez, katbez, bruttpr, isvegetarisch, version) values ('" + a.getArtbez() + "','" + a.getKatbez() + "'," + a.getBruttpr() + "," + a.getIsvegetarisch() + "," + a.getVersion() + ")";
            stmt.executeUpdate(query);
        } catch (SQLException var4) {
            var4.printStackTrace();
            System.exit(0);
        }

    }

    void saveArticle(Artikel a) {
        try {
            this.con.setTransactionIsolation(4);
            this.con.setAutoCommit(false);
            Statement stmt = this.con.createStatement();
            String query = "update artikel set artbez='" + a.getArtbez() + "', katbez='" + a.getKatbez() + "',bruttpr=" + a.getBruttpr() + ",isvegetarisch=" + a.getIsvegetarisch() + ",Version=" + a.getVersion()+ " where artbez=" + a.getArtbez();
            stmt.executeUpdate(query);
            this.con.commit();
            this.con.setAutoCommit(true);
        } catch (SQLException var4) {
            var4.printStackTrace();
            System.exit(0);
        }

    }
}
