<%@ page import="general.AreaCheckServlet" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page pageEncoding="utf-8"%>

<html>
<head>
    <title>response page</title>
    <meta charset="utf-8">
    <style type="text/css">
        body {
            color: #fff;
            font-family: "Andale Mono", monospace;
        }
        span {
            font-size: 120%;
        }
        tr td {
            border: 2px green;
        }
    </style>
</head>
<body>
<%
    AreaCheckServlet acs = (AreaCheckServlet)request.getAttribute("acs");
    final ServletContext context = request.getServletContext();
    final HttpSession sssn = request.getSession();
    final List<Map<String, String>> queriesList = acs.getSessionQueries(context, sssn);
    Map<String, String> queryMap;
    out.flush();
    for(int i = 0; i < acs.ox.size(); i++) {
        queryMap = new HashMap<String, String>();
        queryMap.put("X", acs.ox.get(i));
        queryMap.put("Y", acs.getOy());
        queryMap.put("R", acs.getNumR());
        queryMap.put("A", (acs.validate(acs.ox.get(i))?"+":"-"));
        queriesList.add(queryMap);
        //out.print("<p><span>(" + acs.ox.get(i) + ", " + acs.getOy() + "); R = " + acs.getNumR() + "</span> => <b>"+ (acs.validate(acs.ox.get(i))?"+":"-") +"</b></p>");
    }
    out.print(acs.validate(acs.ox.get(0)));
    out.print(acs.formResultTable(request));
    out.close();

%>
</body>
</html>
