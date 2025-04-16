<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.CartItem" %>
<%@page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .container {
                width: 90%;
                max-width: 1200px;
                margin: 30px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
            }

            .empty-cart {
                text-align: center;
                padding: 50px 0;
            }

            .empty-cart p {
                font-size: 18px;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f8f8f8;
                font-weight: bold;
            }

            .product-info {
                display: flex;
                align-items: center;
            }
            
            .product-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 4px;
                margin-right: 15px;
            }

            .product-name {
                font-weight: bold;
            }

            .quantity-form {
                display: flex;
                align-items: center;
            }

            .quantity-input {
                width: 60px;
                padding: 5px;
                margin-right: 10px;
                text-align: center;
            }

            .update-btn {
                padding: 5px 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 3px;
            }

            .remove-btn {
                padding: 5px 10px;
                background-color: #f44336;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 3px;
            }

            .cart-summary {
                background-color: #f8f8f8;
                padding: 20px;
                border-radius: 5px;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .total {
                font-size: 18px;
                font-weight: bold;
                margin-top: 10px;
            }

            .cart-actions {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .continue-shopping {
                padding: 10px 15px;
                background-color: #2196F3;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
            }

            .checkout-btn {
                padding: 10px 15px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
            }

            .continue-shopping:hover,
            .checkout-btn:hover,
            .update-btn:hover,
            .remove-btn:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Your Shopping Cart</h1>
            
            <% 
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                Integer cartSize = (Integer) session.getAttribute("cartSize");
                
                if (cart == null || cart.isEmpty()) {
            %>
                <div class="empty-cart">
                    <p>Your cart is empty</p>
                    <a href="<%= request.getContextPath() %>/ProductServlet" class="continue-shopping">Continue Shopping</a>
                </div>
            <% 
                } else {
                    DecimalFormat df = new DecimalFormat("#,##0.00");
            %>
                <div class="cart-items">
                    <table>
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                double total = 0;
                                for(CartItem item : cart) {
                                    total += item.getSubtotal();
                            %>
                                <tr>
                                    <td>
                                        <div class="product-info">
                                            <img class="product-image" src="<%= request.getContextPath() %>/ProductImages/<%= item.getProduct().getImageUrl() %>" alt="<%= item.getProduct().getName() %>">
                                            <div class="product-name"><%= item.getProduct().getName() %></div>
                                        </div>
                                    </td>
                                    <td>RM <%= df.format(item.getProduct().getPrice()) %></td>
                                    <td>
                                        <form action="<%= request.getContextPath() %>/UpdateCartServlet" method="POST" class="quantity-form">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                            <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="10" class="quantity-input">
                                            <button type="submit" class="update-btn">Update</button>
                                        </form>
                                    </td>
                                    <td>RM <%= df.format(item.getSubtotal()) %></td>
                                    <td>
                                        <form action="<%= request.getContextPath() %>/RemoveFromCartServlet" method="POST">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                            <button type="submit" class="remove-btn">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <div class="cart-summary">
                    <div class="summary-row">
                        <span>Total Items:</span>
                        <span><%= cartSize %></span>
                    </div>
                    <div class="summary-row total">
                        <span>Total:</span>
                        <span>RM <%= df.format(total) %></span>
                    </div>
                    
                    <div class="cart-actions">
                        <a href="<%= request.getContextPath() %>/ProductServlet" class="continue-shopping">Continue Shopping</a>
                        <a href="<%= request.getContextPath() %>/CheckoutServlet" class="checkout-btn">Proceed to Checkout</a>
                    </div>
                </div>
            <% } %>
        </div>
    </body>
</html>