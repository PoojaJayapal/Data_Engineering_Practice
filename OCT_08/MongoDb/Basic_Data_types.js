/**
 * MongoDB Data Types Practice Submission
 * Database: retail_db
 * Collection: datatype_practice
 */

// --- Prepare the data ---
use retail_db

db.datatype_practice.insertMany([
  {
    product_id: 501,
    product_name: "Laptop",
    price: 65000,
    stock: 10,
    available: true,
    launch_date: ISODate("2026-01-10"),
    colors: ["Black", "Silver"],
    details: { brand: "Dell", warranty_years: 2 }
  },
  {
    product_id: 502,
    product_name: "Headphones",
    price: 4500,
    stock: 25,
    available: true,
    launch_date: ISODate("2026-03-15"),
    colors: ["Black", "Blue"],
    details: { brand: "Sony", warranty_years: 1 }
  },
  {
    product_id: 503,
    product_name: "Office Chair",
    price: 9000,
    stock: 0,
    available: false,
    launch_date: ISODate("2025-12-20"),
    colors: ["Black", "Grey"],
    details: { brand: "GreenSoul", warranty_years: 3 }
  },
  {
    product_id: 504,
    product_name: "Smart Watch",
    price: 18000,
    stock: 8,
    available: true,
    launch_date: ISODate("2026-06-01"),
    colors: ["Black", "Red"],
    details: { brand: "Samsung", warranty_years: 1 }
  }
])

// --- Check Data ---
db.datatype_practice.find()


//  EXERCISES 

// 1. Display all products.
db.datatype_practice.find({})

// 2. Find the product named Laptop.
db.datatype_practice.find({ product_name: "Laptop" })

// 3. Find products whose price is greater than 10000.
db.datatype_practice.find({ price: { $gt: 10000 } })

// 4. Find products having stock less than 10.
db.datatype_practice.find({ stock: { $lt: 10 } })

// 5. Find products where available = true.
db.datatype_practice.find({ available: true })

// 6. Find products where available = false.
db.datatype_practice.find({ available: false })

// 7. Find products launched after 1 January 2026.
db.datatype_practice.find({ launch_date: { $gt: ISODate("2026-01-01") } })

// 8. Find products available in the color Black.
db.datatype_practice.find({ colors: "Black" })

// 9. Find products available in both Black and Blue.
db.datatype_practice.find({ colors: { $all: ["Black", "Blue"] } })

// 10. Find products where the brand is Samsung.
db.datatype_practice.find({ "details.brand": "Samsung" })

// 11. Find products having more than 1 year warranty.
db.datatype_practice.find({ "details.warranty_years": { $gt: 1 } })

// 12. Increase the stock of product 502 by 5.
db.datatype_practice.updateOne({ product_id: 502 }, { $inc: { stock: 5 } })

// 13. Change product 503 from unavailable to available.
db.datatype_practice.updateOne({ product_id: 503 }, { $set: { available: true } })

// 14. Add the color White to product 501.
db.datatype_practice.updateOne({ product_id: 501 }, { $push: { colors: "White" } })

// 15. Change the warranty of product 504 to 2 years.
db.datatype_practice.updateOne({ product_id: 504 }, { $set: { "details.warranty_years": 2 } })

// 16. Display only product_name and price.
db.datatype_practice.find({}, { product_name: 1, price: 1, _id: 0 })

// 17. Find the datatype of the price field using $type.
way 1 - db.datatype_practice.aggregate([
  { $project: { _id: 0, price_type: { $type: "$price" } } }
])

way 2 - db.datatype_practice.find(
  {},
{price:1,
price_type: {$type:"$price"},_id:0 })


// 18. Find the datatype of the available field.
way 1 - db.datatype_practice.aggregate([
  { $project: { _id: 0, available_type: { $type: "$available" } } }
])

way 2 - db.datatype_practice.find(
  {},
{available:1,
available_type: {$type:"$available"},_id:0 })

// 19. Find the datatype of the launch_date field.
way 1 - db.datatype_practice.aggregate([
  { $project: { _id: 0, launch_date_type: { $type: "$launch_date" } } }
])

way 2 - db.datatype_practice.find(
  {},
{launch_date:1,
launch_date_type: {$type:"$launch_date"},_id:0 })

// 20. Find the datatype of the colors field.
way 1 - db.datatype_practice.aggregate([
  { $project: { _id: 0, colors_type: { $type: "$colors" } } }
])

way 2 - db.datatype_practice.find(
  {},
{colors:1,
colors_type: {$type:"$colors"},_id:0 })
