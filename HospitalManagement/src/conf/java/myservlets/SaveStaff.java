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

public class SaveStaff extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try {
            Connection con =  null;
            PreparedStatement pmt= null;
            
            String n = request.getParameter("name");
            String r = request.getParameter("role");
            String p = request.getParameter("phone");
            String g = request.getParameter("gender");
            String age = request.getParameter("age");
            String de =  request.getParameter("department");
            String da = request.getParameter("joiningDate");
            String sh = request.getParameter("shift");
            String sa = request.getParameter("salary");
            String ad = request.getParameter("address");
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management","root","6755");
            
            String q = "INSERT INTO staff (name, role, phone, gender, age, department, joining_date, shift, salary, address) VALUES(?,?,?,?,?,?,?,?,?,?)";
            
            pmt = con.prepareStatement(q);
            pmt.setString(1, n);
            pmt.setString(2, r);
            pmt.setString(3, p);
            pmt.setString(4, g);
            pmt.setString(5, age);
            pmt.setString(6, de);
            pmt.setString(7, da);
            pmt.setString(8, sh);
            pmt.setString(9, sa);
            pmt.setString(10, ad);
            
            pmt.executeUpdate();
            
            response.sendRedirect(request.getContextPath()+"/myjsp/staff.jsp");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SaveStaff.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SaveStaff.class.getName()).log(Level.SEVERE, null, ex);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.print("<h3 style='color:red;'>Database Error: " + ex.getMessage() + "</h3>");
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
