<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.CartItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/CartCSS.css">
    </head>
    <body>
        <div class="container">
            <h1>Your Shopping Cart</h1>
            
            <c:choose>
                <c:when test="${empty cart || cart.size() == 0}">
                    <div class="empty-cart">
                        <p>Your cart is empty</p>
                        <a href="${pageContext.request.contextPath}/ProductServlet" class="continue-shopping">Continue Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
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
                                <c:forEach var="item" items="${cart}">
                                    <tr>
                                        <td>
                                            <div class="product-info">
                                                <div class="product-name">${item.product.name}</div>
                                            </div>
                                        </td>
                                        <td>RM <fmt:formatNumber value="${item.product.price}" pattern="#,##0.00"/></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/UpdateCartServlet" method="POST" class="quantity-form">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="10" class="quantity-input">
                                                <button type="submit" class="update-btn">Update</button>
                                            </form>
                                        </td>
                                        <td>RM <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/RemoveFromCartServlet" method="POST">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <button type="submit" class="remove-btn">Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="cart-summary">
                        <c:set var="total" value="0" />
                        <c:forEach var="item" items="${cart}">
                            <c:set var="total" value="${total + item.subtotal}" />
                        </c:forEach>
                        
                        <div class="summary-row">
                            <span>Total Items:</span>
                            <span>${cartSize}</span>
                        </div>
                        <div class="summary-row total">
                            <span>Total:</span>
                            <span>RM <fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                        </div>
                        
                        <div class="cart-actions">
                            <a href="${pageContext.request.contextPath}/ProductServlet" class="continue-shopping">Continue Shopping</a>
                            <a href="${pageContext.request.contextPath}/CheckoutServlet" class="checkout-btn">Proceed to Checkout</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>