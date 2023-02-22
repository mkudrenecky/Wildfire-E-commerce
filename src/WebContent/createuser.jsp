<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>BCWS Tool Shed Create User</title>
</head>
<body style="background: #F2F3F4"></body>
<body>
    <%@ include file="header.jsp" %>
<h1>Create User</h1>
<form method="get" action="createuser.jsp">
<table style="display:inline">
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
        <td><input type="text" name="fname"  size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
        <td><input type="text" name="lname" size=10 maxlength="10"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
        <td><input type="text" name="email" size=10 maxlength="50"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
        <td><input type="number" name="phonenum" size=10 maxlength="10"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
        <td><input type="text" name="address" size=10 maxlength="50"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
        <td><input type="text" name="city" size=10 maxlength="50"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
        <td><input type="text" name="state" size=10 maxlength="3"></td>
    </tr> <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
        <td><input type="text" name="country" size=10 maxlength="20"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
        <td><input type="text" name="postcode" size=10 maxlength="9"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">User ID:</font></div></td>
        <td><input type="text" name="uid" size=10 maxlength="15"></td>
    </tr><tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
        <td><input type="password" name="pass" size=10 maxlength="50"></td>
    </tr>
    </table>
    <input class="submit" type="submit" name="Submit3" value="Submit">
    <input type="reset" value="Reset">
    </form>

<%
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String phonenum = request.getParameter("phonenum");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("state");
String postcode = request.getParameter("postcode");
String uid = request.getParameter("uid");
String pass = request.getParameter("pass");

boolean hasNameParam = fname != null && !fname.equals("") && lname != null && !lname.equals("");
boolean hasEmailParam = email != null && !email.equals("");
boolean hasPhoneParam = phonenum != null && !phonenum.equals("");
boolean hasAddressParam = address != null && !address.equals("");
boolean hasCityParam = city != null && !city.equals("");
boolean hasStateParam = state != null && !state.equals("");
boolean hasCountryParam = country != null && !country.equals("");
boolean hasPostParam = postcode != null && !postcode.equals("");
boolean hasUidParam = uid != null && !uid.equals("");
boolean hasPassParam = pass != null && !pass.equals("");


String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('"+fname+"', '"+lname+"', '"+email+"', '"+phonenum+"', '"+address+"', '"+city+"', '"+state+"', '"+postcode+"', '"+country+"', '"+uid+"', '"+pass+"');";


try  
{	
    // && !lname.equals(null) && !email.equals(null) && !phonenum.equals(null) && !address.equals(null) && !city.equals(null))
	
        getConnection();
       
        if(hasNameParam && hasAddressParam && hasCityParam && hasCountryParam && hasEmailParam && hasPassParam && hasPhoneParam && hasPostParam && hasStateParam && hasUidParam)
        {
        Statement stmt = con.createStatement(); 			
	    stmt.execute("USE orders");

        Statement stmt2 = con.createStatement();
        stmt2.execute(sql);
        out.println("User Created! "+uid);
        }
        else
        out.println("Please fill in all fields!");
        

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