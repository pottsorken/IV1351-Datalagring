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

package se.kth.iv1351.bankjdbc.controller;

import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.bankjdbc.integration.LeaseDAO;
import se.kth.iv1351.bankjdbc.integration.BankDBException;
import se.kth.iv1351.bankjdbc.model.Lease;
import se.kth.iv1351.bankjdbc.model.LeaseDTO;
import se.kth.iv1351.bankjdbc.model.Instrument;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;
import se.kth.iv1351.bankjdbc.model.AccountException;
import se.kth.iv1351.bankjdbc.model.RejectedException;

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
     * @throws BankDBException If unable to connect to the database.
     */
    public Controller() throws BankDBException {
        rentDb = new LeaseDAO();
    }

    /**
     * Creates a new lease for the specified student and instrument.
     * 
     * @param holderName The account holder's name.
     * @throws AccountException If unable to create account.
     */
    public void createLease(int lesseeNo, int instrumentNo) throws AccountException {
        String failureMsg = "Could not create lease for: " + lesseeNo;

        if (lesseeNo == 0) {
            throw new AccountException(failureMsg);
        }

        try {
            int quota = rentDb.findQuotaByPK(lesseeNo);

            System.out.println(quota);
            Instrument instr = rentDb.findInstrumentById(instrumentNo);
            // TODO: Add check that specified instrument is free
            // TODO: Decrement quota value (change quota prepare stmt)
            if (quota <= 0 || instr.getOnLease() == true) {
                throw new AccountException(failureMsg);
            } else {
                
                rentDb.changeInstrument(instrumentNo, true);
                rentDb.changeLessee(lesseeNo, quota - 1);
                rentDb.createLease(new Lease(lesseeNo, instrumentNo));
                commitOngoingTransaction(failureMsg);
            }
        } catch (Exception e) {
            throw new AccountException(failureMsg, e);
        }
    }

    /**
     * Lists all accounts in the whole bank.
     * 
     * @return A list containing all accounts. The list is empty if there are no
     *         accounts.
     * @throws AccountException If unable to retrieve accounts.
     */
    public List<? extends LeaseDTO> getAllLeases() throws AccountException {
        List<Lease> leases = new ArrayList<>();
        try {
            leases = rentDb.findAllLeases();
            commitOngoingTransaction("Unable to list leases.");
            return leases;
        } catch (Exception e) {
            throw new AccountException("Unable to list leases.", e);
        }
    }

    /**
     * Lists all accounts owned by the specified account holder.
     * 
     * @param holderName The holder who's accounts shall be listed.
     * @return A list with all accounts owned by the specified holder. The list is
     *         empty if the holder does not have any accounts, or if there is no
     *         such holder.
     * @throws AccountException If unable to retrieve the holder's accounts.
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
            throw new AccountException("Could not search for lease.", e);
        }
    }

        /**
     * Lists all accounts owned by the specified account holder.
     * 
     * @param holderName The holder who's accounts shall be listed.
     * @return A list with all accounts owned by the specified holder. The list is
     *         empty if the holder does not have any accounts, or if there is no
     *         such holder.
     * @throws AccountException If unable to retrieve the holder's accounts.
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
            throw new AccountException("Could not search for lease.", e);
        }
    }

    /**
     * Lists all accounts in the whole bank.
     * 
     * @return A list containing all accounts. The list is empty if there are no
     *         accounts.
     * @throws AccountException If unable to retrieve accounts.
     */
    public List<? extends InstrumentDTO> getAllInstruments() throws AccountException {
        List<Instrument> instruments = new ArrayList<>();
        try {
            instruments = rentDb.findAllInstruments();
            commitOngoingTransaction("Unable to list instruments.");
            return instruments;
        } catch (Exception e) {
            throw new AccountException("Unable to list instruments.", e);
        }
    }

    /**
     * Lists all accounts owned by the specified account holder.
     * 
     * @param holderName The holder who's accounts shall be listed.
     * @return A list with all accounts owned by the specified holder. The list is
     *         empty if the holder does not have any accounts, or if there is no
     *         such holder.
     * @throws AccountException If unable to retrieve the holder's accounts.
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
            throw new AccountException("Could not search for instruments.", e);
        }
    }

    /// **
    // * Retrieves the account with the specified number.
    // *
    // * @param acctNo The number of the searched account.
    // * @return The account with the specified account number, or <code>null</code>
    // * if there is no such account.
    // * @throws AccountException If unable to retrieve the account.
    // */
    // public AccountDTO getAccount(String acctNo) throws AccountException {
    // if (acctNo == null) {
    // return null;
    // }
    //
    // try {
    // return rentDb.findAccountByAcctNo(acctNo, false);
    // } catch (Exception e) {
    // throw new AccountException("Could not search for account.", e);
    // }
    // }

    /// **
    // * Deposits the specified amount to the account with the specified account
    // * number.
    // *
    // * @param acctNo The number of the account to which to deposit.
    // * @param amt The amount to deposit.
    // * @throws RejectedException If not allowed to deposit the specified amount.
    // * @throws AccountException If failed to deposit.
    // */
    // public void deposit(String acctNo, int amt) throws RejectedException,
    /// AccountException {
    // String failureMsg = "Could not deposit to account: " + acctNo;
    //
    // if (acctNo == null) {
    // throw new AccountException(failureMsg);
    // }
    //
    // try {
    // Account acct = rentDb.findAccountByAcctNo(acctNo, true);
    // acct.deposit(amt);
    // rentDb.updateAccount(acct);
    // } catch (BankDBException bdbe) {
    // throw new AccountException(failureMsg, bdbe);
    // } catch (Exception e) {
    // commitOngoingTransaction(failureMsg);
    // throw e;
    // }
    // }

    /// **
    // * Withdraws the specified amount from the account with the specified account
    // * number.
    // *
    // * @param acctNo The number of the account from which to withdraw.
    // * @param amt The amount to withdraw.
    // * @throws RejectedException If not allowed to withdraw the specified amount.
    // * @throws AccountException If failed to withdraw.
    // */
    // public void withdraw(String acctNo, int amt) throws RejectedException,
    /// AccountException {
    // String failureMsg = "Could not withdraw from account: " + acctNo;
    //
    // if (acctNo == null) {
    // throw new AccountException(failureMsg);
    // }
    //
    // try {
    // Account acct = rentDb.findAccountByAcctNo(acctNo, true);
    // acct.withdraw(amt);
    // rentDb.updateAccount(acct);
    // } catch (BankDBException bdbe) {
    // throw new AccountException(failureMsg, bdbe);
    // } catch (Exception e) {
    // commitOngoingTransaction(failureMsg);
    // throw e;
    // }
    // }

    private void commitOngoingTransaction(String failureMsg) throws AccountException {
        try {
            rentDb.commit();
        } catch (BankDBException bdbe) {
            throw new AccountException(failureMsg, bdbe);
        }
    }

    /**
     * Deletes the account with the specified account number.
     * 
     * @param acctNo The number of the account that shall be deleted.
     * @throws AccountException If failed to delete the specified account.
     */
    public void terminateLease(int leaseNo) throws AccountException {
        String failureMsg = "Could not terminate lease: " + leaseNo;

        if (leaseNo <= 0) {
            throw new AccountException(failureMsg);
        }
        // TODO: get instrumntNoByLease
        Lease ls = getLeaseForLeaseNo(leaseNo);
        try {
            int quota = rentDb.findQuotaByPK(ls.getLessee());
            // rentDb.changeInstrument(instrumentNo, false);
            rentDb.changeInstrument(ls.getInstrument(), false);
            rentDb.changeLessee(ls.getLessee(), quota + 1);
            rentDb.changeLease(leaseNo, false);
            commitOngoingTransaction(failureMsg);
        } catch (Exception e) {
            throw new AccountException(failureMsg, e);
        }
    }
}
