<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registration Successful</title>

  <!-- Google Font & Font Awesome -->
  <link
    href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
    rel="stylesheet"/>
  <link
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    rel="stylesheet"/>

  <style>
    :root {
      --card-bg: rgba(255,255,255,0.8);
      --primary: #48bb78;
      --primary-dark: #38a169;
      --text-dark: #2d3748;
      --text-muted: #4a5568;
      --accent: #667eea;
      --accent2: #764ba2;
    }

    body {
      margin: 0;
      padding: 0;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      background: linear-gradient(135deg, var(--accent), var(--accent2));
      font-family: 'Poppins', sans-serif;
      overflow: hidden;
    }

    /* Floating circles */
    body::before,
    body::after {
      content: '';
      position: absolute;
      border-radius: 50%;
      background: rgba(255,255,255,0.2);
      animation: float 8s infinite ease-in-out;
    }
    body::before {
      width: 300px;
      height: 300px;
      top: -100px;
      left: -100px;
    }
    body::after {
      width: 200px;
      height: 200px;
      bottom: -80px;
      right: -80px;
      animation-duration: 10s;
    }
    @keyframes float {
      0%,100% { transform: translate(0,0) scale(1); }
      50%     { transform: translate(20px,20px) scale(1.1); }
    }

    /* Card */
    .success-container {
      position: relative;
      z-index: 1;
      background: var(--card-bg);
      backdrop-filter: blur(10px);
      padding: 2.5rem 2rem;
      border-radius: 1rem;
      box-shadow: 0 16px 40px rgba(0,0,0,0.1);
      max-width: 380px;
      width: 100%;
      text-align: center;
      animation: fadeInUp 0.8s ease-out both;
    }
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(50px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .success-icon {
      font-size: 4rem;
      color: var(--primary);
      animation: pop 0.6s ease-out both;
    }
    @keyframes pop {
      0%   { transform: scale(0); }
      60%  { transform: scale(1.2); }
      100% { transform: scale(1); }
    }

    h1 {
      margin: 1rem 0 0.5rem;
      font-size: 1.75rem;
      color: var(--text-dark);
    }

    p {
      margin: 0 0 1.5rem;
      color: var(--text-muted);
      font-size: 1rem;
      line-height: 1.4;
    }

    .btn-home {
      display: inline-block;
      padding: 0.75rem 1.75rem;
      font-weight: 600;
      color: #fff;
      background: var(--primary);
      border-radius: 2rem;
      text-decoration: none;
      transition: background 0.3s, transform 0.2s;
    }
    .btn-home:hover {
      background: var(--primary-dark);
      transform: scale(1.05);
    }
  </style>
</head>
<body>

  <div class="success-container">
    <i class="fas fa-user-check success-icon"></i>
    <h1>Registration Successful!</h1>
    <p>Thank you for registering. Welcome aboard!</p>
    <a href="Provider.jsf" class="btn-home">Go to Home</a>

  </div>

  <script
    src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js">
  </script>
</body>
</html>