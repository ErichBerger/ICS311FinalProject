package main
import (
    "github.com/ErichBerger/ICS311FinalProject/internal/store"
    "fmt"
    "strings"
    "time"
)

func report1(w []store.Wine) {
    fmt.Println("Student Name: Erich Berger")
    fmt.Println("Report 1: Wine List")
    fmt.Println("Today's date is", time.Now().Format("2006-01-02"))
    fmt.Printf("%-6s %-7s %-30s %-7s %-3s\n", "Number", "Barcode", "Name", "Price", "Inv")
    fmt.Printf("------ ------- ----                           -----   ---\n")
    for _, wine := range w {
        fmt.Printf("%-6d %-7d %-30s %-4.2f %3d\n", wine.Stock_number, wine.Barcode, wine.Name, wine.Price, wine.Inv)
    }
}

func report2(o []store.Order) {
    fmt.Println()
    fmt.Println("Student Name: Erich Berger")
    fmt.Println("Report 2: Reorder Quantities")
    
    fmt.Println("Today's date is", time.Now().Format("2006-01-02"))
    fmt.Printf("%-30s %-7s %-20s\n", "Name", "Amount", "Vendor")
    fmt.Printf("----                           ------  ------\n")
    for _, order := range o {
        fmt.Printf("%-30s %-7d %-20s\n", order.Name, order.Amount, order.Vendor)
    }
}

func report3(c store.Customer) {
    fmt.Println()
    fmt.Println("Student Name: Erich Berger")
    fmt.Println("Report 3: Find Customer")
    fmt.Println("Today's date is", time.Now().Format("2006-01-02"))
    fmt.Printf("%-6s %-30s %-14s %-30s\n", "Number", "Name", "Phone", "Address")
    fmt.Printf("------ ----                           -----          -------\n")
    fmt.Printf("%-6d %-30s %-14s %-30s\n", c.Number, strings.Join([]string{c.Fname, c.Lname}, " "), c.Phone, c.Address)
}
