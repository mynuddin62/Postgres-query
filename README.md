# Vehicle Rental System - Database Design & SQL Queries

[**ERD**](https://lucid.app/lucidchart/5699b94e-20aa-4e27-b08c-e5162557de13/edit?viewport_loc=-813%2C-769%2C2217%2C1092%2C0_0&invitationId=inv_67dd27cb-fa37-4eb9-9a70-cf1a5d8e2f15)

  ---

### 👤 Users Table
- User role (Admin or Customer)
- Name, email, password, phone number
- Each email must be unique (no duplicate accounts)

### 🚘 Vehicles Table
- Vehicle name, type (car/bike/truck), model
- Registration number (must be unique)
- Rental price per day
- Availability status (available/rented/maintenance)

### 📅 Bookings Table
- Which user made the booking (link to Users table)
- Which vehicle was booked (link to Vehicles table)
- Start date and end date of rental
- Booking status (pending/confirmed/completed/cancelled)
- Total cost of the booking

  ---

## Sample Data (Input)

### Users Table
| user_id | name | email | phone | role |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Alice | alice@example.com | 1234567890 | Customer |
| 2 | Bob | bob@example.com | 0987654321 | Admin |
| 3 | Charlie | charlie@example.com | 1122334455 | Customer |

### Vehicles Table
| vehicle_id | name | type | model | registration_number | rental_price | status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Toyota Corolla | car | 2022 | ABC-123 | 50 | available |
| 2 | Honda Civic | car | 2021 | DEF-456 | 60 | rented |
| 3 | Yamaha R15 | bike | 2023 | GHI-789 | 30 | available |
| 4 | Ford F-150 | truck | 2020 | JKL-012 | 100 | maintenance |

### Bookings Table
| booking_id | user_id | vehicle_id | start_date | end_date | status | total_cost |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 1 | 2 | 2023-10-01 | 2023-10-05 | completed | 240 |
| 2 | 1 | 2 | 2023-11-01 | 2023-11-03 | completed | 120 |
| 3 | 3 | 2 | 2023-12-01 | 2023-12-02 | confirmed | 60 |
| 4 | 1 | 1 | 2023-12-10 | 2023-12-12 | pending | 100 |

---


### Query 1: JOIN
**Requirement**: Retrieve booking information along with Customer name and Vehicle name.

```
    SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
    FROM bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id
    ORDER BY b.booking_id
```

**Output**:
| booking_id | customer_name | vehicle_name | start_date | end_date | status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Alice | Honda Civic | 2023-10-01 | 2023-10-05 | completed |
| 2 | Alice | Honda Civic | 2023-11-01 | 2023-11-03 | completed |
| 3 | Charlie | Honda Civic | 2023-12-01 | 2023-12-02 | confirmed |
| 4 | Alice | Toyota Corolla | 2023-12-10 | 2023-12-12 | pending |

---


### Query 2: EXISTS
**Requirement**: Find all vehicles that have never been booked.

```
    SELECT v.*
    FROM vehicles v
    WHERE NOT EXISTS (
        SELECT b.booking_id
        FROM bookings b
        WHERE b.vehicle_id = v.vehicle_id
    )
    ORDER BY v.vehicle_id
```

**Output**:
| vehicle_id | name | type | model | registration_number | rental_price | status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 3 | Yamaha R15 | bike | 2023 | GHI-789 | 30 | available |
| 4 | Ford F-150 | truck | 2020 | JKL-012 | 100 | maintenance |

---

### Query 3: WHERE
**Requirement**: Retrieve all available vehicles of a specific type (e.g. cars).

```
    SELECT *
    FROM vehicles
    WHERE status = 'available' AND type = :type_name
    ORDER BY vehicle_id
```

**Output**:
| vehicle_id | name | type | model | registration_number | rental_price | status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Toyota Corolla | car | 2022 | ABC-123 | 50 | available |

---

### Query 4: GROUP BY and HAVING
**Requirement**: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

```
    SELECT v.name vehicle_name, COUNT(b.booking_id) total_bookings
    FROM bookings b
    INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id
    GROUP BY v.name
    HAVING COUNT(b.booking_id) > 2
```

**Output**:
| vehicle_name | total_bookings |
| :--- | :--- |
| Honda Civic | 3 |