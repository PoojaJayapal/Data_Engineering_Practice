use commerce_assessment

// 1. Display all products
db.products.find()

// 2. Display product 103
db.products.findOne({ product_id: 103 })

// 3. Insert product 107
db.products.insertOne({ product_id: 107, product_name: "Bluetooth Speaker", category: "Electronics", brand: "SoundMax", price: 7500, stock: 20, available: true })

// 4. Insert two more products in one operation
db.products.insertMany([
  { product_id: 108, product_name: "USB Hub", category: "Accessories", brand: "ConnectX", price: 1200, stock: 25, available: true },
  { product_id: 109, product_name: "Study Lamp", category: "Furniture", brand: "BrightHome", price: 2200, stock: 0, available: false }
])

// 5. Update price of product 102 to 2000
db.products.updateOne({ product_id: 102 }, { $set: { price: 2000 } })

// 6. Update stock and availability of product 105
db.products.updateOne({ product_id: 105 }, { $set: { stock: 10, available: true } })

// 7. Increase stock of product 104 by 10
db.products.updateOne({ product_id: 104 }, { $inc: { stock: 10 } })

// 8. Reduce stock of product 106 by 3
db.products.updateOne({ product_id: 106 }, { $inc: { stock: -3 } })

// 9. Add discount_percent to product 101
db.products.updateOne({ product_id: 101 }, { $set: { discount_percent: 10 } })

// 10. Remove discount_percent from product 101
db.products.updateOne({ product_id: 101 }, { $unset: { discount_percent: "" } })

// 11. Delete one product by product_id (before and after)
db.products.find({ product_id: 108 })
db.products.deleteOne({ product_id: 108 })
db.products.find({ product_id: 108 })

// 12. Delete all products where stock = 0 (before and after)
db.products.find({ stock: 0 })
db.products.deleteMany({ stock: 0 })
db.products.find({ stock: 0 })
// 13. Final check
db.products.find()
