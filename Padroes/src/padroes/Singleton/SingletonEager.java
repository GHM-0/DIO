package padroes.Singleton;

public class SingletonEager {

    public static SingletonEager instance=new SingletonEager();
    private SingletonEager(){
        instance=this;
    }

    public static SingletonEager getInstance(){
        return instance;
    }


}
