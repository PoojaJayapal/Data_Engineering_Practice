// Create the collection
db.createCollection("suppliers")

// Insert 5 suppliers (run this only once)
db.suppliers.insertMany([
  {
    supplier_id: 7001,
    supplier_name: "TechSource Distributors",
    city: "Hyderabad",
    active: true,
    categories: ["Electronics", "Accessories"],
    contact: { person: "Ravi Kumar", email: "ravi@techsource.com", phone: "9876543210" },
    warehouses: ["Hyderabad", "Bengaluru"],
    registered_on: ISODate("2025-11-12")
  },
  {
    supplier_id: 7002,
    supplier_name: "HomeNest Furnishings",
    city: "Chennai",
    active: true,
    categories: ["Furniture", "Home"],
    contact: { person: "Meena Iyer", email: "meena@homenest.com", phone: "9123456780" },
    warehouses: ["Chennai", "Coimbatore"],
    registered_on: ISODate("2026-01-20")
  },
  {
    supplier_id: 7003,
    supplier_name: "GadgetWorld Traders",
    city: "Mumbai",
    active: false,
    categories: ["Electronics", "Accessories", "Gaming"],
    contact: { person: "Sana Khan", email: "sana@gadgetworld.com", phone: "9988776655" },
    warehouses: ["Mumbai", "Pune"],
    registered_on: ISODate("2026-02-15")
  },
  {
    supplier_id: 7004,
    supplier_name: "OfficeEase Supplies",
    city: "Hyderabad",
    active: true,
    categories: ["Furniture", "Stationery"],
    contact: { person: "Arjun Reddy", email: "arjun@officeease.com", phone: "9012345678" },
    warehouses: ["Hyderabad", "Vijayawada"],
    registered_on: ISODate("2025-08-05")
  },
  {
    supplier_id: 7005,
    supplier_name: "PowerPlus Electronics",
    city: "Delhi",
    active: true,
    categories: ["Electronics", "Home"],
    contact: { person: "Neha Gupta", email: "neha@powerplus.com", phone: "9345612780" },
    warehouses: ["Delhi", "Noida", "Jaipur"],
    registered_on: ISODate("2026-03-10")
  }
])

// 76. Display all active suppliers
db.suppliers.find({ active: true })

// 77. Suppliers from Hyderabad
db.suppliers.find({ city: "Hyderabad" })

// 78. Suppliers handling Electronics
db.suppliers.find({ categories: "Electronics" })

// 79. Suppliers registered after 1 January 2026
db.suppliers.find({ registered_on: { $gt: ISODate("2026-01-01") } })

// 80. Add another warehouse to supplier 7001
db.suppliers.updateOne({ supplier_id: 7001 }, { $addToSet: { warehouses: "Chennai" } })

// 81. Change the active status of supplier 7003 to true
db.suppliers.updateOne({ supplier_id: 7003 }, { $set: { active: true } })

// 82. Remove one category (Gaming) from supplier 7003
db.suppliers.updateOne({ supplier_id: 7003 }, { $pull: { categories: "Gaming" } })

// 83. Display supplier name and city only
db.suppliers.find({}, { supplier_name: 1, city: 1, _id: 0 })

// 84. Sort suppliers by registration date (oldest first)
db.suppliers.find().sort({ registered_on: 1 })

// 85. Design explanations

// Array for categories:
// A supplier handles several categories, and each one is just a simple string.
// An array holds the list in one field and lets you query it directly,
// like categories: "Electronics", and change it with $addToSet and $pull.

// Embedded document for contact details:
// Person, email and phone describe one contact and are always read together
// with the supplier. Grouping them under contact keeps the document organised,
// and you can reach a single field with "contact.email".

// Array for warehouse locations:
// A supplier can have two or more warehouses, and the number can change over time.
// An array stores the list in one field and lets you add or remove locations
// easily with $push or $pull. Each location is a simple value here.
// If you later needed details for each warehouse (address, capacity),
// you would switch to an array of embedded documents.
