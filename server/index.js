// Import from packages:
const express = require('express');
const mongoose = require('mongoose');


// Import from other files:
const authRouter = require("./routes/auth");
const adminRouter = require('./routes/admin');
const productRouter = require("./routes/product");
const pdfRouter = require('./routes/pdf');


// INIT:
const PORT = 3000;
const app = express();
const DB= "mongodb+srv://SEengineering:SeEngineering2024%40%40@cluster0.nzerbju.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"


// Middleware:
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(pdfRouter);


// Connection:
mongoose
.connect(DB)
.then( () => {
    console.log('Connection Successful');
}).catch(e => {
    console.log(e);
});




app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
});