// 61. Orders having status Delivered
db.orders.find({ status: "Delivered" })

// 62. Orders containing Ultra Laptop
db.orders.find({ "items.product": "Ultra Laptop" })

// 63. Orders containing an item with quantity greater than 1
db.orders.find({ "items.quantity": { $gt: 1 } })

// 64. Product = Smart Monitor AND quantity = 2 in the same item
db.orders.find({
  items: { $elemMatch: { product: "Smart Monitor", quantity: 2 } }
})

// 65. Add another item to order 9002
db.orders.updateOne(
  { order_id: 9002 },
  { $push: { items: { product: "Office Chair", quantity: 1, price: 8500 } } }
)

// 66. Change order 9002 status to Delivered
db.orders.updateOne({ order_id: 9002 }, { $set: { status: "Delivered" } })

// 67. Remove one item from an order (Mechanical Keyboard from order 9003)
db.orders.updateOne(
  { order_id: 9003 },
  { $pull: { items: { product: "Mechanical Keyboard" } } }
)
