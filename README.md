# MediCare Hospital Management System

## Overview
A comprehensive web-based Hospital Management System designed to digitize and streamline hospital operations. This application replaces traditional paper-based record-keeping with an efficient digital solution for managing OPD (Outpatient Department) operations.

## Description
This project addresses critical challenges in traditional hospital management systems:
- Eliminates paper-based record keeping
- Reduces administrative burden on doctors, receptionists, and administrators
- Provides secure, role-based access for different staff members
- Maintains comprehensive patient history accessible with a single click
- Generates digital prescriptions in PDF format

Built with enterprise-grade Java technologies, this system ensures platform independence, high performance, and robust security. The application leverages Spring MVC and Hibernate frameworks to deliver a scalable and maintainable solution.

## Key Features

### Administrator Module
- Add, edit, and remove employees (Doctors, Receptionists, Administrators)
- View all active employees in the system
- Complete system management and oversight

### Doctor Module
- Dedicated dashboard for each doctor
- Access complete patient visit history
- Generate digital prescriptions automatically
- Manage OPD queue efficiently
- Remove patients from queue after consultation

### Receptionist Module
- Register new patients with complete information
- Search patients by Name, Mobile Number, Patient ID, or Aadhar Number
- Modify patient personal details
- Print prescriptions for patients
- Manage OPD queue

## Technology Stack

### Backend
- **Spring MVC** (5.3.18) - Web application framework
- **Hibernate ORM** (5.4.8) - Object-relational mapping
- **Spring ORM** - Integration layer
- **Spring Transaction Management** - Database transaction handling
- **Java** - Core programming language

### Frontend
- **HTML5** - Structure
- **CSS3** - Styling
- **Bootstrap** - Responsive UI framework
- **JavaScript** - Client-side functionality
- **JSP** - Dynamic page rendering
- **JSTL** (1.2) - JSP Standard Tag Library

### Database
- **MySQL** (8.0.17) - Relational database
- **C3P0** (0.9.5.4) - JDBC connection pooling

### Security
- **BCrypt** - Password encryption using Blowfish cipher
- Role-based access control
- Secure session management

### Build & Deployment
- **Maven** - Dependency and build management
- **Apache Tomcat** - Application server
- **WAR** packaging

## Installation & Setup

### Prerequisites
1. **Java Development Kit (JDK)** - Version 8 or higher
2. **Eclipse IDE** for Java EE Developers
3. **Apache Tomcat** - Version 8 or higher
4. **MySQL Server** - Version 8.0 or higher
5. **MySQL Workbench** (optional but recommended)
6. **Maven** - For dependency management

### Setup Instructions

#### 1. Clone or Download the Project
```bash
git clone <your-repository-url>
```

#### 2. Import Project into Eclipse
- Open Eclipse IDE
- Go to `File` → `Import` → `Maven` → `Existing Maven Projects`
- Browse to the project directory and select it
- Click `Finish`

#### 3. Configure MySQL Database
- Open MySQL Workbench or MySQL Command Line
- Create a new database:
```sql
CREATE DATABASE medicare_hospital;
USE medicare_hospital;
```

- Run the SQL scripts located in `database/schema.sql` to create tables
- Run `database/initial_data.sql` to insert initial admin user

#### 4. Update Database Configuration
- Open `src/main/webapp/WEB-INF/springMVC-servlet.xml`
- Update the database connection properties:
```xml
<property name="jdbcUrl" value="jdbc:mysql://localhost:3306/medicare_hospital" />
<property name="user" value="your_mysql_username" />
<property name="password" value="your_mysql_password" />
```

#### 5. Build the Project
- Right-click on project → `Run As` → `Maven clean`
- Right-click on project → `Run As` → `Maven install`

#### 6. Deploy to Tomcat
- Right-click on project → `Run As` → `Run on Server`
- Select your Tomcat server
- Click `Finish`

#### 7. Access the Application
- Open your browser and navigate to: `http://localhost:8080/MediCareHMS/`
- Use the default admin credentials to login (see `database/credentials.txt`)

## Default Login Credentials

**Administrator:**
- Username: `admin`
- Password: `admin123`

**Note:** Change default passwords immediately after first login for security purposes.

## Database Schema

### Main Tables
- **login** - User authentication and role management
- **employee** - Staff information (doctors, receptionists, admins)
- **patient** - Patient records and personal information
- **opd** - OPD visit tracking
- **opddetails** - Prescription details (symptoms, diagnosis, medicines)
- **idgenerate** - Auto-increment ID management

## Project Structure
```
MediCareHMS/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── healthcare/
│       │           └── medicare/
│       │               ├── controller/    # MVC Controllers
│       │               ├── dao/           # Data Access Layer
│       │               ├── entity/        # Entity Models
│       │               └── service/       # Business Logic
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── view/                  # JSP Views
│           │   ├── springMVC-servlet.xml  # Spring Configuration
│           │   └── web.xml                # Web App Configuration
│           └── resources/                 # Static resources (CSS, JS, images)
├── database/                              # SQL scripts
├── pom.xml                                # Maven configuration
└── README.md
```

## Security Features
- **Password Encryption:** All passwords are encrypted using BCrypt hashing algorithm
- **Role-Based Access Control:** Different access levels for Admin, Doctor, and Receptionist
- **Session Management:** Secure session handling to prevent unauthorized access
- **SQL Injection Prevention:** Hibernate ORM protects against SQL injection attacks

## Problems Solved
✓ Eliminates paper-based record keeping  
✓ Prevents data loss and improves durability  
✓ Reduces time in data storage and retrieval  
✓ Eliminates handwriting issues in prescriptions  
✓ Minimizes human errors in record maintenance  
✓ Provides instant access to patient history  
✓ Automates prescription generation  

## Future Enhancements
- Mobile application for doctors and patients
- SMS/Email notifications for appointments
- Online appointment booking system
- Integration with pharmacy management
- Lab test result management
- Billing and invoice generation
- Patient portal for viewing medical history
- Analytics dashboard for hospital management

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contact
For any queries or support, please contact:
- Email: anjali.developer@gmail.com
- Project Repository: https://github.com/Anjali-1234-copilot/MediCare-Hospital-Management-System

## Acknowledgments
- Spring Framework Documentation
- Hibernate ORM Documentation
- Bootstrap Framework
- MySQL Community

---

**Developed with ❤️ for better healthcare management**
