# Vehicle Rental System - Database Design & SQL Queries

[**ERD URL**](https://lucid.app/lucidchart/5699b94e-20aa-4e27-b08c-e5162557de13/edit?viewport_loc=-813%2C-769%2C2217%2C1092%2C0_0&invitationId=inv_67dd27cb-fa37-4eb9-9a70-cf1a5d8e2f15)

  ---

### 🚘 Vehicles Table
- Vehicle name, type (car/bike/truck), model
- Registration number (must be unique)
- Rental price per day
- Availability status (available/rented/maintenance)

### 👤 Users Table
- User role (Admin or Customer)
- Name, email, password, phone number
- Each email must be unique (no duplicate accounts)

### 📅 Bookings Table
- Which user made the booking (link to Users table)
- Which vehicle was booked (link to Vehicles table)
- Start date and end date of rental
- Booking status (pending/confirmed/completed/cancelled)
- Total cost of the booking

  ---

## 🛠️ Technology Stack

**Backend**
- Node.js
- TypeScript
- Express.js

**Database**
- PostgreSQL

**Security**
- bcrypt (password hashing)
- jsonwebtoken (JWT authentication)

**Architecture**
- Modular
- Clean separation of concerns:
    - Routes
    - Controllers
    - Services
    - Middlewares
    - Database access layer


  ---


## ⚙️ Setup & Usage Instructions

Follow the steps below to set up and run the project locally.


### 🔧 Prerequisites

Make sure the following are installed on your system:

- Node.js (v24 or later recommended)
- npm
- PostgreSQL

### 📥 1. Clone the Repository
  ```
    git clone https://github.com/mynuddin62/NODE-EXPRESS-ASSIGNMENT-2-PROJECT
  ```

### 📦 2. Install Dependencies

  ``` 
  npm install
  ```
### 🔐 3. Environment Configuration

##### Create a .env file in the project root and configure the following variables:
  ```
  PORT=5000
  DATABASE_URL=postgresql://<username>:<password>@localhost:5432/vehicle_rental
  JWT_SECRET=your_secret_key
  ```

### ▶️ 4. Run the Application

##### Development Mode

  ```
  npm run dev
  ```

##### Production Mode

  ```
  npm run build
  npm start
  ```

### 🌐 API Endpoints


#### 🔐 Authentication

| Method | Endpoint | Access | Description |
  |------|--------|--------|------------|
| POST | `/api/v1/auth/signup` | Public | Register a new user account |
| POST | `/api/v1/auth/signin` | Public | Login and receive JWT token |

  ---

#### 🚘 Vehicles

| Method | Endpoint | Access | Description |
  |------|--------|--------|------------|
| POST | `/api/v1/vehicles` | Admin only | Add a new vehicle with name, type, registration number, daily rent price, and availability status |
| GET | `/api/v1/vehicles` | Public | View all vehicles in the system |
| GET | `/api/v1/vehicles/:vehicleId` | Public | View specific vehicle details |
| PUT | `/api/v1/vehicles/:vehicleId` | Admin only | Update vehicle details, daily rent price, or availability status |
| DELETE | `/api/v1/vehicles/:vehicleId` | Admin only | Delete a vehicle (only if no active bookings exist) |

  ---

#### 👤 Users

| Method | Endpoint | Access | Description |
  |------|--------|--------|------------|
| GET | `/api/v1/users` | Admin only | View all users in the system |
| PUT | `/api/v1/users/:userId` | Admin or Own | **Admin:** Update any user’s role or details<br>**Customer:** Update own profile only |
| DELETE | `/api/v1/users/:userId` | Admin only | Delete a user (only if no active bookings exist) |

  ---

#### 📅 Bookings

| Method | Endpoint | Access | Description |
  |------|--------|--------|------------|
| POST | `/api/v1/bookings` | Customer or Admin | Create a booking with start and end dates<br>• Validates vehicle availability<br>• Calculates total price (daily rate × duration)<br>• Updates vehicle status to **booked** |
| GET | `/api/v1/bookings` | Role-based | **Admin:** View all bookings<br>**Customer:** View own bookings only |
| PUT | `/api/v1/bookings/:bookingId` | Role-based | **Customer:** Cancel booking (before start date only)<br>**Admin:** Mark booking as **returned** (updates vehicle to **available**)<br>**System:** Auto-marks booking as **returned** when rental period ends |

---
