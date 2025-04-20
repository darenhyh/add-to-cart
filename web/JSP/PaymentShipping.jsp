<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.CartItem" %>
<%@page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Payment & Shipping</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background-color: #f8f8f8;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .column {
            flex: 1;
            min-width: 300px;
        }
        
        .title {
            font-size: 1.5rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .input-box {
            margin-bottom: 15px;
        }
        
        .input-box label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .input-box input, .input-box select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .flex {
            display: flex;
            gap: 10px;
        }
        
        .flex .input-box {
            flex: 1;
        }
        
        .icon-container {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
        button[type="button"] {
            background: none;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            width: 80px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        button[type="button"] img {
            max-width: 100%;
            max-height: 30px;
        }
        
        button[type="button"].selected {
            border: 2px solid #000;
            background-color: #f0f0f0;
        }
        
        .submitBtn {
            background-color: #000;
            color: white;
            border: none;
            padding: 15px 20px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
            font-size: 1rem;
        }
        
        .order-summary {
            background-color: #f9f9f9;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .order-summary h3 {
            margin-bottom: 15px;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .order-total {
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            margin-top: 15px;
            font-size: 1.1rem;
        }
        
        .error-message {
            color: red;
            font-weight: bold;
            margin: 10px 0;
            padding: 10px;
            background-color: #ffeeee;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
            // Get cart items and total from session
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            Double orderTotal = (Double) session.getAttribute("orderTotal");
            DecimalFormat df = new DecimalFormat("#,##0.00"); 
        %>
        
        <div class="order-summary">
            <h3>Order Summary</h3>
            <% if (cart != null && !cart.isEmpty()) { 
                for (CartItem item : cart) { %>
                <div class="order-item">
                    <span><%= item.getQuantity() %> × <%= item.getProduct().getName() %></span>
                    <span>RM<%= df.format(item.getSubtotal()) %></span>
                </div>
            <% } %>
            <div class="order-total">
                <span>Total:</span>
                <span>RM<%= df.format(orderTotal) %></span>
            </div>
            <% } else { %>
            <p>No items in your cart.</p>
            <% } %>
        </div>
        
        <form action="<%= request.getContextPath() %>/PaymentServlet" method="post">
            <div class="row">
                <div class="column">
                    <h3 class="title">Shipping Address</h3>
                    <div class="input-box">
                        <label>Full Name</label>
                        <input type="text" name="shippingName" id="shippingName" placeholder="Enter full name" required>
                    </div>
                    <div class="input-box">
                        <label>Email</label>
                        <input type="text" name="shippingEmail" id="shippingEmail" placeholder="Enter email" required>
                    </div>
                    <div class="input-box">
                        <label>Mobile Number</label>
                        <input type="tel" name="shippingMobile" id="shippingMobile" pattern="01[0-9]-[0-9]{7,10}" placeholder="Enter mobile number (01X-XXXXXXX)" required>
                    </div>
                    <div class="input-box">
                        <label>Address</label>
                        <input type="text" name="shippingAddress" id="shippingAddress" placeholder="Enter address" required>
                    </div>
                    <div class="input-box">
                        <label>City</label>
                        <input type="text" name="shippingCity" id="shippingCity" placeholder="Enter city" required>
                    </div>

                    <div class="flex">
                        <div class="input-box">
                            <label>State</label>
                            <select name="shippingState" id="shippingState" required>
                                <option value="">Choose state</option>
                                <option value="johor">Johor</option>
                                <option value="kedah">Kedah</option>
                                <option value="kelantan">Kelantan</option>
                                <option value="kualaLumpur">Kuala Lumpur</option>
                                <option value="labuan">Labuan</option>
                                <option value="melaka">Melaka</option>
                                <option value="negeriSembilan">Negeri Sembilan</option>
                                <option value="pahang">Pahang</option>
                                <option value="penang">Penang</option>
                                <option value="perak">Perak</option>
                                <option value="perlis">Perlis</option>
                                <option value="putrajaya">Putrajaya</option>
                                <option value="sabah">Sabah</option>
                                <option value="sarawak">Sarawak</option>
                                <option value="selangor">Selangor</option>
                                <option value="terengganu">Terengganu</option>
                            </select>
                        </div>
                        <div class="input-box">
                            <label>Postcode</label>
                            <input type="number" name="shippingPostcode" id="shippingPostcode" maxlength="5" placeholder="Enter postcode" required> 
                        </div>
                    </div>
                </div>
                
                <div class="column">
                    <h3 class="title">Payment</h3>
                    <div class="input-box">
                        <label>Payment Method</label>
                        <input type="hidden" name="payment_method" id="payment_method" value="">
                        <div class="icon-container">
                            <button type="button" id="cashBtn" class="cashBtn" data-method="cash"><img src="<%= request.getContextPath() %>/ICON/cash.svg" alt="Cash"></button>
                            <button type="button" id="tngBtn" class="tngBtn" data-method="tng"><img src="<%= request.getContextPath() %>/ICON/tng.svg" alt="Touch n Go"></button>
                            <button type="button" id="visaBtn" class="visaBtn" data-method="visa"><img src="<%= request.getContextPath() %>/ICON/visa.svg" alt="Visa"></button>
                            <button type="button" id="mcBtn" class="mcBtn" data-method="master"><img src="<%= request.getContextPath() %>/ICON/mastercard.svg" alt="MasterCard"></button>
                        </div>
                    </div>
                    <div class="input-box">
                        <label>Name On Card</label>
                        <input type="text" name="cardOwner" id="cardOwner" placeholder="Enter card owner" disabled>
                    </div>
                    <div class="input-box">
                        <label>Credit Card Number</label>
                        <input type="text" name="cardNumber" id="cardNumber" maxlength="16" pattern="\d{15,16}" placeholder="Enter card number" disabled>
                    </div>
                    <div class="input-box">
                        <label>Exp Month</label>
                        <select name="expMonth" id="expMonth" disabled>
                            <option value="">Choose month</option>
                            <option value="jan">January</option>
                            <option value="feb">February</option>
                            <option value="mar">March</option>
                            <option value="apr">April</option>
                            <option value="may">May</option>
                            <option value="jun">June</option>
                            <option value="jul">July</option>
                            <option value="aug">August</option>
                            <option value="sept">September</option>
                            <option value="oct">October</option>
                            <option value="nov">November</option>
                            <option value="dec">December</option>
                        </select>
                    </div>

                    <div class="flex">
                        <div class="input-box">
                            <label>Exp Year </label>
                            <input type="number" name="expYear" id="expYear" maxlength="4" min="2025" max="2100" placeholder="Enter exp year" disabled>
                        </div>
                        <div class="input-box">
                            <label>CVV</label>
                            <input type="number" name="cvv" id="cvv" maxlength="3" pattern="\d{3}" placeholder="Enter CVV" disabled> 
                        </div>
                    </div>
                </div>
            </div>            
            <button type="submit" class="submitBtn">Complete Order</button>
        </form>
        
        <!-- Display Error for Form Validation -->
        <% String error = (String) request.getAttribute("errorMsg"); %>
        <% if (error != null) { %>
            <div class="error-message">
                <%= error %>
            </div>
        <% } %>
    </div>
    
    <!-- Payment Method Selection & Card Input -->
    <script>
        document.addEventListener('DOMContentLoaded', function(){
            const paymentMethodInput = document.getElementById("payment_method");
            const cardInputs = [
                document.getElementById("cardOwner"),
                document.getElementById("cardNumber"),
                document.getElementById("expYear"),
                document.getElementById("cvv"),
                document.getElementById("expMonth")
            ];
            
            const paymentButtons = {
                cash: document.getElementById("cashBtn"),
                tng: document.getElementById("tngBtn"),
                visa: document.getElementById("visaBtn"),
                master: document.getElementById("mcBtn")
            };

            // Highlight selected button and remove highlight from others
            function highlightSelected(selectedBtn) {
                Object.values(paymentButtons).forEach(btn => btn.classList.remove("selected"));
                selectedBtn.classList.add("selected");
            }
            
            // Enable/disable card inputs & manage required attribute
            function setPaymentMethod(method) {
                paymentMethodInput.value = method;
                const enable = method === "visa" || method === "master";
                
                // Loop 
                cardInputs.forEach(input => {
                    input.disabled = !enable; // Enable/disable the field
                    input.style.backgroundColor = enable ? "white" : "#f0f0f0"; // Set background color
                    if (!enable) input.value = ""; // Clear if disable
                    input.required = enable; // Toggle required attribute
                });
            }

            // Add click event to each payment method button
            Object.entries(paymentButtons).forEach(([method, btn]) => {
                btn.addEventListener("click", () => {
                    setPaymentMethod(method);      // Enable/disable fields based on method
                    highlightSelected(btn);        // Visually indicate selected method
                });
            });
        });
    </script>
</body>
</html>