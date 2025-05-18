# 🏕️ Moffat Bay Lodge Website

![HTML5](https://img.shields.io/badge/HTML5-✓-orange) ![CSS3](https://img.shields.io/badge/CSS3-✓-blue) ![Java](https://img.shields.io/badge/Java-✓-red) ![MySQL](https://img.shields.io/badge/MySQL-✓-lightblue) ![Tomcat](https://img.shields.io/badge/Tomcat-✓-yellowgreen)

Welcome to the **Moffat Bay Lodge Website** project!  
This full-stack web application allows users to explore the lodge, register/login, book their vacation stay, and manage/view reservations. The site combines user-friendly design, secure access, and MySQL backend integration.

---

## 📚 Table of Contents
- [Team Members](#-team-members)
- [Project Overview](#-project-overview)
- [Website Pages](#-website-pages)
- [Authentication and Registration](#-authentication-and-registration)
- [Reservation System](#-reservation-system)
- [Technologies Used](#-technologies-used)
- [Security Features](#-security-features)
- [Completed Work](#-completed-work)
- [Notes](#-notes)

---

## 👥 Team Members
- **Andres Melendez** – Team Lead
- **Jeffrey Reid** – Developer
- **Jordany Gonzalez** – Developer
- **Edgar Arroyo** – Developer
- **Matthew Trinh** – Developer
- **Prof. Sue** – Professor

---

## 📝 Project Overview
Moffat Bay Lodge’s website allows visitors to:
- Browse lodge information without an account
- Register and log in to book a vacation
- Submit and view reservations
- Search and retrieve past reservations

Reservations and user information are stored securely in a MySQL database.

---

## 🌐 Website Pages

| Page | Description |
|:---|:---|
| **Landing Page** | Marketing-focused entry page for Moffat Bay Lodge |
| **About Us** | Static HTML/CSS page describing the lodge |
| **Contact Us** | Static page providing lodge contact information |
| **Attractions** | Activities: hiking, kayaking, whale watching, scuba diving |
| **Registration** | User registration form with field validations |
| **Login** | Secure login form with session management |
| **Lodge Reservation** | Book a room by selecting dates, guests, and room type |
| **Reservation Summary** | Confirm or cancel reservation before submission |
| **Reservation Lookup** | Search by Reservation ID or Email for past bookings |

---

## 🔐 Authentication and Registration

- Registration includes fields for:
  - Email (username), First Name, Last Name, Telephone, and Password
- Validations:
  - Email format (`name@example.com`)
  - Password strength: 8+ characters, 1 uppercase, 1 lowercase, 1 number
- Passwords are securely hashed before storage
- Login validates credentials and maintains active session

---

## 🏡 Reservation System

- **Room Sizes & Rates:**
  - Double Full Beds – $126/night
  - Queen – $141.75/night
  - Double Queen Beds – $157.50/night
  - King – $168/night
- **Inputs Collected:**
  - Room type, number of guests, check-in/check-out dates
- **Features:**
  - Summary confirmation before final submission
  - Cancel button returns user to booking
  - Submissions stored in MySQL
  - Reservation lookup via reservation ID or email

---

## 🛠️ Technologies Used
- **Frontend:** HTML5, CSS3, JavaScript
- **Backend:** Java Servlets, JSP
- **Database:** MySQL
- **Server:** Apache Tomcat

---

## 🔒 Security Features
- Passwords hashed with secure algorithms
- Email and password validations using regular expressions
- Session-based user management
- Sensitive data is not stored in plain text
- No payment information is collected or stored

---

## 📌 Notes
- Reservation confirmation is manual (click-to-confirm only), no payment is processed
- Project follows industry best practices for form validation and data protection

---

# 🚀 Thank you for visiting Moffat Bay Lodge!
