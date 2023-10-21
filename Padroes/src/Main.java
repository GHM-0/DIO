import padroes.Singleton.SingletonEager;
import padroes.Singleton.SingletonLazy;

public class Main {
    public static void main(String[] args) {
        var sig= SingletonLazy.getInstance();
        System.out.println(sig);
        var sig2=SingletonLazy.getInstance();
        System.out.println(sig2.equals(sig));

        var sige= SingletonEager.getInstance();
        System.out.println(sige);
        var sige2=SingletonEager.getInstance();
        System.out.println(sige2.equals(sige));

        var siglh= SingletonEager.getInstance();
        System.out.println(siglh);
        var siglh2=SingletonEager.getInstance();
        System.out.println(siglh2.equals(siglh));



    }
}