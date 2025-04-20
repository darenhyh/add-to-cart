<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.BuyerDetail" %>
<%@ page import="model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background-color: #f8f8f8;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .header h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #666;
        }
        
        .order-info {
            background-color: #f9f9f9;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .order-info h2 {
            margin-bottom: 15px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .shipping-info {
            margin-bottom: 30px;
        }
        
        .shipping-info h2 {
            margin-bottom: 15px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }
        
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        
        .items-table th {
            text-align: left;
            background-color: #f5f5f5;
            padding: 10px;
        }
        
        .items-table td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .items-table .total-row td {
            font-weight: bold;
            border-top: 2px solid #ddd;
            border-bottom: none;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #000;
            color: white;
            text-decoration: none;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        // Get data from session
        BuyerDetail buyer = (BuyerDetail) session.getAttribute("buyer");
        Payment payment = (Payment) session.getAttribute("payment");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        Double orderTotal = (Double) session.getAttribute("orderTotal");
        
        // Format numbers
        DecimalFormat df = new DecimalFormat("#,##0.00");
        
        // Generate a random transaction ID if not set
        String transactionId = (payment != null && payment.getTransactionId() != null) 
                                ? payment.getTransactionId() 
                                : "TRX" + System.currentTimeMillis();
    %>
    
    <div class="container">
        <div class="header">
            <h1>Thank You for Your Order!</h1>
            <p>Your order has been received and is being processed.</p>
        </div>
        
        <div class="order-info">
            <h2>Order Information</h2>
            <div class="info-row">
                <span>Order Date:</span>
                <span><%= new java.util.Date() %></span>
            </div>
            <div class="info-row">
                <span>Transaction ID:</span>
                <span><%= transactionId %></span>
            </div>
            <div class="info-row">
                <span>Payment Method:</span>
                <span><%= payment != null ? payment.getPaymentMethod().getMethodName().toUpperCase() : "N/A" %></span>
            </div>
        </div>
        
        <div class="shipping-info">
            <h2>Shipping Information</h2>
            <% if (buyer != null) { %>
                <p><strong><%= buyer.getName() %></strong></p>
                <p><%= session.getAttribute("shippingAddress") %></p>
                <p><%= session.getAttribute("shippingCity") %>, <%= session.getAttribute("shippingState") %> <%= session.getAttribute("shippingPostcode") %></p>
                <p>Email: <%= buyer.getEmail() %></p>
                <p>Phone: <%= buyer.getMobile() %></p>
            <% } else { %>
                <p>Shipping information not available</p>
            <% } %>
        </div>
        
        <h2>Order Summary</h2>
        <table class="items-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% if (cart != null && !cart.isEmpty()) {
                    for (CartItem item : cart) { %>
                        <tr>
                            <td><%= item.getProduct().getName() %></td>
                            <td><%= item.getQuantity() %></td>
                            <td>RM<%= df.format(item.getProduct().getPrice()) %></td>
                            <td>RM<%= df.format(item.getSubtotal()) %></td>
                        </tr>
                    <% } %>
                    <tr class="total-row">
                        <td colspan="3">Total</td>
                        <td>RM<%= df.format(orderTotal) %></td>
                    </tr>
                <% } else { %>
                    <tr>
                        <td colspan="4">No items in your order</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        
        <a href="<%= request.getContextPath() %>/ProductServlet" class="back-btn">Continue Shopping</a>
        
        <%
            // Clear the cart after successful order
            session.removeAttribute("cart");
            session.setAttribute("cartSize", 0);
        %>
    </div>
</body>
</html>