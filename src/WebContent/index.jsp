<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
        <title>BCWS Tool Shed Main Page</title>
</head>
<body style="background: url(./img/26.jpg);background-size:100%;"></body>
<body>
<h1 align="center">Welcome to the BCWS Tool Shed</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="createuser.jsp">Create User</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<h2 align="center"><a href="loaddata.jsp">Reload Database</a></h2>
<%@ include file="jdbc.jsp" %>


<%
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
	out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");

	String sql = "SELECT productId, sum(quantity) FROM orderproduct GROUP BY productId ORDER BY sum(quantity) DESC";
	String sql2 = "SELECT productName, productPrice FROM product WHERE productId = ?";
		try 
		{	
			out.println("<h3 align=\"center\">MOST POPULAR PRODUCTS</h3>");
			
			getConnection();
			Statement stmt = con.createStatement(); 
			stmt.execute("USE orders");
		
			// Display Order Summary
			ResultSet rst = con.createStatement().executeQuery(sql);		
			out.println("<table align=\"center\" class=\"table\" border=\"1\">");
			out.print("<tr><th>Product Name</th><th>Price</th></tr>");	
			int count=0;
		
			while (rst.next() && count<3)
			{
				
				count++;

				String prodId = rst.getString(1);
				PreparedStatement pstmt = con.prepareStatement(sql2);
				pstmt.setString(1, prodId);
				ResultSet rst2 = pstmt.executeQuery();

				while(rst2.next())
				{
					out.println("<tr><td><a href=\"product.jsp?id="+prodId+"\">" + rst2.getString(1) + "</td><td>"+currFormat.format(rst2.getDouble(2))+"</td></tr>"); //<td><img src=\"displayImage.jsp?id="+prodId+"\"></td>
				}
			}
			out.print("</table>");
		}
		catch (SQLException ex) 
		{ 	
			out.println(ex); 
		}
		finally
		{	
			closeConnection();	
		}
	
%>
</body>
</head>


