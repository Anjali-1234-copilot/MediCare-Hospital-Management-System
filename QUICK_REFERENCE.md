# MediCare HMS - Quick Reference Card

## Essential Information at a Glance

### Project Details
- **Name:** MediCare Hospital Management System
- **Version:** 1.0.0
- **Package:** com.healthcare.medicare
- **Database:** medicare_hospital
- **Port:** 8080
- **URL:** http://localhost:8080/MediCareHMS/

---

## Default Credentials

```
Username: admin
Password: admin123
Role: Administrator
```

---

## Quick Commands

### Build
```bash
mvn clean install
```

### Run (Eclipse)
```
Right-click → Run As → Run on Server
```

### Database Setup
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p < database/initial_data.sql
```

---

## File Locations

### Configuration
- Spring Config: `src/main/webapp/WEB-INF/springMVC-servlet.xml`
- Web Config: `src/main/webapp/WEB-INF/web.xml`
- Maven: `pom.xml`

### Source Code
- Controllers: `src/main/java/com/healthcare/medicare/controller/`
- DAO: `src/main/java/com/healthcare/medicare/dao/`
- Entities: `src/main/java/com/healthcare/medicare/entity/`
- Views: `src/main/webapp/WEB-INF/view/`

### Database
- Schema: `database/schema.sql`
- Initial Data: `database/initial_data.sql`
- Credentials: `database/credentials.txt`

---

## Database Connection

### Update in springMVC-servlet.xml
```xml
<property name="jdbcUrl" value="jdbc:mysql://localhost:3306/medicare_hospital" />
<property name="user" value="root" />
<property name="password" value="YOUR_PASSWORD" />
```

---

## Common Issues & Fixes

### Port 8080 in use
```bash
netstat -ano | findstr :8080
taskkill /PID <pid> /F
```

### Database connection failed
```bash
# Check MySQL is running
mysql -u root -p

# Verify database exists
SHOW DATABASES;
USE medicare_hospital;
```

### Build failed
```bash
mvn clean install -U
```

---

## Module Access

### Administrator
- Add/Edit/Delete employees
- View all users
- System management

### Doctor
- View patients
- Generate prescriptions
- Access patient history

### Receptionist
- Register patients
- Search patients
- Print prescriptions

---

## Technology Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Backend | Spring MVC | 5.3.18 |
| ORM | Hibernate | 5.4.8 |
| Database | MySQL | 8.0.17 |
| Frontend | Bootstrap | 4.x |
| Server | Tomcat | 9.0 |
| Build | Maven | 3.x |
| Security | BCrypt | 0.3m |

---

## Important URLs

### Local Development
- Application: http://localhost:8080/MediCareHMS/
- Tomcat Manager: http://localhost:8080/manager/
- MySQL: localhost:3306

---

## Key Features

✓ Role-based access control  
✓ Patient management  
✓ Prescription generation  
✓ OPD queue management  
✓ Employee management  
✓ BCrypt password encryption  
✓ PDF generation  
✓ Patient history tracking  

---

## Documentation Files

| File | Purpose |
|------|---------|
| README.md | Project overview |
| QUICKSTART.md | 10-minute setup |
| SETUP_GUIDE.md | Detailed installation |
| PROJECT_INFO.md | Your project details |
| DEPLOYMENT.md | Production deployment |
| CONTRIBUTING.md | Contribution guide |
| CHANGELOG.md | Version history |
| CUSTOMIZATION_SUMMARY.md | Changes made |

---

## Database Tables

1. **login** - User authentication
2. **employee** - Staff information
3. **patient** - Patient records
4. **opd** - OPD visits
5. **opddetails** - Prescription details
6. **idgenerate** - ID management

---

## Maven Commands

```bash
# Clean
mvn clean

# Compile
mvn compile

# Test
mvn test

# Package
mvn package

# Install
mvn install

# Clean + Install
mvn clean install

# Skip tests
mvn clean install -DskipTests

# Update dependencies
mvn clean install -U
```

---

## Git Commands

```bash
# Initialize
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit"

# Add remote
git remote add origin <url>

# Push
git push -u origin main
```

---

## Customization Checklist

- [ ] Update PROJECT_INFO.md with your details
- [ ] Update README.md contact info
- [ ] Configure database password
- [ ] Test application locally
- [ ] Initialize Git repository
- [ ] Push to your GitHub
- [ ] Add your branding/logo
- [ ] Create demo video (optional)

---

## Support Resources

- **Setup Issues:** See SETUP_GUIDE.md
- **Deployment:** See DEPLOYMENT.md
- **Contributing:** See CONTRIBUTING.md
- **Quick Start:** See QUICKSTART.md

---

## Emergency Contacts

**Database Issues:**
```bash
sudo systemctl restart mysql
```

**Tomcat Issues:**
```bash
$TOMCAT_HOME/bin/shutdown.sh
$TOMCAT_HOME/bin/startup.sh
```

**Application Issues:**
- Check Eclipse Console
- Check Tomcat logs: `<tomcat>/logs/catalina.out`
- Check MySQL logs: `/var/log/mysql/error.log`

---

**Print this page for quick reference during development!**

---

**Last Updated:** November 2024  
**Version:** 1.0.0
