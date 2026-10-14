db.createCollection("delivery_partners")
db.delivery_partners.insertMany([
  {
    partner_id: 301,
    partner_name: "Ravi Kumar",
    city: "Hyderabad",
    rating: 4.6,
    active: true,
    vehicle: "Bike",
    service_areas: ["Gachibowli", "Madhapur", "Kondapur"],
    contact: { phone: "9876501234", email: "ravi@delivery.com" }
  },
  {
    partner_id: 302,
    partner_name: "Sana Sheikh",
    city: "Mumbai",
    rating: 4.2,
    active: true,
    vehicle: "Scooter",
    service_areas: ["Andheri", "Bandra"],
    contact: { phone: "9988112233", email: "sana@delivery.com" }
  },
  {
    partner_id: 303,
    partner_name: "Arjun Reddy",
    city: "Hyderabad",
    rating: 3.8,
    active: false,
    vehicle: "Bicycle",
    service_areas: ["Banjara Hills", "Jubilee Hills"],
    contact: { phone: "9123450987", email: "arjun@delivery.com" }
  },
  {
    partner_id: 304,
    partner_name: "Meena Iyer",
    city: "Bangalore",
    rating: 4.8,
    active: true,
    vehicle: "Bike",
    service_areas: ["Koramangala", "Indiranagar"],
    contact: { phone: "9000123456", email: "meena@delivery.com" }
  }
])
//29. Find active delivery partners from Hyderabad
db.delivery_partners.find({city:"Hyderabad",active:true})
//30. Find partners with rating greater than 4 
db.delivery_partners.find({rating:{$gt:4}})
//31. Add a new service area to one partner.
db.delivery_partners.updateOne({partner_id:304},{$addToSet:{service_areas:"Chennai"}})
//32. Update one partner's rating
db.delivery_partners.updateOne({partner_id:304},{$set:{rating:5.0}})
//33. Sort all partners from highest rating to lowest
db.delivery_partners.find().sort({rating:-1})




