
package myservlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AddInpatient extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try {
            Connection con = null;
            PreparedStatement pmt = null;
            
            String n = request.getParameter("name");
            System.out.print("Name = "+ n);
            String age = request.getParameter("age");
            System.out.print("Name = "+ age);
            String g = request.getParameter("gender");
            System.out.print("Name = "+ g);
            String p =  request.getParameter("phone");
            System.out.print("Name = "+ p);
            String b = request.getParameter("blood_group");
            System.out.print("Name = "+ b);
            String a = request.getParameter("address");
            System.out.print("Name = "+ a);
            String pt = request.getParameter("patient_type");
            System.out.print("Name = "+ pt);
            String dep = request.getParameter("department");
            System.out.print("Name = "+ dep);
            String doc  = request.getParameter("docId");
            System.out.print("Name = "+ doc);
            String room = request.getParameter("room");
            System.out.print("Name = "+ room);
            String ad = request.getParameter("admission_date");
            String dd = request.getParameter("discharge_date");
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
            
            
            String q = "INSERT INTO patients (full_name, gender, contact, blood_group, patient_type, age, address, status) VALUES (?, ?, ?, ?, ?,?,?,'admitted')";
            
            pmt = con.prepareStatement(q, Statement.RETURN_GENERATED_KEYS);
            
            pmt.setString(1, n);
            pmt.setString(2, g);
            pmt.setString(3, p);
            pmt.setString(4, b);
            pmt.setString(5, pt);
            pmt.setString(6, age);
            pmt.setString(7, a);
            pmt.executeUpdate();
            ResultSet rs =  pmt.getGeneratedKeys();
            int generatedKey=0;
            if (rs.next()) {
              generatedKey = rs.getInt(1);
               System.out.println("Generated Key: " + generatedKey);
    }
            PreparedStatement ps = null;
            
            String qr = "INSERT INTO inpatients (patient_id, depId, docId, room_no, admission_date, discharge_date) VALUES (?,?,?,?,?,?)";
            
            ps = con.prepareStatement(qr);
            
            ps.setInt(1, generatedKey);
            ps.setString(2, dep);
            ps.setString(3, doc);
            ps.setString(4, room);
            ps.setString(5, ad);
           if (dd == null || dd.isEmpty()) {
    ps.setNull(6, java.sql.Types.DATE);
} else {
    ps.setString(6, dd);
}

            
            ps.executeUpdate();
            
            response.sendRedirect(request.getContextPath()+"/myjsp/patient.jsp");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddInpatient.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddInpatient.class.getName()).log(Level.SEVERE, null, ex);
            response.setContentType("text/html");
PrintWriter out = response.getWriter();
out.println("<h3 style='color:red;'>Database Error: " + ex.getMessage() + "</h3>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
