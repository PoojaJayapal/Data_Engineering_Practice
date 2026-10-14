// Switch to the database
use commerce_assessment

// Create the collection
db.createCollection("customers")

// Insert the 4 customers 
db.customers.insertMany([
  {
    customer_id: 501,
    customer_name: "Aditya Rao",
    email: "aditya@email.com",
    active: true,
    address: { city: "Hyderabad", state: "Telangana", pincode: "500081" },
    interests: ["Electronics", "Accessories"]
  },
  {
    customer_id: 502,
    customer_name: "Maya Thomas",
    email: "maya@email.com",
    active: true,
    address: { city: "Chennai", state: "Tamil Nadu", pincode: "600028" },
    interests: ["Furniture", "Home"]
  },
  {
    customer_id: 503,
    customer_name: "Faisal Ahmed",
    email: "faisal@email.com",
    active: false,
    address: { city: "Hyderabad", state: "Telangana", pincode: "500034" },
    interests: ["Electronics"]
  },
  {
    customer_id: 504,
    customer_name: "Nikita Shah",
    email: "nikita@email.com",
    active: true,
    address: { city: "Mumbai", state: "Maharashtra", pincode: "400050" },
    interests: ["Furniture", "Electronics"]
  }
])

// 53. Display all customers
db.customers.find()

// 54. Find active customers
db.customers.find({ active: true })

// 55. Find customers from Hyderabad
db.customers.find({ "address.city": "Hyderabad" })

// 56. Find customers interested in Electronics
db.customers.find({ interests: "Electronics" })

// 57. Find customers interested in both Furniture and Electronics
db.customers.find({ interests: { $all: ["Furniture", "Electronics"] } })

// 58. Change customer 503 from inactive to active
db.customers.updateOne({ customer_id: 503 }, { $set: { active: true } })

// 59. Change customer 504's city (Mumbai -> Pune)
db.customers.updateOne({ customer_id: 504 }, { $set: { "address.city": "Pune" } })

// 60. Add a new interest to customer 502
db.customers.updateOne({ customer_id: 502 }, { $addToSet: { interests: "Electronics" } })
