<H1 align="center"><font face="cursive" color="#3399FF"><a href="index.jsp">BCWS Tool Shed</a></font></H1>      
<hr>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h2 align=\"center\">Signed in as: "+userName+"</h2>");
%>
