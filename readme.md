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
- **Apache Tomcat Server** - Version 10.0 or higher (the app uses Jakarta Servlet 5)
- **MySQL Database** (or compatible database)
- **Git** - For cloning the repository

## Quick start with Task

[Task](https://taskfile.dev) wraps the build and Tomcat steps below (after the one-time database,
`setenv.sh` and Tomcat setup in *Installation & Setup*).

```bash
cp .env.example .env     # then set TOMCAT_HOME (and TOMCAT_PORT / APP_CONTEXT if needed)
task up                  # build if needed, deploy to Tomcat, start it, wait until it answers
```

| Task | What it does |
|------|--------------|
| `task up` | Build (skipped if nothing changed), deploy the WAR, start Tomcat |
| `task sync` | **Fast loop for JSP/CSS/JS edits**: rebuilds CSS if needed and copies `src/main/webapp` into the running app. No Maven, no redeploy; JSPs recompile on the next request |
| `task sync:java` | Compile Java and push the classes into the running app (Tomcat reloads it) |
| `task deploy` | Build if needed and copy the WAR to `$TOMCAT_HOME/webapps/$APP_CONTEXT.war` (hot redeploy) |
| `task start` / `stop` / `restart` | Control Tomcat in the background (uses `bin/setenv.sh`) |
| `task run` | Run Tomcat in the foreground with logs in the terminal |
| `task status` / `logs` / `open` | Is it running? Follow `catalina.out`. Open the store in the browser |
| `task css:watch` | Rebuild Tailwind on every change |
| `task undeploy` / `clean` | Remove the app from Tomcat (asks first) / delete `target/` |

`.env` holds only local, non-secret settings and is git-ignored. Database and PayPal credentials stay
in `$TOMCAT_HOME/bin/setenv.sh`.

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

# Image upload folder: OUTSIDE Tomcat's webapps, so uploads survive redeploys.
# Must contain product/ and category/ subfolders (`task uploads:init` creates them).
export IMAGE_UPLOAD_PATH="/absolute/path/to/greensuper-uploads"
# Lets Tomcat serve that folder at /uploadedImages (see src/main/webapp/META-INF/context.xml)
export CATALINA_OPTS="$CATALINA_OPTS -Dgreensuper.upload.dir=$IMAGE_UPLOAD_PATH"

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
├── frontend/tailwind/      Tailwind entry point (theme + shared components)
├── scripts/build-css.sh    builds src/main/webapp/css/app.css
├── src/
│   └── main/
│       ├── java/           servlets, DAOs, filters, models
│       └── webapp/
│           ├── WEB-INF/    web.xml + views/ (all JSPs)
│           ├── css/ js/ images/
├── database_sql.sql
├── README.md
└── [other project files]
```

### JSP views

All pages live in `src/main/webapp/WEB-INF/views/`, grouped by area:

```
WEB-INF/views/
├── shop/       index, product, cart, about, contact, feedback, terms_and_conditions
├── auth/       login, registration
├── payment/    approve, success, canceled, failed
├── admin/      login, dashboard, products, categories, customers, orders, add/manage forms, failed
└── includes/   shared header/navbar/footer fragments (includes/admin/ for the admin shell)
```

Files under `WEB-INF` can't be requested directly. `WEB-INF/web.xml` publishes each page at its
original URL (e.g. `/cart.jsp` → `views/shop/cart.jsp`, `/admin_products.jsp` → `views/admin/products.jsp`),
so servlet redirects, PayPal return URLs and links are unchanged. **To add a page**, create it under
`views/` and add a `servlet` + `servlet-mapping` pair in `web.xml`. Static includes use absolute paths,
e.g. `<%@ include file="/WEB-INF/views/includes/header.jsp" %>`.

### Image uploads

Admin uploads are saved by the servlets to `$IMAGE_UPLOAD_PATH/product` and `$IMAGE_UPLOAD_PATH/category`.
`src/main/webapp/META-INF/context.xml` mounts that folder at `/uploadedImages`, which is where the pages
load images from, so uploads show up immediately and are not wiped when the WAR is redeployed. Images
bundled in `src/main/webapp/uploadedImages` are still served when a file isn't in the upload folder.

Both `IMAGE_UPLOAD_PATH` and the `CATALINA_OPTS` line must be in `setenv.sh` (see step 5); without the
`-Dgreensuper.upload.dir` property Tomcat can't start the app. Restart Tomcat after changing them.

### Frontend styling (Tailwind CSS)

The UI is styled with Tailwind CSS. The compiled stylesheet `src/main/webapp/css/app.css` is committed,
so a normal Maven/Tomcat build needs no extra step. Rebuild it whenever you change classes in a JSP/JS file
or edit `frontend/tailwind/input.css` (theme tokens and shared components like `.btn`, `.input`, `.card`):

```bash
scripts/build-css.sh          # one-off minified build
scripts/build-css.sh --watch  # rebuild on change while developing
```

The script downloads the pinned Tailwind standalone binary into `.tools/` (git-ignored) on first run.
No Node.js installation is required.

### Technologies Used
- Java Servlets
- JSP (JavaServer Pages)
- JDBC for database connectivity
- PayPal SDK for payment processing
- Tailwind CSS v4 (standalone CLI, no Node.js) + vanilla JS/jQuery for the frontend
- GOOGLE SMTP for emails

---

**Note:** Make sure to replace placeholder values in the configuration 
          files with your actual credentials and execute SQL script the before running 
          the application.