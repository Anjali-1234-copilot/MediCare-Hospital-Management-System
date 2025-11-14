# Quick Start Guide - MediCare HMS

Get up and running with MediCare Hospital Management System in 10 minutes!

## Prerequisites Checklist

- [ ] Java JDK 8+ installed
- [ ] Maven installed
- [ ] MySQL Server installed and running
- [ ] Eclipse IDE (or IntelliJ IDEA)
- [ ] Apache Tomcat 9.0

## 5-Step Setup

### Step 1: Database Setup (2 minutes)

```bash
# Login to MySQL
mysql -u root -p

# Run the setup scripts
source database/schema.sql
source database/initial_data.sql

# Verify
USE medicare_hospital;
SHOW TABLES;
```

### Step 2: Configure Database Connection (1 minute)

Edit `src/main/webapp/WEB-INF/springMVC-servlet.xml`:

```xml
<property name="user" value="root" />
<property name="password" value="YOUR_MYSQL_PASSWORD" />
```

### Step 3: Import Project (2 minutes)

**Eclipse:**
1. `File` → `Import` → `Maven` → `Existing Maven Projects`
2. Select project folder
3. Click `Finish`

### Step 4: Build Project (2 minutes)

```bash
mvn clean install
```

Or in Eclipse:
- Right-click project → `Run As` → `Maven install`

### Step 5: Run Application (3 minutes)

**Eclipse:**
1. Right-click project → `Run As` → `Run on Server`
2. Select Tomcat 9.0
3. Click `Finish`

**Access:** http://localhost:8080/MediCareHMS/

## Default Login

```
Username: admin
Password: admin123
Role: Administrator
```

## First Steps After Login

1. **Change Password**
   - Click on profile icon
   - Select "Change Password"

2. **Add a Doctor**
   - Go to "Add Employee"
   - Fill in details
   - Select role: "Doctor"
   - Submit

3. **Add a Receptionist**
   - Go to "Add Employee"
   - Fill in details
   - Select role: "Receptionist"
   - Submit

4. **Test Login**
   - Logout
   - Login with new employee credentials
   - Username: Employee ID (e.g., EMP002)
   - Password: Aadhar Number (entered during registration)

## Common Issues

### Port 8080 in use?
```bash
# Change Tomcat port in server.xml to 8081
```

### Database connection failed?
- Check MySQL is running: `mysql -u root -p`
- Verify credentials in `springMVC-servlet.xml`
- Ensure database `medicare_hospital` exists

### Build failed?
```bash
mvn clean install -U
```

## Next Steps

- Read full [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions
- Check [README.md](README.md) for features and documentation
- Review [CONTRIBUTING.md](CONTRIBUTING.md) to contribute

## Need Help?

- Check the [Troubleshooting](SETUP_GUIDE.md#troubleshooting) section
- Review error logs in Eclipse Console
- Check Tomcat logs in `<tomcat>/logs/catalina.out`

---

**You're all set! Start managing your hospital efficiently! 🏥**
