# A layered JDBC application for the soundgoodmusic database

This is an application for the soundgoodmusic database as a part of the KTH course iv1351.

## How to execute

1. Clone this git repository
1. Change to the newly created subdirectory `cd IV1351-Datalagring/sql`
1. Log in to postgres user and execute `\i setup_database.sql`
1. Make sure that user exist for postgres that is not the default postgres user that also has a password.
1. Change the login credentials in file `IV1351-Datalagring/application/src/main/java/sgmusic/integration/LeaseDAO.java Line 367` to match psql user.
1. Navigate back to `IV1351-Datalagring/application`
1. Build the project with the command `mvn install`
1. Run the program with the command `mvn exec:java`

## Commands for the soundgoodmusic application

* `help` displays all commands.
* `rent <Student ID> <Instrument ID>` creates a new account owned by the specified holder.
* `listlease` lists all existing leases.
* `listlease <Student ID>` lists all leases owned by the specified student.
* `listinstr` lists all available instruments
* `listinstr <Instrument type as string>` lists all available instruments of that type. ('guitar', 'piano', ...)
* `terminate <Lease ID>` terminate the lease with the specified number.
* `quit` quits the application.
