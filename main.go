package main

import (
    "os"
    "fmt"
    "log/slog"
    "github.com/ErichBerger/ICS311FinalProject/internal/store"
    "flag"
    "strings"
)

func main() {
    log := slog.New(slog.NewTextHandler(os.Stdout, nil))

    // set up command line flags
    u := flag.String("u", "store_admin", "Username for database.")
    p := flag.String("p", "123", "Password to use with user. Should change in database and not use the default here.")
    db := flag.String("db", "store", "Database name to use")
    flag.Parse()

    // Create dsn for the mysql driver
    dsn := strings.Join([]string{*u, ":", *p, "@/", *db, "?parseTime=True"}, "")

    s, err := store.NewStore(&dsn)
    if err != nil {
        log.Error(err.Error())
        os.Exit(1)
    }

    defer s.DB.Close()
    // Get wine list from database
    report1Info, err := s.Report1()

    if err != nil {
        log.Error(err.Error())
    }    
    report1(report1Info)
    // Get wine reorder info from database
    report2Info, err := s.Report2()

    if err != nil {
        log.Error(err.Error())
    }

    report2(report2Info)
  
    // Get id of customer to retrieve from database 
    var customer_number int 
    fmt.Println()
    fmt.Println("Enter a customer number: (valid range of 1-5)")
    fmt.Scanln(&customer_number)
    // Retrieve customer info from database with input
    report3Info, err := s.Report3(customer_number)

    if err != nil {
        log.Error(err.Error())
        os.Exit(1)
    }
    report3(report3Info)
}


