import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.CartItem;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        // Check if cart exists and is not empty
        if (cart == null || cart.isEmpty()) {
            // Redirect back to cart with a message
            response.sendRedirect(request.getContextPath() + "/CartServlet");
            return;
        }
        
        // Calculate total order amount and store in session
        double totalAmount = 0.0;
        for (CartItem item : cart) {
            totalAmount += item.getSubtotal();
        }
        session.setAttribute("orderTotal", totalAmount);
        
        // Forward to payment shipping page
        request.getRequestDispatcher("/JSP/PaymentShipping.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}