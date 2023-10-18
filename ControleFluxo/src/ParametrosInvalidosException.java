public class ParametrosInvalidosException extends RuntimeException{
private String message="Parametros Invalidos";
    public ParametrosInvalidosException(String message){
        super();
        this.message=message;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
