// 33. Products available in Black
db.products.find({ colors: "Black" })

// 34. Products available in both Black and Silver
db.products.find({ colors: { $all: ["Black", "Silver"] } })

// 35. Products available in either White or Blue
db.products.find({ colors: { $in: ["White", "Blue"] } })

// 36. Add Grey to product 101
db.products.updateOne({ product_id: 101 }, { $push: { colors: "Grey" } })

// 37. Add Black to product 101 without creating a duplicate
db.products.updateOne({ product_id: 101 }, { $addToSet: { colors: "Black" } })

// 38. Remove Red from product 102
db.products.updateOne({ product_id: 102 }, { $pull: { colors: "Red" } })

// 39. Products having more than one color
db.products.find({ "colors.1": { $exists: true } })
