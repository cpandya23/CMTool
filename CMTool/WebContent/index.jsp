<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CM Tool</title>
</head>
<body>

<%@ page import= "java.sql.* "%>
<%@ page import= "javax.xml.parsers.DocumentBuilderFactory"%>
<%@ page import= "javax.xml.parsers.DocumentBuilder"%>
<%@ page import= "org.w3c.dom.Document"%>
<%@ page import= "org.w3c.dom.NodeList"%>
<%@ page import= "org.w3c.dom.Node"%>
<%@ page import= "org.w3c.dom.Element"%>
<%@ page import= "java.io.File"%>

<%
Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://localhost:3306/demo";
String username = "Chintan";
String password = "1234";	
	

java.sql.Connection con= DriverManager.getConnection(url, username, password);

Statement st= con.createStatement();
ResultSet rs= st.executeQuery("SELECT * FROM demo.websites");

File fXmlFile = new File("\\Users\\chintan_pandya\\eclipse-workspace\\CMTool_v1\\WebContent\\WEB-INF\\RequestTypes.xml");
DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
Document doc = dBuilder.parse(fXmlFile);
doc.getDocumentElement().normalize();


%>




<form action="upload" method="post" enctype="multipart/form-data" >
<table>
<tr><td><p>CM Tool </p></td></tr>

<tr><td>Ticket# </td><td>: <input type="text" name="ticketNumber" id= "ticketNumber"  placeholder="ticketNumber" required ></td></tr>

<tr><td>Website name </td><td>: <select name="website" id="websiteID" required>
	<option value="" disabled selected>Select Subsite</option>
   <%  while(rs.next()){ %>
            <option ><%= rs.getString(2)%></option>
        <% } %></select></td></tr>

<tr><td>Subsite name </td><td>: <select name="subsite" id="subsiteID"><option value="" disabled selected>Select Subsite</option>



</select></td></tr>

<tr><td>Description </td><td>: <input type="text" name="description" required></td></tr>




<tr><td>Request Type </td><td>: <select name="requestType" id="requestType" required>
<option value="" disabled selected>Request</option>
<%
NodeList nList = doc.getElementsByTagName("request");

for (int temp = 0; temp < nList.getLength(); temp++) {
	Node nNode = nList.item(temp);
	if (nNode.getNodeType() == Node.ELEMENT_NODE) {

		Element eElement = (Element) nNode;
%>	
	
	<option value="<%=eElement.getAttribute("name")%>"><%=eElement.getAttribute("name")%></option><%} %>
<%} %>
</select></td></tr>
<% %>

<tr><td>File Upload </td><td>: <input type="file" name="file" multiple="multiple" required ></td></tr>
<tr></tr>
<tr></tr>
<tr></tr>
<tr><td><input type="submit" name="Submit"></td></tr>
</table>
</form>


</body>

<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script> -->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
 <script src="http://ajax.microsoft.com/ajax/jquery.validate/1.11.1/additional-methods.js"></script>
 <script language="JavaScript" type="text/javascript" >

 jQuery(function () {

    $('#myform').validate({ // initialize the plugin
        rules: {
        	ticketNumber: {required: true},
    		
        	website:{required: true}
        }, messages: {
        	ticketNumber: {
                required: "Please enter your name",
               
            },
    
            website:{required: "Please enter your gender",}
        }
    });

});
 

        $category = $('#websiteID');
	
        $category.change (
            function() {
                $.ajax({
                    type: "POST",
                    url: "GetSubsite",
                    data: {category: $category.val() },
                    success: function(data){
                        $("#subsiteID").html(data)
                    }
                });
            }
        );
        
    
        
        
        
        
        
    </script>


</html>