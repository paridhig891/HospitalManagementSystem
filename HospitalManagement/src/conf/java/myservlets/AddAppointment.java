
package myservlets;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AddAppointment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = null;
            PreparedStatement pmt = null;
            
            String pi = request.getParameter("patient");
            String di = request.getParameter("doctor");
            String at = request.getParameter("appointmentType");
            String ad = request.getParameter("appointmentDate");
            String apt = request.getParameter("appointmentTime");
            String r = request.getParameter("reason");
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
            
            String q = "INSERT INTO appointments(patient_id, doctor_id, appointment_type, appointment_date, appointment_time, reason) VALUES(?,?,?,?,?,?)";
            
            pmt=con.prepareStatement(q);
            
            pmt.setString(1,pi);
            pmt.setString(2, di);
            pmt.setString(3, at);
            pmt.setString(4, ad);
            pmt.setString(5, apt);
            pmt.setString(6, r);
            
            pmt.executeUpdate();
            
            response.sendRedirect(request.getContextPath() + "/myjsp/appointment.jsp");
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddAppointment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddAppointment.class.getName()).log(Level.SEVERE, null, ex);
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
