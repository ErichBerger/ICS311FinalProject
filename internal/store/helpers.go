package store

import (
    "database/sql"

    _ "github.com/go-sql-driver/mysql"
)

func NewStore(dsn *string) (*Store, error) {

    db, err := sql.Open("mysql", *dsn)

    if (err != nil) {
        return nil, err
    }
    
    err = db.Ping()

    if (err != nil) {
        return nil, err
        db.Close()
    }
    store := Store {DB : db}
    return &store, err

}
