// 26. Display only product_name and price (hide _id)
db.products.find({}, { product_name: 1, price: 1, _id: 0 })

// 27. Display product_name, category and stock
db.products.find({}, { product_name: 1, category: 1, stock: 1 })

// 28. Sort by price, lowest to highest
db.products.find().sort({ price: 1 })

// 29. Sort by price, highest to lowest
db.products.find().sort({ price: -1 })

// 30. Sort alphabetically by product_name
db.products.find().sort({ product_name: 1 })

// 31. Three most expensive products
db.products.find().sort({ price: -1 }).limit(3)

// 32. Two products with the lowest stock
db.products.find().sort({ stock: 1 }).limit(2)
