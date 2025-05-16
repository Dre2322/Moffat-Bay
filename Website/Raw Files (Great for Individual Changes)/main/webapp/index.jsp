<!-- Landing Page Alpha Team -->
<!-- Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh -->

<!-- Purpose:
This is the landing page for Moffat Bay Lodge. It introduces users to the lodge with a visually appealing hero section,
including a call-to-action button to book a stay. Below the hero section, users can explore the island’s attractions
like hiking, kayaking, whale watching, and scuba diving. The page provides a welcoming overview of the lodge and its
offerings, guiding users toward making a reservation. -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="author" content="Andres Melendez, Jeffrey Reid">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Moffat Bay Lodge</title>

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
  
  <!-- Font Awesome for icons (optional) -->
  <script src="https://kit.fontawesome.com/6af38ce6e0.js" crossorigin="anonymous"></script>

  <style>
    /* Reset default browser styles and enable border-box sizing */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* Base body font and text color */
    body {
      font-family: 'Open Sans', sans-serif;
      color: #2c3e50;
    }

    /* ======= CONTAINER (CENTERS CONTENT ON ULTRAWIDE SCREENS) ======= */
    .container {
      width: 100%;
      max-width: 1440px; /* Prevents stretching on ultra-wide monitors */
      margin: 0 auto;
      padding: 0 2rem;    /* Adds side padding on smaller screens */
    }

    /* ======= HERO SECTION ======= */
    header.hero {
      background: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb') no-repeat center center/cover;
      height: 90vh;
      color: white;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
      z-index: 1;
    }

    .hero-content h2 {
      font-family: 'Georgia', serif;
      font-size: 4rem;
      margin-bottom: 1rem;
      color: white;
    }

    .hero-content p {
      font-size: 1.8rem;
      margin-bottom: 2rem;
      color: white;
    }

    .cta-button {
      background-color: #e67e22;
      color: white;
      padding: 0.75rem 2rem;
      border: none;
      font-size: 1.2rem;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .cta-button:hover {
      background-color: #d35400;
    }

    /* ======= MAIN SECTION ======= */
    .section {
      padding: 3rem 0;
      text-align: center;
    }

    .section h2 {
      font-size: 2.5rem;
      margin-bottom: 2rem;
    }

    .attractions {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 2rem;
    }

    .attraction-card {
      flex: 1 1 250px;
      background-color: #ecf0f1;
      border-radius: 10px;
      padding: 1.5rem;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.2s ease;
    }

    .attraction-card:hover {
      transform: translateY(-5px);
    }

    .attraction-card h3 {
      font-size: 1.5rem;
      margin-bottom: 0.5rem;
    }

    .attraction-card p {
      font-size: 1rem;
    }

    /* ======= RESPONSIVE (TABLETS & PHONES) ======= */
    @media (max-width: 768px) {
      .hero-content h2 {
        font-size: 2.2rem;
      }

      .hero-content p {
        font-size: 1.2rem;
      }

      .cta-button {
        font-size: 1rem;
        padding: 0.6rem 1.5rem;
      }
    }
  </style>
</head>

<body>

  <!-- ======= INCLUDE NAVBAR ======= -->
  <jsp:include page="Navbar.jsp" flush="true"></jsp:include>

  <!-- ======= HERO SECTION ======= -->
  <header class="hero">
    <div class="container">
      <div class="hero-content">
        <h2>Welcome to Moffat Bay Lodge</h2>
        <p>Experience Tranquility in the Heart of Nature</p>
        <a href="reservation.jsp">
          <button class="cta-button">Book Your Stay</button>
        </a>
      </div>
    </div>
  </header>

  <!-- ======= ATTRACTIONS SECTION ======= -->
  <section class="section">
    <div class="container">
      <h2>Explore the Island</h2>

      <!-- Attraction Cards (generated via JSP) -->
      <div class="attractions">
        <%
          // Simple array of attractions - replace with DB call if needed
          String[] attractions = {"Hiking", "Kayaking", "Whale Watching", "Scuba Diving"};
          for (String attraction : attractions) {
        %>
          <div class="attraction-card">
            <h3><%= attraction %></h3>
            <p>Experience the best of Moffat Bay with our exciting <%= attraction %> activities.</p>
          </div>
        <%
          }
        %>
      </div>
    </div>
  </section>

  <!-- ======= INCLUDE FOOTER ======= -->
  <jsp:include page="Foot.jsp" flush="true"></jsp:include>

</body>
</html>
