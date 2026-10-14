// 46. Price stored as a numeric type
db.products.find({ price: { $type: "number" } })

// 47. Datatype of launch_date
db.products.aggregate([
  { $project: { _id: 0, product_name: 1, launch_type: { $type: "$launch_date" } } }
])

// 48. Datatype of colors
db.products.aggregate([
  { $project: { _id: 0, product_name: 1, colors_type: { $type: "$colors" } } }
])

// 49. Datatype of specifications
db.products.aggregate([
  { $project: { _id: 0, product_name: 1, specs_type: { $type: "$specifications" } } }
])

// 50. Insert one intentionally incorrect product (price as a string)
db.products.insertOne({
  product_id: 999,
  product_name: "Test Speaker",
  category: "Electronics",
  brand: "SoundMax",
  price: "25000",
  stock: 20,
  available: true,
  launch_date: ISODate("2026-03-10T00:00:00.000Z"),
  colors: ["Black"],
  specifications: { warranty_years: 1 }
})

// 51. Products where price is stored as a string
db.products.find({ price: { $type: "string" } })

// 52. Correct the price so it becomes numeric
db.products.updateOne({ product_id: 999 }, { $set: { price: 25000 } })
