<!-- About Us/Contact Us Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This page provides information about Moffat Bay Lodge, including a brief overview of the lodge, its offerings,
and contact details. It is divided into two sections: "About Us" and "Contact Information."
The About Us section highlights the lodge's location, amenities, and experiences, while the Contact Information
section provides phone, email, and physical address details for potential guests. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>About Us - Moffat Bay Lodge</title>

  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Open+Sans&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Open Sans', sans-serif;
      background-color: #e1effb; /* Updated to pale blue */
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 960px;
      margin: 130px auto 13%;
      padding: 40px 30px;
      background-color: #fff;
      border-radius: 15px;
      box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
      display: flex;
      flex-direction: column;
      gap: 40px;
    }

    .about-section, .contact-section {
      text-align: center;
    }

    .about-section h2 {
      font-family: 'Playfair Display', serif;
      font-size: 32px;
      margin-bottom: 20px;
      color: #1a202c;
    }

    .about-section p {
      font-size: 17px;
      line-height: 1.7;
      color: #333;
      margin-bottom: 16px;
    }

    .contact-section {
      border-top: 1px solid #e0e0e0;
      padding-top: 20px;
    }

    .contact-section h3 {
      font-size: 20px;
      margin-bottom: 15px;
      color: #2d3748;
    }

    .contact-section p {
      font-size: 16px;
      margin: 6px 0;
    }

    .contact-section strong {
      display: inline-block;
      width: 80px;
      text-align: right;
      margin-right: 10px;
      color: #1a202c;
    }

    .contact-section a {
      color: #007BFF;
      text-decoration: none;
    }

    .contact-section a:hover {
      text-decoration: underline;
    }

    @media screen and (max-width: 1920px) {
      .container {
        margin: 120px auto 6%;
      }
    }

    @media (max-width: 600px) {
      .container {
        margin: 100px 20px 40px;
        padding: 30px;
      }

      .about-section h2 {
        font-size: 26px;
      }

      .about-section p,
      .contact-section p {
        font-size: 15px;
      }
    }
  </style>
</head>
<body>

  <jsp:include page="Navbar.jsp" flush="true" />

  <div class="container">
  	<div class="about-section">
    	<h2>About Moffat Bay Lodge</h2>
    	<p>
    	  Moffat Bay Lodge is a peaceful island escape nestled in the breathtaking Pacific Northwest. Our lodge offers stunning views, cozy accommodations, and unforgettable outdoor experiences that showcase the natural beauty of the region.
    	</p>
    	<p>
    	  Guests can immerse themselves in adventure with activities such as guided hiking tours along scenic cliffside trails, kayaking through calm waters and hidden sea caves, or enjoying a champagne-filled ferry ride with panoramic coastal views. For those seeking hands-on excitement, our fishing excursions with local pros provide both fun and expert instruction.
    	</p>
    	<p>
    	  Whether you're seeking relaxation, romance, or outdoor thrill, Moffat Bay Lodge provides the perfect blend of comfort and adventure. With welcoming staff and uniquely curated island experiences, we’re proud to be a top destination for travelers near and far.
    	</p>
  	</div>

    <div class="contact-section">
      <h3>Contact Information</h3>
      <p><strong>Phone:</strong> (360) 555-1234</p>
      <p><strong>Email:</strong> <a href="mailto:info@moffatbaylodge.com">info@moffatbaylodge.com</a></p>
      <p><strong>Address:</strong> 123 Moffat Bay Road, Friday Harbor, WA 98250</p>
    </div>
  </div>

  <jsp:include page="Foot.jsp" flush="true" />

</body>
</html>
