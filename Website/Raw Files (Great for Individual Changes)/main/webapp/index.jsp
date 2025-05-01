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
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&family=Open+Sans&display=swap" rel="stylesheet">
  <script src="https://kit.fontawesome.com/6af38ce6e0.js" crossorigin="anonymous"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Open Sans', sans-serif;
      color: #2c3e50;
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
      padding: 0 2rem;
      z-index: 1;
    }

    header.hero h2 {
      font-family: 'Georgia', serif;;
      font-size: 4rem;
      margin-bottom: 1rem;
      color: white;
    }

    header.hero p {
      font-family: 'Open Sans', sans-serif;
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
      cursor: pointer;
      border-radius: 5px;
    }

    .cta-button:hover {
      background-color: #d35400;
    }

    /* ======= MAIN SECTION ======= */
    .section {
      padding: 3rem 2rem;
      text-align: center;
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
      padding: 1rem;
    }

    /* ======= RESPONSIVE ======= */
    @media (max-width: 768px) {
      header.hero h2 {
        font-size: 2.2rem;
      }

      header.hero p {
        font-size: 1.2rem;
      }
    }
  </style>
</head>

<body>

<!-- This imports the NavBar into the page -->
<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

    <!-- Hero Section -->
      <header class="hero">
        <div class="hero-content">
          <h2>Welcome to Moffat Bay Lodge</h2>
          <p>Experience Tranquility in the Heart of Nature</p>
          <a href="reservation.jsp">
            <button class="cta-button">Book Your Stay</button>
          </a>
        </div>
      </header>

  <!-- Attractions Section -->
  <section class="section">
    <h2>Explore the Island</h2>
    <div class="attractions">
      <%
        // You can fetch attractions dynamically from the backend
        String[] attractions = {"Hiking", "Kayaking", "Champagne Ferry Ride", "Fishing Experience"};
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
  </section>
  
  <!-- This imports the Footer into the Page below everything -->
  <jsp:include page="Foot.jsp" flush="true"></jsp:include>
</body>
</html>
