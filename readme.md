# E-commerce Web Application

A Java servlet-based e-commerce web application built for online shopping functionality with integrated PayPal payment processing.

## Features

- User authentication and management
- Product catalog and browsing
- Shopping cart functionality
- Order management
- PayPal payment integration
- Responsive web interface

## Prerequisites

Before running this application, ensure you have the following installed:

- **Java Development Kit (JDK)** - Version 8 or higher
- **Apache Tomcat Server** - Version 9.0 or higher
- **MySQL Database** (or compatible database)
- **Git** - For cloning the repository

## Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Nipun-Malinga/GreenSuper.git
cd GreenSuper
```

### 2. Install Apache Tomcat

Download and install Apache Tomcat from the [official website](https://tomcat.apache.org/).

### 3. Database Setup

1. **Create Database**: Create a new MySQL database for the application
2. **Execute SQL Schema**: Navigate to the `server` directory in the project and execute the SQL schema file on your MySQL database:

```bash
mysql -u your_username -p your_database_name < server/schema.sql
```

Or using MySQL Workbench/phpMyAdmin, import the SQL file located in the `server` directory.

1. **Note Database Details**: Keep track of your database connection details:
- Database URL
- Database username
- Database password

### 4. PayPal Configuration

Obtain your PayPal API credentials:
- PayPal Client ID
- PayPal Client Secret
- Payment Mode (sandbox/live)

### 5. Environment Configuration

Create a `setenv.sh` file in the `tomcat/bin` directory with the following content:

```bash
#!/bin/bash
# Green Super DB Configs
export DB_URL="jdbc:mysql://localhost:3306/your_database_name"
export DB_USER="your_database_username"
export DB_PASS="your_database_password"

# Green Super PayPal Payment Configs
export PAYPAL_CLIENT_ID="your_paypal_client_id"
export PAYPAL_CLIENT_SECRET="your_paypal_client_secret"
export PAYMENT_MODE="sandbox"  # Use "live" for production
```

**Important:** Replace the placeholder values with your actual configuration details.

### 6. Set File Permissions

Make the `setenv.sh` file executable:

```bash
chmod +x tomcat/bin/setenv.sh
```

### 7. Deploy the Application

1. Build the project (if using Maven/Gradle, run the appropriate build command)
2. Copy the generated WAR file to the `tomcat/webapps` directory
3. Alternatively, if you have the project as a directory, copy it to `tomcat/webapps`

### 8. Start the Server

Navigate to the Tomcat bin directory and start the server:

```bash
cd tomcat/bin
./startup.sh    # On Linux/Mac
# or
startup.bat     # On Windows
```

## Accessing the Application

Once the server is running, access the application at:

```
http://localhost:8080/[your-app-name]
```

If deployed as ROOT application:
```
http://localhost:8080
```

## Configuration Details

### Database Configuration
- The application uses environment variables for database connectivity
- **Important**: Execute the SQL schema from the `server` directory before starting the application
- Ensure your database server is running before starting Tomcat

### PayPal Integration
- **Sandbox Mode**: Use for testing with PayPal's test environment
- **Live Mode**: Use for production with real transactions
- Ensure your PayPal application is properly configured in your PayPal Developer Dashboard

## Troubleshooting

### Common Issues

1. **Port 8080 already in use**
    - Stop any other services using port 8080
    - Or modify the Tomcat port in `server.xml`

2. **Database connection errors**
    - Verify database credentials in `setenv.sh`
    - Ensure database server is running
    - Check if the database exists and schema has been executed
    - Execute the SQL schema from `server` directory if not done already

3. **PayPal payment errors**
    - Verify PayPal credentials
    - Check payment mode setting (sandbox vs live)
    - Ensure internet connectivity for PayPal API calls

4. **Environment variables not loading**
    - Verify `setenv.sh` has execution permissions
    - Check file location: `tomcat/bin/setenv.sh`
    - Restart Tomcat after making changes

## Development

### Project Structure
```
project-root/
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── webapp/
│   └── test/
├── WEB-INF/
├── README.md
└── [other project files]
```

### Technologies Used
- Java Servlets
- JSP (JavaServer Pages)
- JDBC for database connectivity
- PayPal SDK for payment processing
- HTML/CSS/JavaScript for frontend
- GOOGLE SMTP for emails

---

**Note:** Make sure to replace placeholder values in the configuration 
          files with your actual credentials and execute SQL script the before running 
          the application.