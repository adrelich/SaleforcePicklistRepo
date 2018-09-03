public class PicklistRepositoryException extends Exception {

    public String message;
    public Integer code;

    public PicklistRepositoryException(String message, Integer code) {
        this.message = message;
        this.code = code;
    }

}