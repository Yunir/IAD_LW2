package general;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AreaCheckServlet  {
    static final private String SESSIONS_QUERIES_LISTS = "SessionQueriesLists";
    private String Oy, NumR;
    public ArrayList<String> ox;

    AreaCheckServlet() {
        ox = new ArrayList<String>();
    }

    public String getOy() {
        return Oy;
    }
    public void setOy(String oy) {
        Oy = oy;
    }
    public String getNumR() {
        return NumR;
    }
    public void setNumR(String numR) {
        NumR = numR;
    }
    public void putX(String x){
        ox.add(x);
    }

    public boolean validate(String xx){
        double x = Double.parseDouble(xx);
        double y = Double.parseDouble(Oy);
        double r = Double.parseDouble(NumR);
        return (x >= 0 && y >= 0 && (y <= ((r / 2) - x))) || (x >= 0 && y <= 0 && (Math.pow(x, 2) + Math.pow(y, 2) <= Math.pow(r, 2)) || (x <= 0 && y <= 00 && y >= (-r / 2) && (x >= -r)));
    }

    public List<Map<String, String>> getSessionQueries(final ServletContext context, final HttpSession session) {
        // if it doesn't exist, then create, else return
        Map<HttpSession, List<Map<String, String>>> map = (Map<HttpSession, List<Map<String, String>>>) context.getAttribute(SESSIONS_QUERIES_LISTS);
        if (map == null) {
            context.setAttribute(SESSIONS_QUERIES_LISTS, new HashMap<HttpSession, List<Map<String, String>>>());
            map = (Map<HttpSession, List<Map<String, String>>>) context.getAttribute(SESSIONS_QUERIES_LISTS);
        }
        if (map.get(session) == null)
            map.put(session, new ArrayList<Map<String, String>>());
        // map.computeIfAbsent(session, key -> new ArrayList<>());
        return map.get(session);
    }

    public String formResultTable(final HttpServletRequest request) {
        final List<Map<String, String>> sessionQueriesList = getSessionQueries(request.getServletContext(), request.getSession());
        final StringBuilder builder = new StringBuilder();
        builder.append("<table id='table_on' width='400'><tr>");
        builder.append("<td>X</td>");
        builder.append("<td>Y</td>");
        builder.append("<td>R</td>");
        builder.append("<td>A</td>");
        builder.append("</tr>");
        for (final Map<String, String> queryMap : sessionQueriesList) {
            builder.append("<tr>");
            builder.append("<td>").append((queryMap.get("X")).substring(0, Math.min((queryMap.get("X")).length(), 5))).append("</td>");
            builder.append("<td>").append((queryMap.get("Y")).substring(0, Math.min((queryMap.get("Y")).length(), 5))).append("</td>");
            builder.append("<td>").append(queryMap.get("R")).append("</td>");
            builder.append("<td>").append(queryMap.get("A")).append("</td>");
            builder.append("</tr>");
        }
        builder.append("</table>");
        return builder.toString();
    }
}
