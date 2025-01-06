/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package sgmusic.controller;

import java.util.List;
import sgmusic.integration.LeaseDAO;
import sgmusic.integration.SGMusicException;
import sgmusic.model.AccountException;
import sgmusic.model.Instrument;
import sgmusic.model.InstrumentDTO;
import sgmusic.model.Lease;
import sgmusic.model.LeaseDTO;
import java.util.ArrayList;


/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final LeaseDAO rentDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws SGMusicException If unable to connect to the database.
     */
    public Controller() throws SGMusicException {
        rentDb = new LeaseDAO();
    }

    /**
     * Creates a new lease for the specified student and instrument.
     * 
     * @param holderName The id of the lessee.
     * @throws AccountException If unable to create lease.
     */
    public void createLease(int lesseeNo, int instrumentNo) throws AccountException {
        String failureMsg = "Could not create lease for: " + lesseeNo;

        if (lesseeNo == 0) {
            throw new AccountException(failureMsg);
        }

        try {
            int quota = rentDb.findQuotaByPK(lesseeNo);

            //System.out.println(quota);
            Instrument instr = rentDb.findInstrumentById(instrumentNo);
            
            if (quota <= 0 || instr.getOnLease() == true) {
                throw new AccountException(failureMsg);
            } else {
                
                rentDb.changeInstrument(instrumentNo, true);
                rentDb.changeLessee(lesseeNo, quota - 1);
                rentDb.createLease(new Lease(lesseeNo, instrumentNo));
                commitOngoingTransaction(failureMsg);
            }
        } catch (Exception e) {
            rollbackOngoingTransaction(failureMsg);
            throw new AccountException(failureMsg, e);
        }
    }

    /**
     * Lists all leases in the whole database.
     * 
     * @return A list containing all leases. The list is empty if there are no
     *         leases.
     * @throws AccountException If unable to retrieve leases.
     */
    public List<? extends LeaseDTO> getAllLeases() throws AccountException {
        List<Lease> leases = new ArrayList<>();
        try {
            leases = rentDb.findAllLeases();
            commitOngoingTransaction("Unable to list leases.");
            return leases;
        } catch (Exception e) {
            rollbackOngoingTransaction("Unable to list leases.");
            throw new AccountException("Unable to list leases.", e);
        }
    }

    /**
     * Lists all leases owned by the specified student/lessee.
     * 
     * @param lesseeNo The student who's leases shall be listed.
     * @return A list with all leases owned by the specified student. The list is
     *         empty if the student does not have any leases, or if there is no
     *         such student.
     * @throws AccountException If unable to retrieve the student's accounts.
     */
    public List<? extends LeaseDTO> getLeasesForStudent(int lesseeNo) throws AccountException {
        if (lesseeNo == 0) {
            return new ArrayList<>();
        }
        List<Lease> leases = new ArrayList<>();

        try {
            leases = rentDb.findLeasesByLessee(lesseeNo);
            commitOngoingTransaction("Could not search for lease.");
            return leases;
        } catch (Exception e) {
            rollbackOngoingTransaction("Could not search for lease.");
            throw new AccountException("Could not search for lease.", e);
        }
    }

        /**
     * Lists the lease that maches specified number.
     * 
     * @param holderName The lease which shall be listed.
     * @return A lease that matches the specified number.
     * @throws AccountException If unable to retrieve the lease.
     */
    public Lease getLeaseForLeaseNo(int leaseNo) throws AccountException {
        if (leaseNo == 0) {
            return null;
        }
        Lease lease = null;

        try {
            lease = rentDb.findLeaseByLease(leaseNo);
            commitOngoingTransaction("Could not search for lease.");
            return lease;
        } catch (Exception e) {
            rollbackOngoingTransaction("Could not search for lease.");
            throw new AccountException("Could not search for lease.", e);
        }
    }

    /**
     * Lists all instruments that is vailable for rent.
     * 
     * @return A list containing all instruments. The list is empty if there are no
     *         instruments.
     * @throws AccountException If unable to retrieve instruments.
     */
    public List<? extends InstrumentDTO> getAllInstruments() throws AccountException {
        List<Instrument> instruments = new ArrayList<>();
        try {
            instruments = rentDb.findAllInstruments();
            commitOngoingTransaction("Unable to list instruments.");
            return instruments;
        } catch (Exception e) {
            rollbackOngoingTransaction("Unable to list instruments.");
            throw new AccountException("Unable to list instruments.", e);
        }
    }

    /**
     * Lists all instruments of a specific type.
     * 
     * @param typeName The type of instrument.
     * @return A list with all instruments of a certain type. The list is
     *         empty if there is no available instruments of that type.
     *
     * @throws AccountException If unable to retrieve the instruments.
     */
    public List<? extends InstrumentDTO> getInstrumentsByType(String typeName) throws AccountException {
        if (typeName == null) {
            return new ArrayList<>();
        }
        List<Instrument> instruments = new ArrayList<>();

        try {
            instruments = rentDb.findInstrumentsByType(typeName);
            commitOngoingTransaction("Could not search for instruments.");
            return instruments;
        } catch (Exception e) {
            rollbackOngoingTransaction("Could not search for instruments.");
            throw new AccountException("Could not search for instruments.", e);
        }
    }

    private void commitOngoingTransaction(String failureMsg) throws AccountException {
        try {
            rentDb.commit();
        } catch (SGMusicException bdbe) {
            throw new AccountException(failureMsg, bdbe);
        }
    }

    private void rollbackOngoingTransaction(String failureMsg) throws AccountException {
        try {
            rentDb.rollback();
        } catch (SGMusicException bdbe) {
            throw new AccountException(failureMsg, bdbe);
        }
    }

    /**
     * Terminates the lease with the specified lease number.
     *
     * @param leaseNo The number of the lease that shall be terminated.
     * @throws AccountException If failed to terminate the specified lease.
     */
    public void terminateLease(int leaseNo) throws AccountException {
        String failureMsg = "Could not terminate lease: " + leaseNo;

        if (leaseNo <= 0) {
            throw new AccountException(failureMsg);
        }
        try {
            Lease ls = getLeaseForLeaseNo(leaseNo);
            if (ls.getLeaseState() == true) {

                int quota = rentDb.findQuotaByPK(ls.getLessee());
                // rentDb.changeInstrument(instrumentNo, false);
                rentDb.changeInstrument(ls.getInstrument(), false);
                rentDb.changeLessee(ls.getLessee(), quota + 1);
                rentDb.changeLease(leaseNo, false);

            }
            else{
                System.out.println("Lease is already terminated.");
            }
            commitOngoingTransaction(failureMsg);
        } catch (Exception e) {
            rollbackOngoingTransaction(failureMsg);
            throw new AccountException(failureMsg, e);
        }
    }
}
