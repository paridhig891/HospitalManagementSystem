
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

public class DeletePatient extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String patientId = request.getParameter("patient_id");

        if (patientId == null || patientId.isEmpty()) {
            out.println("<h3 style='color:red;'>Error: Patient ID missing!</h3>");
            return;
        }

        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");

            // Step 1: Delete from inpatients table first
            String q1 = "DELETE FROM inpatients WHERE patient_id = ?";
            ps1 = con.prepareStatement(q1);
            ps1.setString(1, patientId);
            ps1.executeUpdate();

            // Step 2: Delete from patients table
            String q2 = "DELETE FROM patients WHERE patient_id = ?";
            ps2 = con.prepareStatement(q2);
            ps2.setString(1, patientId);
            ps2.executeUpdate();

            int rows = ps2.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("myjsp/patient.jsp?msg=deleted");
            } else {
                response.sendRedirect("myjsp/patient.jsp?msg=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myjsp/doctor.jsp?msg=error");
        } finally {
            try { if (ps1 != null) ps1.close(); } catch (Exception ex) {}
            try { if (con != null) con.close(); } catch (Exception ex) {}
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
