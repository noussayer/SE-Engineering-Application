const mongoose = require('mongoose');


const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re= /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message: "Please Enter a valid email adress",
        }

        },
    password: {
        required: true,
        type: String,

    },
    adress: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'admin',
    }
    
    
})

const User = mongoose.model('User', userSchema);
module.exports = User;