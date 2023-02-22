<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
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

// Print Customer information
String sql1 = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h3>Customer Profile</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	PreparedStatement pstmt1 = con.prepareStatement(sql1);
	pstmt1.setString(1, userName);	
	ResultSet rst1 = pstmt1.executeQuery();
	
	if (rst1.next())
	{
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Id</th><td>"+rst1.getString(1)+"</td></tr>");	
		out.println("<tr><th>First Name</th><td>"+rst1.getString(2)+"</td></tr>");
		out.println("<tr><th>Last Name</th><td>"+rst1.getString(3)+"</td></tr>");
		out.println("<tr><th>Email</th><td>"+rst1.getString(4)+"</td></tr>");
		out.println("<tr><th>Phone</th><td>"+rst1.getString(5)+"</td></tr>");
		out.println("<tr><th>Address</th><td>"+rst1.getString(6)+"</td></tr>");
		out.println("<tr><th>City</th><td>"+rst1.getString(7)+"</td></tr>");
		out.println("<tr><th>State</th><td>"+rst1.getString(8)+"</td></tr>");
		out.println("<tr><th>Postal Code</th><td>"+rst1.getString(9)+"</td></tr>");
		out.println("<tr><th>Country</th><td>"+rst1.getString(10)+"</td></tr>");
		out.println("<tr><th>User id</th><td>"+rst1.getString(11)+"</td></tr>");		
		out.println("</table>");
	}

	out.println("<h3>Orders placed by Customer</h3>");

	String sql = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName, orderDate FROM OrderSummary O, Customer C WHERE "
		+ "O.customerId = C.customerId and C.userid='"+userName+"'";

	ResultSet rst = stmt.executeQuery(sql);		
	out.print("<table border=\"1\"><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	
	// Use a PreparedStatement as will execute many times
	sql = "SELECT productId, quantity, price FROM OrderProduct WHERE orderId=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	while (rst.next())
	{	int orderId = rst.getInt(1);
		out.print("<tr><td>"+orderId+"</td>");
		out.print("<td>"+rst.getString(5)+"</td>");
		out.print("<td>"+rst.getInt(2)+"</td>");		
		out.print("<td>"+rst.getString(4)+"</td>");
		out.print("<td>"+currFormat.format(rst.getDouble(3))+"</td>");
		out.println("</tr>");

		// Retrieve all the items for an order
		pstmt.setInt(1, orderId);				
		ResultSet rst2 = pstmt.executeQuery();
		
		out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">");
		out.println("<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		while (rst2.next())
		{
			out.print("<tr><td>"+rst2.getInt(1)+"</td>");
			out.print("<td>"+rst2.getInt(2)+"</td>");
			out.println("<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
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

