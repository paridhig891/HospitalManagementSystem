package myservlets;

import java.io.IOException;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GenerateBillServlet extends HttpServlet {
   public
         void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String patientId = request.getParameter("patient");
        String billDate = request.getParameter("billDate");
        String payMode = request.getParameter("payMode");
        String[] serviceNames = request.getParameterValues("service[]");
        String[] descriptions = request.getParameterValues("description[]");
        String[] quantities = request.getParameterValues("quantity[]");
        String[] unitPrices = request.getParameterValues("unitPrice[]");
        String[] amounts = request.getParameterValues("amount[]");

        Connection con = null;
        PreparedStatement psBill = null;
        PreparedStatement psItem = null;
        ResultSet rs = null;

        try {
            // ✅ Connect to MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");

            // ✅ Calculate total amount
            double totalAmount = 0.0;
            for (String amt : amounts) {
                if (amt != null && !amt.isEmpty()) {
                    totalAmount += Double.parseDouble(amt);
                }
            }

            // ✅ Insert into bill table (no subtotal)
            String insertBill = "INSERT INTO bill (patient_id, bill_date, total_amount, pay_mode) VALUES (?, ?, ?, ?)";
            psBill = con.prepareStatement(insertBill, Statement.RETURN_GENERATED_KEYS);

            psBill.setString(1, patientId);
            psBill.setString(2, billDate);
            psBill.setDouble(3, totalAmount);
            psBill.setString(4, payMode);

            psBill.executeUpdate();

            // ✅ Get generated bill_id
            rs = psBill.getGeneratedKeys();
            int billId = 0;
            if (rs.next()) {
                billId = rs.getInt(1);
            }

            // ✅ Insert items into bill_items table
            String insertItem = "INSERT INTO bill_items (bill_id, service_name, description, quantity, unit_price, amount) VALUES (?, ?, ?, ?, ?, ?)";
            psItem = con.prepareStatement(insertItem);

            for (int i = 0; i < serviceNames.length; i++) {
                psItem.setInt(1, billId);
                psItem.setString(2, serviceNames[i]);
                psItem.setString(3, descriptions[i]);
                psItem.setInt(4, Integer.parseInt(quantities[i]));
                psItem.setDouble(5, Double.parseDouble(unitPrices[i]));
                psItem.setDouble(6, Double.parseDouble(amounts[i]));
                psItem.addBatch();
            }
            psItem.executeBatch();

            // ✅ Redirect after success
            response.sendRedirect(request.getContextPath()+"/myjsp/bill.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psBill != null) psBill.close(); } catch (Exception e) {}
            try { if (psItem != null) psItem.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
