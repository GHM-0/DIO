package padroes.Singleton;

public class SingletonLazy {

    public static SingletonLazy instance=null;
    private SingletonLazy(){
        instance=this; //???
    }

public static SingletonLazy getInstance(){

//        if(instance!=null){
//        return instance;
//        }else{
//        return instance=new SingletonLazy();
//        }
//        }

    return (instance==null)?(new SingletonLazy()):instance;
}
}
