package src;

public class Square implements AreaCalculatorInterface{

    protected double side;

    public Square(double side){
        this.side = side;
    }

    @Override
    public double getArea() {
        return Math.pow(this.side,2);
    }
}
