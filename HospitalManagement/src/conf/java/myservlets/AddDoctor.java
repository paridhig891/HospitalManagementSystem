
package myservlets;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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

public class AddDoctor extends HttpServlet {
    public static int count;

   public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       System.out.println("AddDoctor servlet triggered!");

        try {
            System.out.print("Servlet triggered");
            Connection con = null;
            PreparedStatement pmt = null;
            
            String n = request.getParameter("name");
            String s = request.getParameter("specialization");  
            String p = request.getParameter("phone");
            String e = request.getParameter("email");
            String d = request.getParameter("department");
            String ex = request.getParameter("experience");
            String sa = request.getParameter("salary");
            String qa = request.getParameter("qualification");
            String a = request.getParameter("address");
            String i = "D" + count + n.substring(3,5);  count++;
             
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management","root","6755");
            
            String q = "INSERT INTO doctor(docId, docName, docExperience, docContact, depId, docSalary, specialization, docGender, qualification, address, email) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            pmt=con.prepareStatement(q);
            pmt.setString(1, i);
            pmt.setString(2, n);
            pmt.setString(3, ex);
            pmt.setString(4, p);
            pmt.setString(5, d);
            pmt.setString(6, sa);
            pmt.setString(7, s);
            pmt.setString(8, "F");
            pmt.setString(9, qa);
            pmt.setString(10, a);
            pmt.setString(11, e);
            pmt.executeUpdate();
            
         response.sendRedirect(request.getContextPath() + "/myjsp/doctor.jsp?success=Doctor+added+successfully");

            
            pmt.close();
            con.close();
            
        } catch (ClassNotFoundException ex1) {
            Logger.getLogger(AddDoctor.class.getName()).log(Level.SEVERE, null, ex1);
        } catch (SQLException ex) {
            Logger.getLogger(AddDoctor.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace();
response.setContentType("text/html");
PrintWriter out = response.getWriter();
out.println("<h3 style='color:red;'>Database Error: " + ex.getMessage() + "</h3>");
        }
        

   }}
