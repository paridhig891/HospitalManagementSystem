package myservlets;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AddPatient extends HttpServlet {

public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    try {
        Connection con = null;
        PreparedStatement pmt = null;
        
        String n = request.getParameter("name");
        String age = request.getParameter("age");
        String g = request.getParameter("gender");
        String p =  request.getParameter("phone");
       
        String b = request.getParameter("blood_group");
        String a = request.getParameter("address");
        String pt = request.getParameter("patient_type");

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
        
        
        String q = "INSERT INTO patients (full_name, gender, contact, blood_group, patient_type, age, address, status) VALUES (?, ?, ?, ?, ?,?,?,'active')";
        
        pmt = con.prepareStatement(q);
        
        pmt.setString(1, n);
        pmt.setString(2, g);
        pmt.setString(3, p);
        pmt.setString(4, b);
        pmt.setString(5, pt);
        pmt.setString(6, age);
        pmt.setString(7, a);
        
        pmt.executeUpdate();
        
        response.sendRedirect(request.getContextPath()+"/myjsp/patient.jsp");
       
        
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(AddPatient.class.getName()).log(Level.SEVERE, null, ex);
    } catch (SQLException ex) {
        ex.printStackTrace();
response.setContentType("text/html");
PrintWriter out = response.getWriter();
out.println("<h3 style='color:red;'>Database Error: " + ex.getMessage() + "</h3>");
        Logger.getLogger(AddPatient.class.getName()).log(Level.SEVERE, null, ex);
    }
    
    
    
    
    }

}