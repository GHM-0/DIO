package src;

public class Rectangle implements AreaCalculatorInterface{

    protected double base;
    protected double height;

    public Rectangle(double base, double height){
        this.base=base;
        this.height=height;
    }

    @Override
    public double getArea() {
        return this.base*this.height;
    }
}
