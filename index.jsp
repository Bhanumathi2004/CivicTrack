<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Civic Track – Your Voice, Our Priority</title>

<!-- ❤ Minimal external helpers -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">

<style>
:root{
  --grad:linear-gradient(135deg,#667eea 0%,#764ba2 100%);
  --glass:rgba(255,255,255,.15);
}
body{min-height:100vh;font-family:'Inter',sans-serif;background:var(--grad);color:#fff;overflow-x:hidden}
.navbar{backdrop-filter:blur(12px);background:var(--glass);transition:.3s}
.navbar.scrolled{background:rgba(0,0,0,.25)}
.hero{min-height:100vh;display:flex;align-items:center;text-align:center;padding-top:5rem}
.hero h1{font-size:clamp(2.5rem,7vw,4.5rem);font-weight:800}
.glass-card{background:var(--glass);backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.25);border-radius:1.5rem}
.feature-card:hover{transform:translateY(-6px)}
.stats{padding:4rem 0}
.counter{font-size:2.5rem;font-weight:700}
.particle{position:fixed;border-radius:50%;background:rgba(255,255,255,.12);animation:float 14s linear infinite}
@keyframes float{0%{transform:translateY(100vh)}100%{transform:translateY(-120px)}}
</style>
</head>

<body>
<!-- Simple floating particles -->
<div class="particle" style="width:6px;height:6px;left:10%;animation-delay:-2s"></div>
<div class="particle" style="width:4px;height:4px;left:30%;animation-delay:-4s"></div>
<div class="particle" style="width:5px;height:5px;left:70%;animation-delay:-6s"></div>

<!-- Nav -->
<nav id="mainNav" class="navbar navbar-expand-lg fixed-top">
  <div class="container">
    <a class="navbar-brand fw-bold text-white" href="#"><i class="fa-solid fa-shield-alt me-2"></i>Civic Track</a>
    <button class="navbar-toggler bg-light" data-bs-toggle="collapse" data-bs-target="#navLinks">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navLinks" class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link text-white" href="#features">Features</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="#stats">Stats</a></li>
        <li class="nav-item"><a class="nav-link text-white" href="login.jsp">Login</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero -->
<section class="hero d-flex flex-column justify-content-center">
  <div class="container">
    <p class="badge bg-light text-dark mb-3 px-3 py-2">Your Voice Matters</p>
    <h1 class="mb-3 animate__animated animate__fadeInUp">Report. Track. Resolve.</h1>
    <p class="lead mb-4">Empowering citizens to build better communities.</p>
    <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
      <a href="filecomplaint.jsp" class="btn btn-light px-4 fw-semibold"><i class="fa fa-plus-circle me-2"></i>Report Issue</a>
      <a href="register.jsp" class="btn btn-outline-light px-4 fw-semibold"><i class="fa fa-user-plus me-2"></i>Register</a>
    </div>
  </div>
</section>

<!-- Features -->
<section id="features" class="py-5">
  <div class="container text-center">
    <h2 class="mb-5 fw-bold">Why Choose Civic Track?</h2>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="glass-card p-4 feature-card h-100">
          <i class="fa fa-rocket fa-2x mb-3"></i>
          <h5 class="fw-semibold">Fast Reporting</h5>
          <p class="small">Submit complaints with photos & location in seconds.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="glass-card p-4 feature-card h-100">
          <i class="fa fa-eye fa-2x mb-3"></i>
          <h5 class="fw-semibold">Live Tracking</h5>
          <p class="small">Watch progress from submission to resolution.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="glass-card p-4 feature-card h-100">
          <i class="fa fa-shield-check fa-2x mb-3"></i>
          <h5 class="fw-semibold">Data Security</h5>
          <p class="small">Enterprise-grade security with optional anonymity.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Stats -->
<section id="stats" class="stats text-center">
  <div class="container">
    <div class="row g-4">
      <div class="col-6 col-md-3"><div class="glass-card py-4"><div class="counter" data-count="2500">0</div><p>Issues Resolved</p></div></div>
      <div class="col-6 col-md-3"><div class="glass-card py-4"><div class="counter" data-count="10000">0</div><p>Active Users</p></div></div>
      <div class="col-6 col-md-3"><div class="glass-card py-4"><div class="counter" data-count="50">0</div><p>Cities Covered</p></div></div>
      <div class="col-6 col-md-3"><div class="glass-card py-4"><div class="counter" data-count="98">0</div><p>Success Rate %</p></div></div>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="py-4 bg-dark text-white text-center">
  © 2025 Civic Track – Made in India
</footer>

<!-- JS: Bootstrap + lightweight helpers -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/countup.js/2.6.2/countUp.umd.js"></script>
<script>
// Navbar glass effect
window.addEventListener('scroll',()=>document.getElementById('mainNav')
  .classList.toggle('scrolled',scrollY>50));

// Animate counters when visible
const io=new IntersectionObserver(ent=>{
  ent.forEach(e=>{
    if(e.isIntersecting){
      const el=e.target, end=+el.dataset.count||0;
      new countUp.CountUp(el,end,{duration:2}).start();
      io.unobserve(el);
    }
  });
},{threshold:.6});
document.querySelectorAll('.counter').forEach(el=>io.observe(el));
</script>
</body>
</html>
