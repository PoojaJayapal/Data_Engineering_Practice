// 40. Products whose warranty is 2 years
db.products.find({ "specifications.warranty_years": 2 })

// 41. Products where specifications.adjustable = true
db.products.find({ "specifications.adjustable": true })

// 42. Products with specifications.wireless = true
db.products.find({ "specifications.wireless": true })

// 43. Change warranty of product 103 from 3 to 5 years
db.products.updateOne({ product_id: 103 }, { $set: { "specifications.warranty_years": 5 } })

// 44. Add country_of_origin to two products (101 and 102)
db.products.updateOne({ product_id: 101 }, { $set: { "specifications.country_of_origin": "India" } })
db.products.updateOne({ product_id: 102 }, { $set: { "specifications.country_of_origin": "India" } })

// 45. Products manufactured in the country you added
db.products.find({ "specifications.country_of_origin": "India" })
