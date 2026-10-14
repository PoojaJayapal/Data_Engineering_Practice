use food_delivery_assessment

// Insert the 5 restaurants 
db.restaurants.insertMany([
  {
    restaurant_id: 101,
    restaurant_name: "Spice Kitchen",
    city: "Hyderabad",
    cuisine: ["Indian", "Biryani"],
    rating: 4.5,
    active: true,
    contact: { phone: "9876543210", email: "spice@email.com" }
  },
  {
    restaurant_id: 102,
    restaurant_name: "Urban Pizza",
    city: "Mumbai",
    cuisine: ["Italian", "Fast Food"],
    rating: 4.2,
    active: true,
    contact: { phone: "9988776655", email: "pizza@email.com" }
  },
  {
    restaurant_id: 103,
    restaurant_name: "Green Bowl",
    city: "Bangalore",
    cuisine: ["Healthy", "Vegetarian"],
    rating: 4.7,
    active: true,
    contact: { phone: "9123456780", email: "green@email.com" }
  },
  {
    restaurant_id: 104,
    restaurant_name: "Burger Point",
    city: "Hyderabad",
    cuisine: ["Fast Food", "Burgers"],
    rating: 3.9,
    active: false,
    contact: { phone: "9000011111", email: "burger@email.com" }
  },
  {
    restaurant_id: 105,
    restaurant_name: "Asian Wok",
    city: "Delhi",
    cuisine: ["Chinese", "Thai"],
    rating: 4.4,
    active: true,
    contact: { phone: "9222233333", email: "wok@email.com" }
  }
])

// 1. Display all restaurants
db.restaurants.find()

// 2. Restaurants from Hyderabad
db.restaurants.find({ city: "Hyderabad" })

// 3. Active restaurants with rating greater than 4.3
db.restaurants.find({rating: { $gt: 4.3 } })

// 4. Insert one new restaurant
db.restaurants.insertOne({
  restaurant_id: 106,
  restaurant_name: "Grand Chola",
  city: "Chennai",
  cuisine: ["South Indian", "Chinese"],
  rating: 4.6,
  active: true,
  contact: { phone: "9000700012", email: "chola@email.com" }
})

// 5. Change the rating of restaurant 104
db.restaurants.updateOne({ restaurant_id: 104 }, { $set: { rating: 4.1 } })

// 6. Change restaurant 104 from inactive to active
db.restaurants.updateOne({ restaurant_id: 104 }, { $set: { active: true } })

// 7. Delete the restaurant inserted in Question 4
db.restaurants.deleteOne({ restaurant_id: 106 })

// 8. Restaurants serving Fast Food
db.restaurants.find({ cuisine: "Fast Food" })

// 9. Restaurants serving both Italian and Fast Food
db.restaurants.find({ cuisine: { $all: ["Italian", "Fast Food"] } })

// 10. Add Desserts to the cuisine list of restaurant 102
db.restaurants.updateOne({ restaurant_id: 102 }, { $addToSet: { cuisine: "Desserts" } })

// 11. Change the email address of restaurant 103
db.restaurants.updateOne(
  { restaurant_id: 103 },
  { $set: { "contact.email": "xxxx@gmail.com" } }
)

// 12. Restaurants whose contact phone starts with 9
db.restaurants.find({ "contact.phone": { $regex: /^9/ } })
