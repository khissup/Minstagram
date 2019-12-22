package dbControl;

public class AdminDTO {
    private int id;
    private String admin_id;
    private String password;

    public AdminDTO(){

    }

    public AdminDTO(int id, String password, String admin_id){
        this.id = id;
        this.password = password;
        this.admin_id = admin_id;
    }

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public void setEmail(String admin_id) { this.admin_id = admin_id;}

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}