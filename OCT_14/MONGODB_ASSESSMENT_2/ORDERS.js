use food_delivery_assessment
db.createCollection("orders")
db.orders.insertMany([
    {
        order_id: 5001,
        restaurant_id: 101,
        customer_name: "Adil",
        order_date: ISODate("2026-09-01"),
        status: "Delivered",
        items: [
            { name: "Chicken Biryani", quantity: 2, price: 320 },
            { name: "Coke", quantity: 2, price: 60 }
        ],
        delivery: {
            city: "Hyderabad",
            fee: 40
        }
    },
    {
        order_id: 5002,
        restaurant_id: 102,
        customer_name: "Megha",
        order_date: ISODate("2026-09-02"),
        status: "Processing",
        items: [
            { name: "Farmhouse Pizza", quantity: 1, price: 550 }
        ],
        delivery: {
            city: "Mumbai",
            fee: 60
        }
    },
    {
        order_id: 5003,
        restaurant_id: 103,
        customer_name: "Kabir",
        order_date: ISODate("2026-09-03"),
        status: "Delivered",
        items: [
            { name: "Protein Bowl", quantity: 2, price: 400 },
            { name: "Juice", quantity: 1, price: 150 }
        ],
        delivery: {
            city: "Bangalore",
            fee: 50
        }
    },
    {
        order_id: 5004,
        restaurant_id: 101,
        customer_name: "Nisha",
        order_date: ISODate("2026-09-04"),
        status: "Cancelled",
        items: [
            { name: "Veg Biryani", quantity: 1, price: 250 }
        ],
        delivery: {
            city: "Hyderabad",
            fee: 40
        }
    },
    {
        order_id: 5005,
        restaurant_id: 105,
        customer_name: "Rohan",
        order_date: ISODate("2026-09-05"),
        status: "Delivered",
        items: [
            { name: "Thai Curry", quantity: 1, price: 480 },
            { name: "Noodles", quantity: 2, price: 300 }
        ],
        delivery: {
            city: "Delhi",
            fee: 70
        }
    }
])

// 13. Find all Delivered orders
db.orders.find({ status: "Delivered" })

// 14. Orders placed after 2026-09-02
db.orders.find({ order_date: { $gt: ISODate("2026-09-02") } })

// 15. Orders delivered to Hyderabad
db.orders.find({ "delivery.city": "Hyderabad" })

// 16. Orders containing an item named Noodles
db.orders.find({ "items.name": "Noodles" })

// 17. Orders containing an item where quantity is greater than 1
db.orders.find({ "items.quantity": { $gt: 1 } })

// 18. Same item has name = Chicken Biryani AND quantity = 2
db.orders.find({
  items: { $elemMatch: { name: "Chicken Biryani", quantity: 2 } }
})

// 19. Add another item to order 5002
db.orders.updateOne(
  { order_id: 5002 },
  { $push: { items: { name: "Ice Cream", quantity: 2, price: 45 } } }
)

// 20. Change order 5002 from Processing to Delivered
db.orders.updateOne({ order_id: 5002 }, { $set: { status: "Delivered" } })
