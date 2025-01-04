
package sgmusic.model;

/**
 * Specifies a read-only view of an instrument.
 */
public interface InstrumentDTO {
    /**
     * @return The instrument number.
     */
    public int getInstrumentNo();

    /**
     * @return The instrument's type.
     */
    public String getType();

    /**
     * @return The instrument's brand.
     */
    public String getBrand();

    /**
     * @return The instrument lease price.
     */
    public int getPrice();
}
