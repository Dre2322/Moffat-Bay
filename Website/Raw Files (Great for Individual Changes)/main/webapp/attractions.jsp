<!-- 
    Attractions Page Alpha Team
    Consists of Andres Melendez, Jeffrey Reid, Edgar Arroyo, Jordany Gonzalez, and Matthew Trinh

    Purpose:
    This page showcases the various attractions offered by Moffat Bay Lodge, 
    utilizing collapsible sections and image previews. Styles and layout are handled via an external CSS file.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Attractions - Moffat Bay Lodge</title>
  <link rel="stylesheet" href="attractions.css">
</head>

<body id="top">

<!-- Include persistent navigation bar -->
<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

<!-- Hero Section -->
<div class="hero">
  <div class="hero-overlay">
    <h4>Adventure Awaits</h4>
    <hr>
    <h1>Our Many Attractions</h1>
    <p>
      Moffat Bay Lodge offers a range of unforgettable experiences: 
      guided tour hikes through the Gravel Point Preserve, kayaking along coastal edges and sea caves, 
      champagne-filled ferry cruises with sunset views, and professional guided fishing trips.
    </p>
  </div>
</div>


<div class="container">
  <h2>Explore Island Experiences</h2>

  <!-- Guided Tour Hike section -->
  <div class="attraction-section row-reverse">
    <!-- Text Column -->
    <div class="attraction-text">
      <h3>Guided Tour Hike</h3>
      <p>Enjoy a group-led hike through the famous Gravel Point Preserve Hiking Trail.</p>
      <p>This scenic trail offers beautiful ocean overlooks, wildlife sightings, and relaxing forest paths. Our knowledgeable guide shares fun facts along the way!</p>
    </div>

    <!-- Image Column -->
    <div class="attraction-media">
      <div class="carousel">
        <img class="carousel-image active" src="images/Hiking1.jpeg" alt="Hiking 1">
        <img class="carousel-image" src="images/Hiking2.jpg" alt="Hiking 2">
        <img class="carousel-image" src="images/Hiking3.jpg" alt="Hiking 3">
        <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
        <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
      </div>
    </div>
  </div>


  <!-- Kayaking section -->
  <div class="attraction-section">
    <!-- Text Column -->
    <div class="attraction-text">
      <h3>Kayaking</h3>
      <p>Paddle through calm waters and explore sea caves and rocky island edges.</p>
      <p>Rent a kayak or join a group led by local paddlers. A great experience for beginners or pros with gear and safety equipment included.</p>
    </div>

    <!-- Image Column -->
    <div class="attraction-media">
      <div class="carousel">
        <img class="carousel-image active" src="images/Kayaking1.jpg" alt="Kayaking 1">
        <img class="carousel-image" src="images/Kayaking3.jpeg" alt="Kayaking 2">
        <img class="carousel-image" src="images/Kayaking2.jpeg" alt="Kayaking 3">
        <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
        <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
      </div>
    </div>
  </div>


  <!-- Champagne Ferry Ride section -->
  <div class="attraction-section row-reverse">
    <!-- Text Column -->
    <div class="attraction-text">
      <h3>Champagne-Filled Ferry Ride</h3>
      <p>Relax on a scenic ferry cruise while enjoying complimentary champagne and stunning island views.</p>
      <p>Our evening ferry tours offer a luxurious escape with drinks, snacks, and unforgettable photo opportunities at sunset.</p>
    </div>

  <!-- Image Column -->
  <div class="attraction-media">
    <div class="carousel">
      <img class="carousel-image active" src="images/FerryRide2.jpg" alt="Ferry 1">
      <img class="carousel-image" src="images/FerryRide3.jpg" alt="Ferry 2">
      <img class="carousel-image" src="images/FerryRide1.jpg" alt="Ferry 3">
      <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
      <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
    </div>
  </div>
  </div>


  <!-- Fishing Experience section -->
  <div class="attraction-section">
    <!-- Text Column -->
    <div class="attraction-text">
      <h3>Fishing Experience with a Pro</h3>
      <p>Spend a half-day on the water with our experienced guide who helps you learn, fish, and even get your license!</p>
      <p>Our local fishing expert teaches everything from casting basics to advanced techniques. We also help you obtain a valid fishing license on the spot.</p>
    </div>

    <!-- Image Column -->
    <div class="attraction-media">
      <div class="carousel">
        <img class="carousel-image active" src="images/Fishing1.jpg" alt="Fishing 1">
        <img class="carousel-image" src="images/Fishing2.jpg" alt="Fishing 2">
        <img class="carousel-image" src="images/Fishing3.jpg" alt="Fishing 3">
        <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
        <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
      </div>
    </div>
  </div>
</div>

<!-- Call-to-action Button Section -->
<div class="bottom-cta">
  <a href="#top" class="cta-button">↑ Back to Top</a>
  <!-- Optional: Swap above for "Book Now" with link -->
  <!-- <a href="reservations.jsp" class="cta-button">Book Now</a> -->
</div>

<!-- Include persistent footer -->
<jsp:include page="Foot.jsp" flush="true"></jsp:include>

<!-- JavaScript to toggle each section's visibility and switch button text -->
<script>
  let currentOpen = "";
  let currentLink = null;

  function toggleAttraction(id, linkElement) {
    if (currentOpen && currentOpen !== id) {
      document.getElementById(currentOpen).style.display = "none";
      if (currentLink) currentLink.innerText = "View more...";
    }

    const section = document.getElementById(id);

    if (section.style.display === "none") {
      section.style.display = "block";
      linkElement.innerText = "View less...";
      currentOpen = id;
      currentLink = linkElement;
    } else {
      section.style.display = "none";
      linkElement.innerText = "View more...";
      currentOpen = "";
      currentLink = null;
    }
  }
  
  function moveSlide(button, direction) {
	    const carousel = button.closest(".carousel");
	    const images = carousel.querySelectorAll(".carousel-image");
	    const activeIndex = [...images].findIndex(img => img.classList.contains("active"));
	    
	    let nextIndex = (activeIndex + direction + images.length) % images.length;

	    images[activeIndex].classList.remove("active");
	    images[nextIndex].classList.add("active");
	  }
</script>

</body>
</html>
