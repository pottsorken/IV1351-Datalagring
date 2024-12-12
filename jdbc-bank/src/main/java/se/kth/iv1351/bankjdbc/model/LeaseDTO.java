
package se.kth.iv1351.bankjdbc.model;

/**
 * Specifies a read-only view of an account.
 */
public interface LeaseDTO {
    /**
     * @return The account number.
     */
    public int getLeaseNo();

    /**
     * @return The state, true for active and false for inactive.
     */
    public boolean getLeaseState();

    /**
     * @return The lessee's id.
     */
    public int getLessee();

    /**
     * @return The instrument id.
     */
    public int getInstrument();
}
