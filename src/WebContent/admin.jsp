<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body style="background: #F2F3F4"></body>
<body>
<H1 align="center"><font face="cursive" color="#3399FF"><a href="index.jsp">BCWS Tool Shed</a></font></H1>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
String sql2 = "select userid, firstName, lastName from customer";
String sql3 = "select productName, productInventory.productId, quantity from productInventory join product on productInventory.productId = product.productId ";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	// Display Order Summary
	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
	}
	out.println("</table>");
	out.println();

	out.println("<h3>Customer List</h3>");

	// Display Customer List
	ResultSet rst2 = con.createStatement().executeQuery(sql2);
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Customer ID</th><th>Customer Name</th>");

	while (rst2.next())
	{
		out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+" "+rst2.getString(3)+"</td></tr>");
	}
	out.println("</table>");

	out.println("<h3>Warehouse Inventory</h3>");

	// Display warehouse inventory
	ResultSet rst3 = con.createStatement().executeQuery(sql3);
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Product Name</th><th>Product ID</th><th>Inventory Quantity</th>");

	while (rst3.next())
	{
		out.println("<tr><td>"+rst3.getString(1)+"</td><td>"+rst3.getString(2)+"</td><td>"+rst3.getString(3)+"</td></tr>");
	}
	out.println("</table>");

	out.println("<h3>Add New Product:</h3>");

	%>
	
<form method="get">
	<table style="display:inline">
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Name</font></div></td>
			<td><input type="text" name="prodName" size=10 maxlength=30></td>
		</tr>
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Category ID</font></div></td>
			<td><input type="number" name="catId" min=1 max = 8 size=10 maxlength="10"></td>
		</tr><tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Description</font></div></td>
			<td><input type="text" name="desc" size=10 maxlength="100"></td>
		</tr><tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Price</font></div></td>
			<td><input type="decimal" name="price" size=10 maxlength="10"></td>
		</tr>
		</table>
		<input class="submit" type="submit" name="Submit4" value="Add Product">
		<input type="reset" value="Reset">
		</form>

<%
String prodName = request.getParameter("prodName");
			//int catId = Integer.parseInt(request.getParameter("catId"));
			String catId = request.getParameter("catId");
			String desc = request.getParameter("desc");
			String price = request.getParameter("price");
			//double price = Double.parseDouble(request.getParameter("price"));
			
			boolean hasNameParam = prodName != null && !prodName.equals("");
			//boolean hasCatParam = catId != null 
			boolean hasDescParam = desc != null && !desc.equals("");
			//boolean hasPriceParam = price != null 
			
String sql5 = "INSERT INTO product (productName, categoryId, productDesc, productPrice) VALUES ('"+prodName+"', "+catId+", '"+desc+"', "+price+");";

if(hasNameParam && hasDescParam)
        {
        Statement stmt5 = con.createStatement();
        stmt5.execute(sql5);
        out.println("Product Added! New Product: " + prodName);
		}
        else
        out.print("Please fill in all fields!");
	}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

