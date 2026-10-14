// 14. All Electronics products
db.products.find({ category: "Electronics" })

// 15. Price more than 10,000
db.products.find({ price: { $gt: 10000 } })

// 16. Price between 5,000 and 30,000 (inclusive)
db.products.find({ price: { $gte: 5000, $lte: 30000 } })

// 17. Stock less than 10
db.products.find({ stock: { $lt: 10 } })

// 18. Currently available
db.products.find({ available: true })

// 19. Not available
db.products.find({ available: false })

// 20. Electronics or Furniture
db.products.find({ category: { $in: ["Electronics", "Furniture"] } })

// 21. Not in Accessories
db.products.find({ category: { $ne: "Accessories" } })

// 22. price > 10000 AND stock > 5
db.products.find({ price: { $gt: 10000 }, stock: { $gt: 5 } })
// explicit form: { $and: [ { price: { $gt: 10000 } }, { stock: { $gt: 5 } } ] }

// 23. category = Electronics OR price < 5000
db.products.find({ $or: [ { category: "Electronics" }, { price: { $lt: 5000 } } ] })

// 24. Launched after 1 Feb 2026
db.products.find({ launch_date: { $gt: ISODate("2026-02-01") } })

// 25. Launched between 1 Jan 2026 and 31 Mar 2026 (inclusive)
db.products.find({
  launch_date: { $gte: ISODate("2026-01-01"), $lt: ISODate("2026-04-01") }
})
