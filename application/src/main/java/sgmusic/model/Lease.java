
package sgmusic.model;

/**
 * Lease
 */
public class Lease implements LeaseDTO {

    private int leaseNo;
    private int lesseeNo;
    private int instrumentNo;
    private boolean active;

    public Lease(int lesseeNo, int instrumentNo) {
        this.leaseNo = 0;
        this.lesseeNo = lesseeNo;
        this.instrumentNo = instrumentNo;
        this.active = true;
    }

    public Lease(int leaseNo, int lesseeNo, int instrumentNo, boolean active) {
        this.leaseNo = leaseNo;
        this.lesseeNo = lesseeNo;
        this.instrumentNo = instrumentNo;
        this.active = active;
    }

    public int getLeaseNo() {
        return leaseNo;
    }

    public boolean getLeaseState() {
        return active;
    }

    public int getLessee() {
        return lesseeNo;
    }

    public int getInstrument() {
        return instrumentNo;
    }

    public void terminateRental() {
        active = false;
    }

    public void setLeaseNo(int newLeaseNo) throws RejectedException {
        if (newLeaseNo <= 0) {
            throw new RejectedException("Tried to set illegal value: " + newLeaseNo + " lease: " + this);
        }
        leaseNo = newLeaseNo;
    }

    public String toString() {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Lease: [");
        stringRepresentation.append("Lease number: ");
        stringRepresentation.append(leaseNo);
        stringRepresentation.append(", student: ");
        stringRepresentation.append(lesseeNo);
        stringRepresentation.append(", instrument: ");
        stringRepresentation.append(instrumentNo);
        stringRepresentation.append(", ongoing: ");
        stringRepresentation.append(active);
        stringRepresentation.append("]");
        return stringRepresentation.toString();
    }
}
