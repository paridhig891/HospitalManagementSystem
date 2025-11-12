
package myservlets;

import java.io.IOException;
import java.sql.*;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CancelAppointment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String appointmentId = request.getParameter("cancel");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital_management", "root", "6755"
            );

            String query = "UPDATE appointments SET status = 'Cancelled' WHERE appointment_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, appointmentId);

            ps.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/myjsp/appointment.jsp");
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
        
    }
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
