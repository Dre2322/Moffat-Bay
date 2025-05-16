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

<!-- ===== Navbar Include ===== -->
<jsp:include page="Navbar.jsp" flush="true"></jsp:include>

<!-- ===== Hero Section ===== -->
<div class="hero">
  <div class="hero-overlay">
    <h4>Adventure Awaits</h4>
    <hr>
    <h1>Our Many Attractions</h1>
    <p>
      Moffat Bay Lodge offers a range of unforgettable experiences: 
      guided hikes through the Gravel Point Preserve, kayaking along sea caves,
      thrilling whale watching tours, and immersive scuba diving adventures.
    </p>
  </div>
</div>

<!-- ===== Main Content Container ===== -->
<div class="container">
  <h2>Explore Island Experiences</h2>

  <!-- === Guided Tour Hike === -->
  <div class="attraction-section row-reverse">
    <div class="attraction-text">
      <h3>Guided Tour Hike</h3>
      <p>Enjoy a group-led hike through the famous Gravel Point Preserve Hiking Trail.</p>
      <p>This scenic trail offers ocean overlooks, wildlife sightings, and relaxing forest paths. Our knowledgeable guide shares fun facts along the way!</p>
    </div>
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

  <!-- === Kayaking === -->
  <div class="attraction-section">
    <div class="attraction-text">
      <h3>Kayaking</h3>
      <p>Paddle through calm waters and explore sea caves and rocky island edges.</p>
      <p>Rent a kayak or join a group led by local paddlers. A great experience for beginners or pros with gear and safety equipment included.</p>
    </div>
    <div class="attraction-media">
      <div class="carousel">
        <img class="carousel-image active" src="images/Kayaking1.jpg" alt="Kayaking 1">
        <img class="carousel-image" src="images/Kayaking2.jpeg" alt="Kayaking 2">
        <img class="carousel-image" src="images/Kayaking3.jpeg" alt="Kayaking 3">
        <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
        <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
      </div>
    </div>
  </div>

  <!-- === Whale Watching === -->
  <div class="attraction-section row-reverse">
    <div class="attraction-text">
      <h3>Whale Watching</h3>
      <p>Board our eco-friendly boat for an unforgettable whale watching experience.</p>
      <p>Spot orcas, humpbacks, and sea lions while learning from our marine naturalist guide. A peaceful yet thrilling way to enjoy the island’s marine life.</p>
    </div>
    <div class="attraction-media">
      <div class="carousel">
        <img class="carousel-image active" src="images/Whale1.jpg" alt="Whale Watching 1">
        <img class="carousel-image" src="images/Whale2.jpg" alt="Whale Watching 2">
        <img class="carousel-image" src="images/Whale3.jpg" alt="Whale Watching 3">
        <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
        <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
      </div>
    </div>
  </div>

  <!-- === Scuba Diving === -->
  <div class="attraction-section">
    <div class="attraction-text">
      <h3>Scuba Diving</h3>
      <p>Dive beneath the surface into the vibrant underwater world surrounding Moffat Bay.</p>
      <p>Our certified dive instructors lead safe and exciting sessions among kelp forests, sea stars, and colorful fish. Gear rental and intro lessons available.</p>
    </div>
    <div class="attraction-media">
      <div class="carousel">
        <img class="carousel-image active" src="images/Scuba1.jpg" alt="Scuba 1">
        <img class="carousel-image" src="images/Scuba2.jpg" alt="Scuba 2">
        <img class="carousel-image" src="images/Scuba3.jpg" alt="Scuba 3">
        <button class="carousel-btn prev" onclick="moveSlide(this, -1)">❮</button>
        <button class="carousel-btn next" onclick="moveSlide(this, 1)">❯</button>
      </div>
    </div>
  </div>

  <!-- Call-to-action -->
  <div class="bottom-cta">
    <a href="#top" class="cta-button">↑ Back to Top</a>
    <!-- Optional: Replace with a "Book Now" link -->
    <!-- <a href="reservations.jsp" class="cta-button">Book Now</a> -->
  </div>
</div>

<!-- ===== Footer Include ===== -->
<jsp:include page="Foot.jsp" flush="true"></jsp:include>

<!-- ===== JavaScript for Carousel Functionality ===== -->
<script>
  function moveSlide(button, direction) {
    const carousel = button.closest(".carousel");
    const images = carousel.querySelectorAll(".carousel-image");
    const activeIndex = [...images].findIndex(img => img.classList.contains("active"));
    const nextIndex = (activeIndex + direction + images.length) % images.length;
    images[activeIndex].classList.remove("active");
    images[nextIndex].classList.add("active");
  }
</script>

</body>
</html>
