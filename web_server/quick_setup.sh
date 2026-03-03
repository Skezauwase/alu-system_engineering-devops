#!/bin/bash
# Quick 404 page setup - run on your Ubuntu server via SSH

# Kill error if anything fails
set -e

# Create 404.html with the beautiful design
sudo tee /var/www/html/404.html > /dev/null << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Poppins:wght@300;500;700&display=swap');
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #e0e0e0;
            position: relative;
            overflow: hidden;
        }
        .shape {
            position: absolute;
            opacity: 0.1;
            border-radius: 50%;
            pointer-events: none;
        }
        .shape-1 {
            width: 300px;
            height: 300px;
            background: #ff6b6b;
            top: -100px;
            right: -100px;
            animation: moveShape 8s ease-in-out infinite;
        }
        .shape-2 {
            width: 250px;
            height: 250px;
            background: #4ecdc4;
            bottom: -80px;
            left: -80px;
            animation: moveShape 10s ease-in-out infinite reverse;
        }
        .shape-3 {
            width: 200px;
            height: 200px;
            background: #fff;
            top: 50%;
            left: 10%;
            animation: moveShape 12s ease-in-out infinite;
        }
        @keyframes moveShape {
            0%, 100% { transform: translate(0, 0); }
            50% { transform: translate(30px, 30px); }
        }
        .container {
            text-align: center;
            z-index: 10;
            max-width: 600px;
            padding: 40px;
            animation: slideIn 0.8s ease-out;
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .error-number {
            font-family: 'Space Mono', monospace;
            font-size: 120px;
            font-weight: 700;
            background: linear-gradient(45deg, #ff6b6b, #ffd93d, #6bcf7f);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: 10px;
            animation: pulse 2s ease-in-out infinite;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        .error-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .separator {
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #ff6b6b, #ffd93d, #6bcf7f);
            margin: 20px auto;
            border-radius: 2px;
        }
        .error-message {
            font-size: 18px;
            color: #b0b0b0;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .info-box {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 25px;
            margin: 30px 0;
            backdrop-filter: blur(10px);
        }
        .reason-list {
            list-style: none;
            text-align: left;
            margin: 0;
        }
        .reason-list li {
            padding: 10px 0;
            padding-left: 30px;
            position: relative;
            color: #a0a0a0;
            font-size: 16px;
        }
        .reason-list li::before {
            content: "●";
            position: absolute;
            left: 0;
            color: #6bcf7f;
            font-weight: bold;
        }
        .return-btn {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #6bcf7f, #4ecdc4);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            margin-top: 15px;
            cursor: pointer;
        }
        .return-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(107, 207, 127, 0.3);
            background: linear-gradient(135deg, #4ecdc4, #6bcf7f);
        }
        @media (max-width: 600px) {
            .error-number { font-size: 80px; }
            .error-title { font-size: 24px; }
            .container { padding: 20px; }
            .error-message { font-size: 16px; }
        }
    </style>
</head>
<body>
    <div class="shape shape-1"></div>
    <div class="shape shape-2"></div>
    <div class="shape shape-3"></div>
    <div class="container">
        <div class="error-number">404</div>
        <div class="error-title">Page Not Found</div>
        <div class="separator"></div>
        <p class="error-message">We're sorry! The page you are looking for doesn't exist or has been moved.</p>
        <div class="info-box">
            <ul class="reason-list">
                <li>The URL you entered may be incorrect</li>
                <li>The page might have been removed or deleted</li>
                <li>The resource may be temporary unavailable</li>
            </ul>
        </div>
        <a href="/" class="return-btn">Go Back Home</a>
    </div>
</body>
</html>
EOF

# Set permissions
sudo chmod 644 /var/www/html/404.html

# Add error_page to nginx config
if ! grep -q "error_page 404" /etc/nginx/sites-enabled/default; then
    sudo sed -i '/server_name _;/a\    error_page 404 /404.html;' /etc/nginx/sites-enabled/default
fi

# Test and restart
sudo nginx -t && sudo systemctl restart nginx && echo "✓ DONE! Visit http://skeza.tech/abc to test"
