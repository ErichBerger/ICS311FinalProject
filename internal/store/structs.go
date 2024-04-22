package store

import (
    "database/sql"
)

type Store struct {
    DB *sql.DB
}

type Customer struct {
    Number int
    Fname string
    Lname string
    Phone string
    Address string
}

type Wine struct {
    Stock_number int
    Barcode int
    Name string
    Price float64
    Inv int
}

type Order struct {
    Name string
    Amount int
    Vendor string
}
