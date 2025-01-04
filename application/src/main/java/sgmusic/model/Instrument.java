
package sgmusic.model;

/**
 * Lease
 */
public class Instrument implements InstrumentDTO {

    private int instrumentNo;
    private String type;
    private String brand;
    private int leasePrice;
    private boolean onLease;

    // private int leaseNo;
    // private int lesseeNo;
    // private int instrumentNo;
    // private boolean active;
    // private boolean finished; // NOTE: May be unneccesary
    // private String startDate;
    // private String endDate;
    
    public Instrument(int instrumentNo, String type, String brand, int price, boolean isOnLease) {
        this.instrumentNo = instrumentNo;
        this.type = type;
        this.brand = brand;
        this.leasePrice = price;
        this.onLease = isOnLease;
    }

    public Instrument(int instrumentNo, String type, String brand, int price) {
        this.instrumentNo = instrumentNo;
        this.type = type;
        this.brand = brand;
        this.leasePrice = price;
        this.onLease = false;
    }

    public int getInstrumentNo() {
        return instrumentNo;
    }

    public String getType() {
        return type;
    }

    public String getBrand() {
        return brand;
    }

    public int getPrice() {
        return leasePrice;
    }

    public boolean getOnLease() {
        return onLease;
    }

    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Instrument: [");
        stringRepresentation.append("Instrument number: ");
        stringRepresentation.append(instrumentNo);
        stringRepresentation.append(", type: ");
        stringRepresentation.append(type);
        stringRepresentation.append(", brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", lease price: ");
        stringRepresentation.append(leasePrice);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
