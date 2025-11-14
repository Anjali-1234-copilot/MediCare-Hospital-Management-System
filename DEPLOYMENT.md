# Deployment Guide - MediCare HMS

This guide covers deploying MediCare Hospital Management System to various environments.

## Table of Contents
1. [Local Deployment](#local-deployment)
2. [Production Server Deployment](#production-server-deployment)
3. [Cloud Deployment](#cloud-deployment)
4. [Docker Deployment](#docker-deployment)
5. [Security Checklist](#security-checklist)

---

## Local Deployment

### For Development/Testing

Follow the [QUICKSTART.md](QUICKSTART.md) guide for local setup.

**Quick Steps:**
```bash
# Build
mvn clean package

# Deploy to Tomcat
cp target/MediCareHMS.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh  # Linux/Mac
$TOMCAT_HOME/bin/startup.bat  # Windows
```

---

## Production Server Deployment

### Prerequisites
- Linux server (Ubuntu 20.04+ recommended)
- Java JDK 11+
- MySQL 8.0+
- Apache Tomcat 9.0+
- Domain name (optional)
- SSL certificate (recommended)

### Step 1: Server Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Java
sudo apt install openjdk-11-jdk -y

# Install MySQL
sudo apt install mysql-server -y
sudo mysql_secure_installation

# Install Tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz
sudo tar xzvf apache-tomcat-9.0.80.tar.gz -C /opt/
sudo ln -s /opt/apache-tomcat-9.0.80 /opt/tomcat
```

### Step 2: Database Setup

```bash
# Login to MySQL
sudo mysql -u root -p

# Create database and user
CREATE DATABASE medicare_hospital;
CREATE USER 'medicare_user'@'localhost' IDENTIFIED BY 'strong_password_here';
GRANT ALL PRIVILEGES ON medicare_hospital.* TO 'medicare_user'@'localhost';
FLUSH PRIVILEGES;

# Import schema
mysql -u medicare_user -p medicare_hospital < database/schema.sql
mysql -u medicare_user -p medicare_hospital < database/initial_data.sql
```

### Step 3: Application Configuration

Edit `src/main/webapp/WEB-INF/springMVC-servlet.xml`:

```xml
<property name="jdbcUrl" value="jdbc:mysql://localhost:3306/medicare_hospital?useSSL=true" />
<property name="user" value="medicare_user" />
<property name="password" value="strong_password_here" />
```

### Step 4: Build and Deploy

```bash
# Build WAR file
mvn clean package -Pprod

# Copy to Tomcat
sudo cp target/MediCareHMS.war /opt/tomcat/webapps/

# Set permissions
sudo chown -R tomcat:tomcat /opt/tomcat/

# Start Tomcat
sudo /opt/tomcat/bin/startup.sh
```

### Step 5: Configure Firewall

```bash
# Allow HTTP and HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8080/tcp
sudo ufw enable
```

### Step 6: Setup Nginx Reverse Proxy (Optional)

```bash
# Install Nginx
sudo apt install nginx -y

# Create configuration
sudo nano /etc/nginx/sites-available/medicare
```

Add configuration:
```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location / {
        proxy_pass http://localhost:8080/MediCareHMS/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable and restart:
```bash
sudo ln -s /etc/nginx/sites-available/medicare /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### Step 7: SSL Certificate (Let's Encrypt)

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx -y

# Obtain certificate
sudo certbot --nginx -d yourdomain.com

# Auto-renewal
sudo certbot renew --dry-run
```

---

## Cloud Deployment

### AWS Deployment

#### Option 1: AWS Elastic Beanstalk

```bash
# Install EB CLI
pip install awsebcli

# Initialize
eb init -p tomcat-8.5-java-11 medicare-hms

# Create environment
eb create medicare-hms-prod

# Deploy
eb deploy
```

#### Option 2: AWS EC2

1. Launch EC2 instance (Ubuntu 20.04)
2. Configure security groups (ports 80, 443, 8080)
3. Follow [Production Server Deployment](#production-server-deployment) steps
4. Setup RDS for MySQL database
5. Configure environment variables

**RDS Setup:**
```bash
# Update springMVC-servlet.xml with RDS endpoint
<property name="jdbcUrl" value="jdbc:mysql://your-rds-endpoint:3306/medicare_hospital" />
```

### Azure Deployment

#### Azure App Service

```bash
# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login
az login

# Create resource group
az group create --name medicare-rg --location eastus

# Create app service plan
az appservice plan create --name medicare-plan --resource-group medicare-rg --sku B1 --is-linux

# Create web app
az webapp create --resource-group medicare-rg --plan medicare-plan --name medicare-hms --runtime "TOMCAT:9.0-jre11"

# Deploy
az webapp deployment source config-zip --resource-group medicare-rg --name medicare-hms --src target/MediCareHMS.war
```

### Google Cloud Platform

#### App Engine

Create `app.yaml`:
```yaml
runtime: java11
instance_class: F2

handlers:
- url: /.*
  script: auto
  secure: always

env_variables:
  MYSQL_HOST: 'your-cloud-sql-ip'
  MYSQL_USER: 'medicare_user'
  MYSQL_PASSWORD: 'your-password'
  MYSQL_DATABASE: 'medicare_hospital'
```

Deploy:
```bash
gcloud app deploy
```

---

## Docker Deployment

### Dockerfile

Create `Dockerfile`:
```dockerfile
FROM tomcat:9.0-jdk11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY target/MediCareHMS.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
```

### Docker Compose

Create `docker-compose.yml`:
```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: medicare_hospital
      MYSQL_USER: medicare_user
      MYSQL_PASSWORD: medicare_pass
    volumes:
      - mysql_data:/var/lib/mysql
      - ./database/schema.sql:/docker-entrypoint-initdb.d/1-schema.sql
      - ./database/initial_data.sql:/docker-entrypoint-initdb.d/2-data.sql
    ports:
      - "3306:3306"

  app:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - mysql
    environment:
      MYSQL_HOST: mysql
      MYSQL_PORT: 3306
      MYSQL_DATABASE: medicare_hospital
      MYSQL_USER: medicare_user
      MYSQL_PASSWORD: medicare_pass

volumes:
  mysql_data:
```

### Build and Run

```bash
# Build
docker-compose build

# Run
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

---

## Security Checklist

### Before Production Deployment

- [ ] Change all default passwords
- [ ] Enable HTTPS/SSL
- [ ] Configure firewall rules
- [ ] Set up database backups
- [ ] Enable application logging
- [ ] Configure error pages (hide stack traces)
- [ ] Set secure session timeout
- [ ] Implement rate limiting
- [ ] Enable CORS properly
- [ ] Update all dependencies
- [ ] Remove debug/test code
- [ ] Configure proper file permissions
- [ ] Set up monitoring and alerts
- [ ] Create disaster recovery plan
- [ ] Document deployment process

### Database Security

```sql
-- Remove test data
DELETE FROM login WHERE username != 'admin';

-- Change admin password
UPDATE login SET password = '$2a$10$NEW_HASH_HERE' WHERE username = 'admin';

-- Restrict MySQL access
REVOKE ALL PRIVILEGES ON *.* FROM 'medicare_user'@'%';
GRANT ALL PRIVILEGES ON medicare_hospital.* TO 'medicare_user'@'localhost';
```

### Application Security

Edit `web.xml`:
```xml
<!-- Session timeout (30 minutes) -->
<session-config>
    <session-timeout>30</session-timeout>
</session-config>

<!-- Error pages -->
<error-page>
    <error-code>404</error-code>
    <location>/WEB-INF/view/error/404.jsp</location>
</error-page>
<error-page>
    <error-code>500</error-code>
    <location>/WEB-INF/view/error/500.jsp</location>
</error-page>
```

---

## Monitoring and Maintenance

### Log Files

```bash
# Application logs
tail -f /opt/tomcat/logs/catalina.out

# Access logs
tail -f /opt/tomcat/logs/localhost_access_log.txt

# MySQL logs
tail -f /var/log/mysql/error.log
```

### Database Backup

```bash
# Create backup script
cat > /opt/scripts/backup_db.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u medicare_user -p'password' medicare_hospital > /backups/medicare_$DATE.sql
find /backups -name "medicare_*.sql" -mtime +7 -delete
EOF

# Make executable
chmod +x /opt/scripts/backup_db.sh

# Add to crontab (daily at 2 AM)
crontab -e
0 2 * * * /opt/scripts/backup_db.sh
```

### Health Check Endpoint

Create a simple health check:
```java
@RequestMapping("/health")
public ResponseEntity<String> healthCheck() {
    return ResponseEntity.ok("OK");
}
```

---

## Troubleshooting Production Issues

### Application Won't Start
```bash
# Check Tomcat logs
tail -100 /opt/tomcat/logs/catalina.out

# Check port availability
netstat -tulpn | grep 8080

# Verify Java version
java -version
```

### Database Connection Issues
```bash
# Test MySQL connection
mysql -u medicare_user -p -h localhost medicare_hospital

# Check MySQL status
sudo systemctl status mysql

# Review MySQL logs
sudo tail -50 /var/log/mysql/error.log
```

### Performance Issues
```bash
# Monitor system resources
htop

# Check database queries
mysql -u root -p -e "SHOW PROCESSLIST;"

# Analyze slow queries
mysql -u root -p -e "SELECT * FROM mysql.slow_log;"
```

---

## Rollback Procedure

```bash
# Stop Tomcat
sudo /opt/tomcat/bin/shutdown.sh

# Backup current version
sudo mv /opt/tomcat/webapps/MediCareHMS.war /opt/backups/MediCareHMS_$(date +%Y%m%d).war

# Restore previous version
sudo cp /opt/backups/MediCareHMS_YYYYMMDD.war /opt/tomcat/webapps/MediCareHMS.war

# Start Tomcat
sudo /opt/tomcat/bin/startup.sh
```

---

**For support, contact: [your-email@example.com]**
