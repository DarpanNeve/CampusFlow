const express = require('express');
const app = express();
const port = 80;
// HTML content as a string
const htmlContent = `
<!DOCTYPE html>
<html>
<head>
  <title>Express HTML Response</title>
</head>
<body>
  <h1>Hello, Express!</h1>
  <p>This is a simple HTML response from an Express.js server.</p>
</body>
</html>
`;

// Serve the HTML content as a response
app.get('/', (req, res) => {
  res.send(htmlContent);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

