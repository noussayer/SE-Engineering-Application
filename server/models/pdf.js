const mongoose = require("mongoose");


const pdfSchema = mongoose.Schema({
    customer: {
        type: String,
        required: true,
        trim: true,
    },
    
  
    pdfs: [{
        type: String,
        required: true,
    }],
 
});


const Pdf = mongoose.model('Pdf', pdfSchema);
module.exports = Pdf;