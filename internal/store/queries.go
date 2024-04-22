package store

func (s *Store) Test() int {
    return 1
}

func (s *Store) Report1() ([]Wine, error){
    stmt := "select stock_number, barcode, name, price, inv from Wine;"
    rows, err := s.DB.Query(stmt)
    if err != nil{
        return nil, err
    }

    defer rows.Close()

    var wines []Wine

    for rows.Next() {
        var w Wine
        err = rows.Scan(&w.Stock_number, &w.Barcode, &w.Name, &w.Price, &w.Inv)
        if err != nil {
            return nil, err
        }

        wines = append(wines, w)
    }

    if err = rows.Err(); err != nil {
        return nil, err
    }

    return wines, nil
}

func (s *Store) Report2() ([]Order, error) {
    stmt := `
select Wine.name as 'Wine Name', Wine.min_qty - Wine.inv as Amount, Vendor.name as Vendor
    from Wine left join InvoiceLine on Wine.stock_number = InvoiceLine.stock_number
        left join Invoice on InvoiceLine.invoice_number = Invoice.invoice_number
        left join Vendor on Invoice.vendor_number = Vendor.vendor_number
    where Wine.inv < Wine.min_qty;`

    rows, err := s.DB.Query(stmt)
    if err != nil {
        return nil, err
    }
    defer rows.Close()
    var orders []Order
    for rows.Next() {
        var o Order
        err = rows.Scan(&o.Name, &o.Amount, &o.Vendor)
        if err != nil {
            return nil, err
        }
        orders = append(orders, o)
    }

    if err = rows.Err(); err != nil {
        return nil, err
    }

    return orders, nil
}

func (s *Store) Report3(cn int) (Customer, error) {
    stmt := "select customer_number, fname, lname, phone, address from Customer where customer_number = ?"
    var c Customer
    row := s.DB.QueryRow(stmt, cn)
    err := row.Scan(&c.Number, &c.Fname, &c.Lname, &c.Phone, &c.Address)

    if err != nil {
        return Customer{}, err
    }
    
    return c, nil 
}
