# NIET Alumni Nexus

An Enterprise-Grade Alumni Engagement Platform built with Advanced Java (JSP, Servlets, Hibernate, MySQL) and Bootstrap 5.

## Features
- **Smart Networking Hub**: Virtual Mentorship and B2B Networking connections.
- **Opportunity Portal**: Alumni can post jobs and refer top students.
- **Resource Library**: Sharing interview experiences, roadmaps, and exclusive alumni perks.
- **Gamification**: "Top Mentors Leaderboard" based on mentorship points to incentivize engagement.
- **In-App Messaging**: Direct asynchronous communication.
- **Verified Credentialing**: Admin approval system for new alumni.

## Tech Stack
- **Backend:** Java 17, Servlets, JSP, JSTL
- **ORM:** Hibernate 6
- **Database:** MySQL 8+
- **Frontend:** Bootstrap 5 (Pulse Theme)
- **Build Tool:** Maven

## Setup & Deployment Instructions

### 1. Database Setup
1. Ensure MySQL Server is running.
2. Execute the `src/main/resources/schema.sql` script to create the `niet_nexus_db` database and necessary tables.
3. Update `src/main/resources/hibernate.cfg.xml` with your MySQL root username and password.

### 2. Build the Project
1. Clone the repository.
2. Navigate to the project root directory.
3. Run `mvn clean install` to download dependencies and build the `niet-alumni-nexus-1.0-SNAPSHOT.war` file.

### 3. Deploy to Tomcat
1. Download and extract Apache Tomcat 9 or 10.
2. Copy the generated `.war` file from the `target/` directory to the Tomcat `webapps/` directory.
3. Start Tomcat by running `bin/startup.bat` (Windows) or `bin/startup.sh` (Linux/Mac).
4. Access the application at: `http://localhost:8080/niet-alumni-nexus-1.0-SNAPSHOT/`

### Notes on Uploading
This project is structured as a standard Maven Dynamic Web Project, making it ready to upload to GitHub and deploy to PaaS providers (like AWS Elastic Beanstalk or Heroku with Tomcat).
