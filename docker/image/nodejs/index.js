const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Merhaba Docker');
});

const PORT = 3070;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

