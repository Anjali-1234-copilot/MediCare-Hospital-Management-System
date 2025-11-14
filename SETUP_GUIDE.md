# MediCare HMS - Complete Setup Guide

This guide will walk you through setting up the MediCare Hospital Management System on your local machine.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Software Installation](#software-installation)
3. [Project Setup](#project-setup)
4. [Database Configuration](#database-configuration)
5. [Running the Application](#running-the-application)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you begin, ensure you have:
- Windows/Linux/Mac operating system
- At least 4GB RAM
- 2GB free disk space
- Internet connection for downloading dependencies

---

## Software Installation

### 1. Install Java Development Kit (JDK)

**Download:**
- Visit: https://www.oracle.com/java/technologies/downloads/
- Download JDK 8 or higher (JDK 11 recommended)

**Installation:**
- Run the installer
- Note the installation path (e.g., `C:\Program Files\Java\jdk-11`)

**Set JAVA_HOME:**

**Windows:**
```cmd
setx JAVA_HOME "C:\Program Files\Java\jdk-11"
setx PATH "%PATH%;%JAVA_HOME%\bin"
```

**Linux/Mac:**
```bash
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$PATH:$JAVA_HOME/bin
```

**Verify:**
```bash
java -version
```

### 2. Install Apache Maven

**Download:**
- Visit: https://maven.apache.org/download.cgi
- Download the binary zip archive

**Installation:**
- Extract to a folder (e.g., `C:\Program Files\Apache\maven`)

**Set MAVEN_HOME:**

**Windows:**
```cmd
setx MAVEN_HOME "C:\Program Files\Apache\maven"
setx PATH "%PATH%;%MAVEN_HOME%\bin"
```

**Linux/Mac:**
```bash
export MAVEN_HOME=/opt/maven
export PATH=$PATH:$MAVEN_HOME/bin
```

**Verify:**
```bash
mvn -version
```

### 3. Install MySQL Server

**Download:**
- Visit: https://dev.mysql.com/downloads/mysql/
- Download MySQL Community Server 8.0

**Installation:**
- Run the installer
- Choose "Developer Default" setup type
- Set root password (remember this!)
- Complete the installation

**Verify:**
```bash
mysql --version
```

### 4. Install MySQL Workbench (Optional but Recommended)

**Download:**
- Visit: https://dev.mysql.com/downloads/workbench/
- Download and install

### 5. Install Eclipse IDE

**Download:**
- Visit: https://www.eclipse.org/downloads/
- Download "Eclipse IDE for Enterprise Java and Web Developers"

**Installation:**
- Extract and run the installer
- Choose workspace location

### 6. Install Apache Tomcat

**Download:**
- Visit: https://tomcat.apache.org/download-90.cgi
- Download Tomcat 9.0 (Core - zip)

**Installation:**
- Extract to a folder (e.g., `C:\Program Files\Apache\Tomcat`)

---

## Project Setup

### Step 1: Get the Project

**Option A: Clone from Git**
```bash
git clone <your-repository-url>
cd MediCareHMS
```

**Option B: Download ZIP**
- Download the project ZIP file
- Extract to your desired location

### Step 2: Import into Eclipse

1. Open Eclipse IDE
2. Go to `File` → `Import`
3. Select `Maven` → `Existing Maven Projects`
4. Click `Next`
5. Browse to your project directory
6. Select the project (pom.xml should be detected)
7. Click `Finish`

### Step 3: Configure Tomcat in Eclipse

1. Go to `Window` → `Preferences`
2. Navigate to `Server` → `Runtime Environments`
3. Click `Add`
4. Select `Apache Tomcat v9.0`
5. Browse to your Tomcat installation directory
6. Click `Finish`

---

## Database Configuration

### Step 1: Create Database

**Option A: Using MySQL Workbench**
1. Open MySQL Workbench
2. Connect to your local MySQL server
3. Open the file `database/schema.sql`
4. Execute the script (Lightning bolt icon)
5. Open the file `database/initial_data.sql`
6. Execute the script

**Option B: Using Command Line**
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p < database/initial_data.sql
```

### Step 2: Update Database Credentials

1. Open `src/main/webapp/WEB-INF/springMVC-servlet.xml`
2. Locate the database configuration section:

```xml
<property name="jdbcUrl" value="jdbc:mysql://localhost:3306/medicare_hospital" />
<property name="user" value="root" />
<property name="password" value="YOUR_MYSQL_PASSWORD" />
```

3. Update the `password` property with your MySQL root password
4. Save the file

### Step 3: Verify Database Setup

```sql
USE medicare_hospital;
SHOW TABLES;
SELECT * FROM login;
```

You should see the default admin user.

---

## Running the Application

### Step 1: Build the Project

**In Eclipse:**
1. Right-click on project
2. Select `Run As` → `Maven clean`
3. Wait for completion
4. Right-click on project again
5. Select `Run As` → `Maven install`

**Command Line:**
```bash
mvn clean install
```

### Step 2: Deploy to Tomcat

**In Eclipse:**
1. Right-click on project
2. Select `Run As` → `Run on Server`
3. Choose your Tomcat server
4. Click `Finish`

The application will start deploying...

### Step 3: Access the Application

1. Open your web browser
2. Navigate to: `http://localhost:8080/MediCareHMS/`
3. You should see the login page

### Step 4: Login

**Default Administrator Credentials:**
- Username: `admin`
- Password: `admin123`

---

## Troubleshooting

### Issue: Port 8080 Already in Use

**Solution:**
```bash
# Find process using port 8080
netstat -ano | findstr :8080

# Kill the process (Windows)
taskkill /PID <process_id> /F

# Kill the process (Linux/Mac)
kill -9 <process_id>
```

### Issue: Database Connection Failed

**Check:**
1. MySQL service is running
2. Database credentials are correct in `springMVC-servlet.xml`
3. Database `medicare_hospital` exists
4. Firewall is not blocking port 3306

**Verify MySQL is running:**
```bash
# Windows
net start MySQL80

# Linux
sudo systemctl status mysql
```

### Issue: Maven Build Failed

**Solution:**
```bash
# Clean Maven cache
mvn clean

# Update dependencies
mvn clean install -U

# Skip tests if needed
mvn clean install -DskipTests
```

### Issue: ClassNotFoundException

**Solution:**
1. Right-click project → `Maven` → `Update Project`
2. Check `Force Update of Snapshots/Releases`
3. Click `OK`

### Issue: 404 Error When Accessing Application

**Check:**
1. Application deployed successfully (check Eclipse Console)
2. URL is correct: `http://localhost:8080/MediCareHMS/`
3. Tomcat is running
4. Check Tomcat logs in `<tomcat>/logs/catalina.out`

### Issue: Login Not Working

**Check:**
1. Database has initial data (run `initial_data.sql`)
2. Password encryption is working
3. Check browser console for JavaScript errors

---

## Additional Configuration

### Change Server Port

Edit `<tomcat>/conf/server.xml`:
```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```

Change `8080` to your desired port.

### Enable Debug Logging

Edit `src/main/webapp/WEB-INF/springMVC-servlet.xml`:
```xml
<prop key="hibernate.show_sql">true</prop>
<prop key="hibernate.format_sql">true</prop>
```

### Database Connection Pool Settings

Adjust in `springMVC-servlet.xml`:
```xml
<property name="minPoolSize" value="5" />
<property name="maxPoolSize" value="20" />
<property name="maxIdleTime" value="30000" />
```

---

## Next Steps

After successful setup:

1. **Change Default Password**
   - Login as admin
   - Go to profile settings
   - Update password

2. **Add Employees**
   - Navigate to Administrator Dashboard
   - Click "Add Employee"
   - Fill in details for doctors, receptionists

3. **Register Patients**
   - Login as receptionist
   - Click "Register Patient"
   - Enter patient information

4. **Explore Features**
   - Test doctor module
   - Generate prescriptions
   - Print patient records

---

## Support

For issues or questions:
- Check the main README.md
- Review error logs in Eclipse Console
- Check Tomcat logs
- Verify database connectivity

---

**Happy Coding! 🚀**
