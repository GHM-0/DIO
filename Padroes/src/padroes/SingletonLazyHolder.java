package padroes;

public class SingletonLazyHolder {
    private static class InstanceHolder{
    public static SingletonLazyHolder instance= new SingletonLazyHolder();
    }
    private SingletonLazyHolder(){}

    public SingletonLazyHolder getInctance(){
        return InstanceHolder.instance;
    }
}
