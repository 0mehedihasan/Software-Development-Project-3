<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.mehedi.service.impl.*, com.mehedi.service.*, com.mehedi.beans.*" %>
<%
    // Getting the product ID and user name from the request
    String productId = request.getParameter("pid");
    String userName = request.getParameter("uid");

    ProductServiceImpl productService = new ProductServiceImpl();
    ProductBean product = productService.getProductById(productId);

    if (product == null) {
        out.println("<h2>Product not found!</h2>");
        return;
    }

    // Getting the sold quantity for the product
    OrderServiceImpl orderService = new OrderServiceImpl();
    int soldQty = orderService.countSoldItem(product.getProdId());
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= product.getProdName() %></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #E6F9E6;">

    <!-- Dynamic Include for Header -->
    <jsp:include page="header.jsp" />

    <div class="container">
        <h2><%= product.getProdName() %></h2>
        <img src="./ShowImage?pid=<%= product.getProdId() %>" alt="Product" style="height: 300px; max-width: 300px">
        <p><strong>Price:</strong> Tk <%= product.getProdPrice() %></p>
        <p><strong>Description:</strong> <%= product.getProdInfo() %></p>
        <p><strong>Stock Quantity:</strong> <%= product.getProdQuantity() %> units</p>
        <p><strong>Sold Quantity:</strong> <%= soldQty %> units</p>

        <form method="post">
            <button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn btn-danger">Remove Product</button>
            &nbsp;&nbsp;&nbsp;
            <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn btn-primary">Update Product</button>
            &nbsp;&nbsp;&nbsp;
        </form>
    </div>

    <!-- Static Include for Footer -->
    <%@ include file="footer.html" %>

</body>
</html>
