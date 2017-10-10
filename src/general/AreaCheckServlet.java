package general;

import java.util.ArrayList;

/**
 * Created by Yunicoed on 25.09.2017.
 */
public class AreaCheckServlet  {
    private String Oy, NumR;
    public ArrayList<String> ox;

    AreaCheckServlet() {
        ox = new ArrayList();
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
        if((x>=0 && y>=0 && (y <=((r/2)-x))) || (x>=0 && y<=0 && (Math.pow(x, 2)+Math.pow(y, 2)<=Math.pow(r, 2)) || (x<=0 && y<=00 && y>=(-r/2) && (x >= -r)))){
            return true;
        }
        else{
            return false;
        }
    }
}
