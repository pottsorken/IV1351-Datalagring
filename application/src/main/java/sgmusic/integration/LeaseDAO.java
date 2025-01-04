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

package sgmusic.integration;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sgmusic.model.Instrument;
import sgmusic.model.Lease;
import sgmusic.model.LeaseDTO;
import java.sql.DriverManager;
import java.sql.Connection;





/**
 * This data access object (DAO) encapsulates all database calls in the bank
 * application. No code outside this class shall have any knowledge about the
 * database.
 */
public class LeaseDAO {
    private static final String LESSEE_TABLE_NAME = "student";
    private static final String LESSEE_PK_COLUMN_NAME = "student_id";
    private static final String LESSEE_NAME_COLUMN_NAME = "name";
    private static final String LESSEE_QUOTA_COLUMN_NAME = "instrument_quota";

    private static final String LEASE_TABLE_NAME = "lease";
    private static final String LEASE_PK_COLUMN_NAME = "lease_id";
    private static final String LEASE_LESSEE_FK_COLUMN_NAME = "student_id";
    private static final String LEASE_INSTRUMENT_FK_COLUMN_NAME = "instrument_id";
    private static final String LEASE_ONGOING_COLUMN_NAME = "active";
    private static final String LEASE_COMPLETE_COLUMN_NAME = "done";
    private static final String LEASE_START_COLUMN_NAME = "start_of_lease";
    private static final String LEASE_END_COLUMN_NAME = "end_of_lease";

    private static final String LOOKUP_INSTRUMENT_TABLE_NAME = "lookup_instrument";
    private static final String LOOKUP_INSTRUMENT_PK_COLUMN_NAME = "instrument_type_id";
    private static final String LOOKUP_INSTRUMENT_COLUMN_NAME = "instrument_type";

    private static final String INSTRUMENT_TABLE_NAME = "instrument";
    private static final String INSTRUMENT_PK_COLUMN_NAME = "instrument_id";
    private static final String INSTRUMENT_PRICE_COLUMN_NAME = "lease_price";
    private static final String INSTRUMENT_ON_LEASE_COLUMN_NAME = "on_lease";
    private static final String INSTRUMENT_BRAND_COLUMN_NAME = "brand";
    private static final String INSTRUMENT_TYPE_FK_COLUMN_NAME = LOOKUP_INSTRUMENT_PK_COLUMN_NAME;

    // private static final String BALANCE_COLUMN_NAME = "balance";
    // private static final String HOLDER_FK_COLUMN_NAME = LESSEE_PK_COLUMN_NAME;

    private Connection connection;
    private PreparedStatement findAllInstrumentsStmt;
    private PreparedStatement findInstrumentsByTypeStmt;
    private PreparedStatement findAllLookupInstrumentsStmt;
    private PreparedStatement findAllStudentsStmt;
    private PreparedStatement findQuotaByStudentStmt;
    private PreparedStatement createLeaseStmt;
    private PreparedStatement changeLeaseStmt;
    private PreparedStatement findAllLeasesStmt;
    private PreparedStatement findLeasesByStudentStmt; 
    private PreparedStatement changeInstrumentStmt;
    private PreparedStatement changeStudentStmt;
    private PreparedStatement findLeaseByLeaseStmt;
    private PreparedStatement findInstrumentByNoStmt;


    /**
     * Constructs a new DAO object connected to the bank database.
     */
    public LeaseDAO() throws SGMusicException {
        try {
            connectToBankDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SGMusicException("Could not connect to datasource.", exception);
        }
    }

    /**
     * Creates a new lease.
     *
     * @param account The lease to create.
     * @throws SGMusicException If failed to create the specified account.
     */
    public void createLease(LeaseDTO lease) throws SGMusicException { // NOTE: LeaseDTO may be Lease
        String failureMsg = "Could not create the lease: " + lease;
        int updatedRows = 0;
        try {
            int lesseePK = lease.getLessee();
            if (lesseePK == 0) {
                handleException(failureMsg, null);
                // createHolderStmt.setString(1, account.getHolderName());
                // updatedRows = createHolderStmt.executeUpdate();
                // if (updatedRows != 1) {
                // handleException(failureMsg, null);
                // }
                // holderPK = findHolderPKByName(account.getHolderName());
            }

            createLeaseStmt.setInt(1, lease.getInstrument());
            createLeaseStmt.setInt(2, lease.getLessee());
            updatedRows = createLeaseStmt.executeUpdate();
            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }

            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }

    /**
     * Searches for all accounts whose holder has the specified name.
     *
     * @param holderName The account holder's name
     * @return A list with all accounts whose holder has the specified name,
     *         the list is empty if there are no such account.
     * @throws SGMusicException If failed to search for accounts.
     */
    public List<Lease> findLeasesByLessee(int lesseeNo) throws SGMusicException {
        String failureMsg = "Could not search for specified leases.";
        ResultSet result = null;
        List<Lease> leases = new ArrayList<>();
        try {
            findLeasesByStudentStmt.setInt(1, lesseeNo);
            result = findLeasesByStudentStmt.executeQuery();
            while (result.next()) {
                leases.add(new Lease(result.getInt(LEASE_PK_COLUMN_NAME), result.getInt(LEASE_LESSEE_FK_COLUMN_NAME),
                        result.getInt(LEASE_INSTRUMENT_FK_COLUMN_NAME), result.getBoolean(LEASE_ONGOING_COLUMN_NAME)));
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return leases;
    }

        /**
     * Searches for all accounts whose holder has the specified name.
     *
     * @param holderName The account holder's name
     * @return A list with all accounts whose holder has the specified name,
     *         the list is empty if there are no such account.
     * @throws SGMusicException If failed to search for accounts.
     */
    public Lease findLeaseByLease(int leaseNo) throws SGMusicException {
        String failureMsg = "Could not search for specified lease.";
        ResultSet result = null;
        Lease leases = null;
        try {
            findLeaseByLeaseStmt.setInt(1, leaseNo);
            result = findLeaseByLeaseStmt.executeQuery();
            while (result.next()) {
                leases = new Lease(result.getInt(LEASE_PK_COLUMN_NAME), result.getInt(LEASE_LESSEE_FK_COLUMN_NAME),
                        result.getInt(LEASE_INSTRUMENT_FK_COLUMN_NAME), result.getBoolean(LEASE_ONGOING_COLUMN_NAME));
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return leases;
    }

    /**
     * Retrieves all existing leases.
     *
     * @return A list with all existing leases. The list is empty if there are no
     *         accounts.
     * @throws SGMusicException If failed to search for leases.
     */
    public List<Lease> findAllLeases() throws SGMusicException {
        String failureMsg = "Could not list leases.";
        List<Lease> leases = new ArrayList<>();
        try (ResultSet result = findAllLeasesStmt.executeQuery()) {
            while (result.next()) {
                // lessee no, instrument no
                leases.add(new Lease(result.getInt(LEASE_PK_COLUMN_NAME), result.getInt(LEASE_LESSEE_FK_COLUMN_NAME),
                        result.getInt(LEASE_INSTRUMENT_FK_COLUMN_NAME), result.getBoolean(LEASE_ONGOING_COLUMN_NAME)));
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return leases;
    }

    /**
     * Changes the lease with the specified lease number.
     *
     * @param leaseNo The lease to change.
     * @param active  The state to change lease to.
     * @throws SGMusicException If unable to delete the specified account.
     */
    public void changeLease(int leaseNo, boolean active) throws SGMusicException {
        String failureMsg = "Could not change lease: " + leaseNo;
        try {
            changeLeaseStmt.setBoolean(1, active);
            changeLeaseStmt.setInt(2, leaseNo);
            int updatedRows = changeLeaseStmt.executeUpdate();
            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }    
    /**
    * Changes the student with the specified student number.
    *
    * @param studentNo The student to change.
    * @param newQuota  The quota to change to.
    * @throws SGMusicException If unable to delete the specified account.
    */
   public void changeLessee(int studentNo, int newQuota) throws SGMusicException {
       String failureMsg = "Could not change student: " + studentNo;
       try {
            changeStudentStmt.setInt(1, newQuota);
            changeStudentStmt.setInt(2, studentNo);
            int updatedRows = changeStudentStmt.executeUpdate();
            if (updatedRows != 1) {
               handleException(failureMsg, null);
            }
            // NOTE: May be removed when editing transactions
            //connection.commit();
       } catch (SQLException sqle) {
           handleException(failureMsg, sqle);
       }
   }

    /**
     * Changes the instrument with the specified lease number.
     *
     * @param instrumentNo The instrument to change.
     * @param onLease      The state to change instrument to.
     * @throws SGMusicException If unable to change the specified account.
     */
    public void changeInstrument(int instrumentNo, boolean onLease) throws SGMusicException {
        String failureMsg = "Could not change instrument: " + instrumentNo;
        try {
            changeInstrumentStmt.setBoolean(1, onLease);
            changeInstrumentStmt.setInt(2, instrumentNo);
            int updatedRows = changeInstrumentStmt.executeUpdate();
            if (updatedRows != 1) {
                handleException(failureMsg, null);
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
    }

    /**
     * Retrieves all existing instruments.
     *
     * @return A list with all existing instruments. The list is empty if there are
     *         no
     *         instruments.
     * @throws SGMusicException If failed to search for instruments.
     */
    public List<Instrument> findAllInstruments() throws SGMusicException {
        String failureMsg = "Could not list instruments.";
        List<Instrument> instruments = new ArrayList<>();
        try (ResultSet result = findAllInstrumentsStmt.executeQuery()) {
            while (result.next()) {
                instruments.add(new Instrument(result.getInt(INSTRUMENT_PK_COLUMN_NAME),
                        result.getString(LOOKUP_INSTRUMENT_COLUMN_NAME), result.getString(INSTRUMENT_BRAND_COLUMN_NAME),
                        result.getInt(INSTRUMENT_PRICE_COLUMN_NAME)));
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        }
        return instruments;
    }


    /**
     * Searches for all instruments whose type has the specified type id.
     *
     * @param typeNo The instruments's type number
     * @return A list with all instruments whose type has the specified id,
     *         the list is empty if there are no such account.
     * @throws SGMusicException If failed to search for instruments.
     */
    public Instrument findInstrumentById(int instrumentNo) throws SGMusicException {
        String failureMsg = "Could not search for specified instrument.";
        ResultSet result = null;
        Instrument instr = null;
        try {
            findInstrumentByNoStmt.setInt(1, instrumentNo);
            result = findInstrumentByNoStmt.executeQuery();
            while (result.next()) {
                instr = new Instrument(result.getInt(INSTRUMENT_PK_COLUMN_NAME),
                        result.getString(LOOKUP_INSTRUMENT_COLUMN_NAME), result.getString(INSTRUMENT_BRAND_COLUMN_NAME),
                        result.getInt(INSTRUMENT_PRICE_COLUMN_NAME), result.getBoolean(INSTRUMENT_ON_LEASE_COLUMN_NAME) );
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return instr;
    }

    /**
     * Searches for all instruments whose type has the specified type id.
     *
     * @param typeNo The instruments's type number
     * @return A list with all instruments whose type has the specified id,
     *         the list is empty if there are no such account.
     * @throws SGMusicException If failed to search for instruments.
     */
    public List<Instrument> findInstrumentsByType(String typeName) throws SGMusicException {
        String failureMsg = "Could not search for specified instruments.";
        ResultSet result = null;
        List<Instrument> instruments = new ArrayList<>();
        String formattedType = typeName.substring(0, 1).toUpperCase() + typeName.substring(1).toLowerCase();
        System.out.println(formattedType);
        try {
            findInstrumentsByTypeStmt.setString(1, formattedType);
            result = findInstrumentsByTypeStmt.executeQuery();
            while (result.next()) {
                instruments.add(new Instrument(result.getInt(INSTRUMENT_PK_COLUMN_NAME),
                        result.getString(LOOKUP_INSTRUMENT_COLUMN_NAME), result.getString(INSTRUMENT_BRAND_COLUMN_NAME),
                        result.getInt(INSTRUMENT_PRICE_COLUMN_NAME)));
            }
            //connection.commit();
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return instruments;
    }

    /**
     * Commits the current transaction.
     * 
     * @throws SGMusicException If unable to commit the current transaction.
     */
    public void commit() throws SGMusicException {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    // TODO: change name of method
    private void connectToBankDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgoodmusic",
                "broli", "12345");
        // connection =
        // DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb",
        // "mysql", "mysql");
        connection.setAutoCommit(false);
    }

    private void prepareStatements() throws SQLException {
        findAllStudentsStmt = connection.prepareStatement(
                "SELECT s." + LESSEE_NAME_COLUMN_NAME + ", s." + LESSEE_QUOTA_COLUMN_NAME + ", s."
                        + LESSEE_PK_COLUMN_NAME
                        + "FROM " + LESSEE_TABLE_NAME + " AS s");

        findAllInstrumentsStmt = connection.prepareStatement("SELECT i." + INSTRUMENT_PK_COLUMN_NAME + ", t."
                + LOOKUP_INSTRUMENT_COLUMN_NAME + ", i." + INSTRUMENT_BRAND_COLUMN_NAME + ", i."
                + INSTRUMENT_PRICE_COLUMN_NAME + " FROM " + INSTRUMENT_TABLE_NAME + " AS i INNER JOIN "
                + LOOKUP_INSTRUMENT_TABLE_NAME + " AS t ON t." + LOOKUP_INSTRUMENT_PK_COLUMN_NAME + " = i."
                + INSTRUMENT_TYPE_FK_COLUMN_NAME + " WHERE i." + INSTRUMENT_ON_LEASE_COLUMN_NAME + " = FALSE");

        findInstrumentsByTypeStmt = connection.prepareStatement("SELECT i." + INSTRUMENT_PK_COLUMN_NAME + ", t."
                + LOOKUP_INSTRUMENT_COLUMN_NAME + ", i." + INSTRUMENT_BRAND_COLUMN_NAME + ", i."
                + INSTRUMENT_PRICE_COLUMN_NAME + " FROM " + INSTRUMENT_TABLE_NAME + " AS i INNER JOIN "
                + LOOKUP_INSTRUMENT_TABLE_NAME + " AS t ON t." + LOOKUP_INSTRUMENT_PK_COLUMN_NAME + " = i."
                + INSTRUMENT_TYPE_FK_COLUMN_NAME + " WHERE i." + INSTRUMENT_ON_LEASE_COLUMN_NAME
                + " = FALSE AND t." + LOOKUP_INSTRUMENT_COLUMN_NAME + " = ?");

        findInstrumentByNoStmt = connection.prepareStatement("SELECT i." + INSTRUMENT_PK_COLUMN_NAME + ", t."
                + LOOKUP_INSTRUMENT_COLUMN_NAME + ", i." + INSTRUMENT_BRAND_COLUMN_NAME + ", i."
                + INSTRUMENT_PRICE_COLUMN_NAME + ", i." + INSTRUMENT_ON_LEASE_COLUMN_NAME + " FROM " + INSTRUMENT_TABLE_NAME + " AS i INNER JOIN "
                + LOOKUP_INSTRUMENT_TABLE_NAME + " AS t ON t." + LOOKUP_INSTRUMENT_PK_COLUMN_NAME + " = i."
                + INSTRUMENT_TYPE_FK_COLUMN_NAME + " WHERE i." + INSTRUMENT_PK_COLUMN_NAME
                + " = ?");

        //
        findAllLookupInstrumentsStmt = connection.prepareStatement(
                "SELECT l." + LOOKUP_INSTRUMENT_COLUMN_NAME + " FROM " + LOOKUP_INSTRUMENT_TABLE_NAME + " AS l");

        findQuotaByStudentStmt = connection.prepareStatement("SELECT s." + LESSEE_QUOTA_COLUMN_NAME + " FROM "
                + LESSEE_TABLE_NAME + " AS s WHERE s." + LESSEE_PK_COLUMN_NAME + " = ?");

        findAllLeasesStmt = connection
                .prepareStatement(
                        "SELECT l." + LEASE_PK_COLUMN_NAME + ", l." + LEASE_LESSEE_FK_COLUMN_NAME + ", l."
                                + LEASE_ONGOING_COLUMN_NAME + ", l." + LEASE_COMPLETE_COLUMN_NAME + ", l."
                                + LEASE_START_COLUMN_NAME + ", l." + LEASE_END_COLUMN_NAME + ", l."
                                + LEASE_INSTRUMENT_FK_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME
                                + " AS l");

        findLeasesByStudentStmt = connection
                .prepareStatement(
                        "SELECT l." + LEASE_PK_COLUMN_NAME + ", l." + LEASE_LESSEE_FK_COLUMN_NAME + ", l."
                                + LEASE_ONGOING_COLUMN_NAME + ", l." + LEASE_COMPLETE_COLUMN_NAME + ", l."
                                + LEASE_START_COLUMN_NAME + ", l." + LEASE_END_COLUMN_NAME + ", l."
                                + LEASE_INSTRUMENT_FK_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME
                                + " AS l WHERE l." + LEASE_LESSEE_FK_COLUMN_NAME + " = ?");

        
        findLeaseByLeaseStmt = connection
                .prepareStatement(
                        "SELECT l." + LEASE_PK_COLUMN_NAME + ", l." + LEASE_LESSEE_FK_COLUMN_NAME + ", l."
                                + LEASE_ONGOING_COLUMN_NAME + ", l." + LEASE_COMPLETE_COLUMN_NAME + ", l."
                                + LEASE_START_COLUMN_NAME + ", l." + LEASE_END_COLUMN_NAME + ", l."
                                + LEASE_INSTRUMENT_FK_COLUMN_NAME + " FROM " + LEASE_TABLE_NAME
                                + " AS l WHERE l." + LEASE_PK_COLUMN_NAME + " = ?");


        createLeaseStmt = connection.prepareStatement("INSERT INTO " + LEASE_TABLE_NAME + "("
                + LEASE_ONGOING_COLUMN_NAME + ", " + LEASE_COMPLETE_COLUMN_NAME + ", " + LEASE_START_COLUMN_NAME + ", "
                + LEASE_INSTRUMENT_FK_COLUMN_NAME + ", " + LEASE_LESSEE_FK_COLUMN_NAME
                + ") VALUES (TRUE, FALSE, CURRENT_DATE, ?, ?)");

        changeLeaseStmt = connection.prepareStatement("UPDATE " + LEASE_TABLE_NAME + " SET " + LEASE_ONGOING_COLUMN_NAME
                + " = ? WHERE " + LEASE_PK_COLUMN_NAME + " = ?");

        changeInstrumentStmt = connection.prepareStatement("UPDATE " + INSTRUMENT_TABLE_NAME + " SET "
                + INSTRUMENT_ON_LEASE_COLUMN_NAME + " = ? WHERE " + INSTRUMENT_PK_COLUMN_NAME + " = ?");

        changeStudentStmt = connection.prepareStatement("UPDATE " + LESSEE_TABLE_NAME + " SET " + 
                    LESSEE_QUOTA_COLUMN_NAME + " = ? WHERE " + LESSEE_PK_COLUMN_NAME + " = ?");

        // NOTE : Prepared statements should be finished
        // TODO : No! need to to find instrumentbyleaseNo
        //
        // createHolderStmt = connection.prepareStatement("INSERT INTO " +
        // LESSEE_TABLE_NAME
        // + "(" + LESSEE_COLUMN_NAME + ") VALUES (?)");
        //
        // createAccountStmt = connection.prepareStatement("INSERT INTO " +
        // LEASE_TABLE_NAME
        // + "(" + LEASE_ID_COLUMN_NAME + ", " + BALANCE_COLUMN_NAME + ", "
        // + HOLDER_FK_COLUMN_NAME + ") VALUES (?, ?, ?)");
        //
        // findHolderPKStmt = connection.prepareStatement("SELECT " +
        // LESSEE_PK_COLUMN_NAME
        // + " FROM " + LESSEE_TABLE_NAME + " WHERE " + LESSEE_COLUMN_NAME + " = ?");
        //
        // findAccountByAcctNoStmt = connection.prepareStatement("SELECT a." +
        // LEASE_ID_COLUMN_NAME
        // + ", a." + BALANCE_COLUMN_NAME + ", h." + LESSEE_COLUMN_NAME + " from "
        // + LEASE_TABLE_NAME + " a INNER JOIN " + LESSEE_TABLE_NAME + " h USING ("
        // + LESSEE_PK_COLUMN_NAME + ") WHERE a." + LEASE_ID_COLUMN_NAME + " = ?");
        //
        // findAccountByAcctNoStmtLockingForUpdate = connection.prepareStatement("SELECT
        // a."
        // + LEASE_ID_COLUMN_NAME + ", a." + BALANCE_COLUMN_NAME + ", h."
        // + LESSEE_COLUMN_NAME + " from " + LEASE_TABLE_NAME + " a INNER JOIN "
        // + LESSEE_TABLE_NAME + " h USING (" + LESSEE_PK_COLUMN_NAME + ") WHERE a."
        // + LEASE_ID_COLUMN_NAME + " = ? FOR NO KEY UPDATE");
        //
        // findAccountByNameStmt = connection.prepareStatement("SELECT a." +
        // LEASE_ID_COLUMN_NAME
        // + ", a." + BALANCE_COLUMN_NAME + ", h." + LESSEE_COLUMN_NAME + " from "
        // + LEASE_TABLE_NAME + " a INNER JOIN "
        // + LESSEE_TABLE_NAME + " h ON a." + HOLDER_FK_COLUMN_NAME
        // + " = h." + LESSEE_PK_COLUMN_NAME + " WHERE h." + LESSEE_COLUMN_NAME + " =
        // ?");
        //
        // findAllAccountsStmt = connection.prepareStatement("SELECT h." +
        // LESSEE_COLUMN_NAME
        // + ", a." + LEASE_ID_COLUMN_NAME + ", a." + BALANCE_COLUMN_NAME + " FROM "
        // + LESSEE_TABLE_NAME + " h INNER JOIN " + LEASE_TABLE_NAME + " a ON a."
        // + HOLDER_FK_COLUMN_NAME + " = h." + LESSEE_PK_COLUMN_NAME);
        //
        // changeBalanceStmt = connection.prepareStatement("UPDATE " + LEASE_TABLE_NAME
        // + " SET " + BALANCE_COLUMN_NAME + " = ? WHERE " + LEASE_ID_COLUMN_NAME + " =
        // ? ");
        //
        // deleteAccountStmt = connection.prepareStatement("DELETE FROM " +
        // LEASE_TABLE_NAME
        // + " WHERE " + LEASE_ID_COLUMN_NAME + " = ?");
    }

    private void handleException(String failureMsg, Exception cause) throws SGMusicException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SGMusicException(failureMsg, cause);
        } else {
            throw new SGMusicException(failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws SGMusicException {
        try {
            result.close();
        } catch (Exception e) {
            throw new SGMusicException(failureMsg + " Could not close result set.", e);
        }
    }

    // private int createAccountNo() {
    // return (int) Math.floor(Math.random() * Integer.MAX_VALUE);
    // }

    public int findQuotaByPK(int lesseeNo) throws SQLException {
        ResultSet result = null;
        findQuotaByStudentStmt.setInt(1, lesseeNo);
        result = findQuotaByStudentStmt.executeQuery();
        if (result.next()) {
            return result.getInt(LESSEE_QUOTA_COLUMN_NAME);
        }
        // NOTE: This method does not commit transaction on its own.
        return 0;
    }
}
