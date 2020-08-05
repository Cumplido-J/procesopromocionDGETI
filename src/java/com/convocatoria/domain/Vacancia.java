package domain;

/**
 *
 * @author shetz
 */
public class Vacancia {
    private int id;
    private int vacancia;
    private String plantel;
    private String categoria;
    private String carrera;


    
    public Vacancia(){}

    public Vacancia(int id, int vacancia, String plantel, String categoria, String carrera) {
        this.id = id;
        this.vacancia = vacancia;
        this.plantel = plantel;
        this.categoria = categoria;
        this.carrera = carrera;

    }



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getVacancia() {
        return vacancia;
    }

    public void setVacancia(int vacancia) {
        this.vacancia = vacancia;
    }

    public String getPlantel() {
        return plantel;
    }

    public void setPlantel(String plantel) {
        this.plantel = plantel;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }





}
