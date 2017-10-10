package general;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class ControllerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String Ox = request.getParameter("x44");
        String Oy = request.getParameter("y");
        String NumR = request.getParameter("r");

        AreaCheckServlet acs = new AreaCheckServlet();
        acs.setOy(Oy);
        acs.setNumR(NumR);
        String[] xKinds = {"x55", "x44", "x33", "x22", "x11", "x0", "x1", "x2", "x3", "x4", "x5"};
        for (int i = 0; i < xKinds.length; i++) {
            if(request.getParameter(xKinds[i]) != null) {
            acs.putX(request.getParameter(xKinds[i]));
            }
        }
        request.setAttribute("acs", acs);

        RequestDispatcher rd=request.getRequestDispatcher("result_generator.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
}  