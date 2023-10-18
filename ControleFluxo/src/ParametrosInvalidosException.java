public class ParametrosInvalidosException extends RuntimeException{
private final String message="Parametros Invalidos";
    public ParametrosInvalidosException(){
        super();
    }

    @Override
    public String getMessage() {
        return message;
    }
}
