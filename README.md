# ICS 311 Final Project
## Spring 2024
## Erich Berger


Prerequisites to run:
- Go(https://go.dev/doc/install) installed 
- MySQL installed
- Editor for MySQL (can be run from command line)

Steps to run:
1. Download or clone this directory.
2. Open a terminal/shell
3. Navigate to the root folder /ICS311FinalProject 
If using Work Bench or another editor, run the store_creation.sql script and skip to step 7.
Otherwise, follow these steps (they assume you have a user account set up)
4. Type `mysql -u [user] -p` and press enter. This should bring you to MySQL
5. Type `source ./store_creation.sql;` and press enter.
6. Type `exit` and press enter to quit MySQL

7. From within the root folder, type `go run ./` on linux/mac. Powershell on windows should be able to use this syntax as well.

(Optional)
8. Instead of running, you can always type `go build` within the root folder, and then type `./ICS311FinalProject` to keep the compiled file.
