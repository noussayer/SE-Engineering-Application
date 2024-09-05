const express = require('express');
const pdfRouter = express.Router();
const admin = require('../middelwares/admin');
const Pdf = require('../models/pdf');



// Add a pdf:
pdfRouter.post('/admin/add-pdf', admin, async (req, res) => {
    try {
        
        const {customer, pdfs} = req.body;
        let pdf = new Pdf({ 
            customer,
            pdfs
        });
        pdf = await pdf.save();
        res.json(pdf);


    } catch(e) {
        res.status(500).json({error: e.message});
    }
} );
// Get all the pdfs:
pdfRouter.get('/admin/get-pdfs', admin, async (req, res) => {
    try {
        const listPdfs = await Pdf.find({});
        res.json(listPdfs);

    } catch(e) {
        res.status(500).json({error: e.message});
    }

 });

 // Delete pdf:
 pdfRouter.post('/admin/delete-pdf', admin, async(req, res) => {
    try {
        const {id} = req.body;
        let pdf = await Pdf.findByIdAndDelete(id);
        
        res.json(pdf);

    } catch(e) {
        res.status(500).json({error: e.message});
    }

 });


// Search a pdf:

 pdfRouter.get('/pdfs/search/:customer', admin, async (req, res) => {
    try {
        const pdfs = await Pdf.find({
            customer: {$regex: req.params.customer, $options: "i"}
        });
        res.json(pdfs);

    } catch(e) {
        res.status(500).json({error: e.message});
    }

 });


module.exports = pdfRouter;
