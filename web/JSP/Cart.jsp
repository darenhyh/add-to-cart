<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.CartItem" %>
<%@page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Bag</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            padding: 40px;
            color: #000;
            background-color: #fff;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
        }

        .bag-section {
            flex: 1;
            min-width: 300px;
        }

        .summary-section {
            width: 350px;
        }

        h1 {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        h2 {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .total-info {
            margin-bottom: 15px;
            font-size: 14px;
        }

        .reservation-note {
            margin-bottom: 30px;
            font-size: 14px;
        }

        .cart-item {
            display: flex;
            border: 1px solid #e0e0e0;
            margin-bottom: 20px;
            position: relative;
        }

        .item-image {
            width: 200px;
            height: 200px;
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .item-image img {
            max-width: 80%;
            max-height: 80%;
            object-fit: contain;
        }

        .item-details {
            padding: 20px;
            flex: 1;
            position: relative;
        }

        .item-name {
            font-weight: bold;
            margin-bottom: 5px;
        }

        .item-category {
            margin-bottom: 20px;
            font-size: 14px;
            color: #666;
        }

        .item-stock {
            font-size: 14px;
            margin-bottom: 5px;
            font-weight: bold;
            color: #e44d26;
        }

        .item-price {
            position: absolute;
            right: 20px;
            top: 20px;
            font-weight: bold;
        }

        .quantity-selector {
            margin-top: 20px;
            width: 80px;
            position: relative;
        }

        .quantity-selector select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            appearance: none;
            background-color: white;
        }

        .quantity-selector::after {
            content: "▼";
            font-size: 12px;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
        }

        .item-actions {
            position: absolute;
            right: 20px;
            bottom: 20px;
            display: flex;
            gap: 15px;
        }

        .action-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
        }

        .remove-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .tax-info {
            font-size: 12px;
            color: #666;
            margin-bottom: 25px;
        }

        .promo-section {
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }

        .promo-btn {
            background-color: white;
            border: 1px solid #000;
            padding: 5px 10px;
            font-size: 12px;
            cursor: pointer;
            margin-right: 10px;
        }

        .promo-link {
            text-decoration: none;
            color: #000;
            font-size: 14px;
            font-weight: bold;
        }

        .checkout-btn {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            padding: 15px 20px;
            background-color: #000;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 25px;
            text-decoration: none;
        }

        .continue-shopping {
            display: inline-block;
            padding: 15px 20px;
            background-color: #fff;
            color: #000;
            border: 1px solid #000;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 25px;
            text-decoration: none;
            width: 100%;
            text-align: center;
        }

        .payment-section h3 {
            font-size: 14px;
            margin-bottom: 15px;
        }

        .payment-methods {
            display: flex;
            gap: 10px;
        }

        .payment-methods img {
            height: 30px;
        }

        .divider {
            border-top: 1px solid #e0e0e0;
            margin: 20px 0;
        }
        
        .empty-cart {
            text-align: center;
            padding: 50px 0;
        }

        .empty-cart p {
            font-size: 18px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            Integer cartSize = (Integer) session.getAttribute("cartSize");
            
            if (cart == null || cart.isEmpty()) {
        %>
            <div class="empty-cart" style="width: 100%;">
                <p>Your bag is empty</p>
                <a href="<%= request.getContextPath() %>/ProductServlet" class="continue-shopping">CONTINUE SHOPPING</a>
            </div>
        <% 
            } else {
                DecimalFormat df = new DecimalFormat("#,##0.00");
                double totalAmount = 0;
                for(CartItem item : cart) {
                    totalAmount += item.getSubtotal();
                }
        %>
            <div class="bag-section">
                <h1>YOUR BAG</h1>
                <div class="total-info">TOTAL [<%= cartSize %> items] <b>RM<%= df.format(totalAmount) %></b></div>
                <div class="reservation-note">Items in your bag are not reserved — check out now to make them yours.</div>

                <% 
                    for(CartItem item : cart) {
                %>
                    <div class="cart-item">
                        <div class="item-image">
                            <img src="<%= request.getContextPath() %>/ProductImages/<%= item.getProduct().getImageUrl() %>" alt="<%= item.getProduct().getName() %>">
                        </div>
                        <div class="item-details">
                            <div class="item-name"><%= item.getProduct().getName() %></div>
                            <div class="item-category"><%= item.getProduct().getCategory() != null ? item.getProduct().getCategory().toUpperCase() : "" %></div>
                            <div class="item-price">RM<%= df.format(item.getProduct().getPrice()) %></div>

                            <form action="<%= request.getContextPath() %>/UpdateCartServlet" method="POST" class="quantity-selector">
                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                <select name="quantity" onchange="this.form.submit()">
                                    <% for (int i = 1; i <= 10; i++) { %>
                                        <option value="<%= i %>" <%= (item.getQuantity() == i) ? "selected" : "" %>><%= i %></option>
                                    <% } %>
                                </select>
                            </form>

                            <div class="item-actions">
                                <form action="<%= request.getContextPath() %>/RemoveFromCartServlet" method="POST">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                    <button type="submit" class="remove-btn">✕</button>
                                </form>
                                <button class="action-btn">♡</button>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>

            <div class="summary-section">
                <h2>ORDER SUMMARY</h2>
                <div class="summary-item">
                    <span><%= cartSize %> items</span>
                    <span>RM<%= df.format(totalAmount) %></span>
                </div>
                <div class="summary-item">
                    <span>Delivery</span>
                    <span>Free</span>
                </div>
                <div class="divider"></div>
                <div class="summary-total">
                    <span>Total</span>
                    <span>RM<%= df.format(totalAmount) %></span>
                </div>
                <div class="tax-info">[Inclusive of tax RM0.00]</div>

                <div class="promo-section">
                    <button class="promo-btn">+</button>
                    <a href="#" class="promo-link">USE A PROMO CODE</a>
                </div>

                <a href="<%= request.getContextPath() %>/CheckoutServlet" class="checkout-btn">
                    <span>CHECKOUT</span>
                    <span>→</span>
                </a>
                
                <a href="<%= request.getContextPath() %>/ProductServlet" class="continue-shopping">CONTINUE SHOPPING</a>
            </div>
        <% } %>
    </div>
</body>
</html>