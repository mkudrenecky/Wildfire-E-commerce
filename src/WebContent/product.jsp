<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>BCWS Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background: #F2F3F4"></body>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productPrice, productImageURL, productImage, productDesc FROM Product P  WHERE productId = ?";
String sql2 = "SELECT reviewRating, reviewDate, customerId, productId, reviewComment FROM review WHERE productId = ?";


NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();

	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst2 = pstmt2.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h2>"+rst.getString(2)+"</h2>");
		
		int prodId = rst.getInt(1);
		out.println("<table><tr>");
		out.println("<th>Id</th><td>" + prodId + "</td></tr>"				
				+ "<tr><th>Price</th><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr><tr><th>Description</th><td>"+rst.getString(6)+"</td></tr>");
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+imageLoc+"\">");
		
		// Retrieve any image stored directly in database
		String imageBinary = rst.getString(5);
		if (imageBinary != null)
			out.println("<img src=\"displayImage.jsp?id="+prodId+"\">");	
		out.println("</table>");

		out.println("<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
			+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>");		

		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");

		out.println();
		out.println("<h3>Reviews</h3>");
			
		out.println("<table class=\"table\" border=\"1\">");
		out.println("<tr><th>Review Rating (*/5)</th><th>Date</th><th>Customer Id</th><th>Comments</th>");

		while(rst2.next())
		{
			out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td><td>"+rst2.getString(5)+"</td></tr>");
		}
		out.println("</table>");
	}

		out.println("<h3>Leave a Review:</h3>");
		%>
		<form method="get">
			<table style="display:inline" action="listprod.jsp">
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Rating (*/5)</font></div></td>
					<td><input type="number" name="rating" min=0 max=5 size=10 maxlength=10></td>
				</tr>
				<tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Date</font></div></td>
					<td><input type="date" name="date" size=10 maxlength="10"></td>
				</tr><tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Customer Id</font></div></td>
					<td><input type="number" name="custid" size=10 maxlength="10"></td>
				</tr><tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Comments</font></div></td>
					<td><input type="text" name="comment" size=10 maxlength="300"></td>
				</tr><tr>
					<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product ID</font></div></td>
					<td><input type="text" name="id" size=10 maxlength="10"><%out.print("Current Product Id: "+productId);%></td>
				</table>
				<input class="submit" type="submit" name="Submit9" value="Leave Review">
				<input type="reset" value="Reset">
				</form>

<%
			String rating = request.getParameter("rating");
			String date = request.getParameter("date");
			String custid = request.getParameter("custid");
			String comment = request.getParameter("comment");
			//int cid = Integer.parseInt(custid);
			
			
			boolean hasRatingParam = rating != null;
			//boolean hasDateParam = date != null && !date.equals("");
			boolean hasCommentParam = comment != null && !comment.equals("");
			boolean hasIdParam = custid != null;
			
			String sql3 = "INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES ("+rating+", '"+date+"', "+custid+", "+productId+", '"+comment+"');";
			Statement stmt3 = con.createStatement();

			String sql4 = "SELECT count(reviewRating) FROM review WHERE customerId = "+custid+" and productId ="+productId+" GROUP BY customerId";
			Statement stmt4 = con.createStatement();
			ResultSet rst4 = stmt4.executeQuery(sql4);
			String reviews="0";
			while(rst4.next())
			{
				reviews = rst4.getString(1);
				
			}
			
			int reviewCount = Integer.parseInt(reviews);

			boolean restrictReview = reviewCount>=1;
			if(!restrictReview)
			{
			if(hasRatingParam && hasCommentParam && hasIdParam)
			{
       		 	stmt3.execute(sql3);
        		out.println("Review Entered!");
        	}
        	else
			out.print("Please fill in all fields!");
		}
		else
        	out.print("Limit One Review per Item per Customer!");
	
			

} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>

</body>
</html>

