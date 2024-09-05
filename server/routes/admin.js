const express = require('express');
const adminRouter = express.Router();
const admin = require('../middelwares/admin');
const Product = require('../models/product');
const auth = require('../middelwares/auth');
const mongoose = require('mongoose');



// Add a PRODUCT:
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const {name, description, images, date, customer, category} = req.body;
        let product = new Product({
            name,
            description,
            images,
            date,
            customer,
            category,
        });
        product = await product.save();
        res.json(product);


    } catch(e) {
        res.status(500).json({error: e.message});
    }
} );

// Get all the products:
 adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);

    } catch(e) {
        res.status(500).json({error: e.message});
    }

 });

 // Delete the product: 
 adminRouter.post('/admin/delete-product', admin, async(req, res) => {
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        
        res.json(product);

    } catch(e) {
        res.status(500).json({error: e.message});
    }

 })

 // update the product:
 
 

 adminRouter.put('/admin/update-product/:id', admin, async (req, res) => {
  try {
    const id = req.params.id;
    const updatedProduct = await Product.findByIdAndUpdate(id, req.body, { new: true });
    if (!updatedProduct) {
      return res.status(404).send({ message: 'Product not found' });
    }
    res.send(updatedProduct);
  } catch (error) {
    res.status(500).send({ message: 'Error updating product' });
  }

});

module.exports = adminRouter;

