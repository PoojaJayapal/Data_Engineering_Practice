use commerce_assessment

db.createCollection("products")

db.products.insertMany([
  {
    product_id: 101,
    product_name: "Ultra Laptop",
    category: "Electronics",
    brand: "TechPro",
    price: 72000,
    stock: 12,
    available: true,
    launch_date: ISODate("2026-01-15"),
    colors: ["Black", "Silver"],
    specifications: { ram: "16 GB", storage: "1 TB SSD", warranty_years: 2 }
  },
  {
    product_id: 102,
    product_name: "Wireless Mouse",
    category: "Accessories",
    brand: "ClickMax",
    price: 1800,
    stock: 40,
    available: true,
    launch_date: ISODate("2026-02-10"),
    colors: ["Black", "Blue", "Red"],
    specifications: { wireless: true, warranty_years: 1 }
  },
  {
    product_id: 103,
    product_name: "Office Desk",
    category: "Furniture",
    brand: "WorkSpace",
    price: 14500,
    stock: 8,
    available: true,
    launch_date: ISODate("2025-11-20"),
    colors: ["Brown", "Black"],
    specifications: { material: "Wood", adjustable: false, warranty_years: 3 }
  },
  {
    product_id: 104,
    product_name: "Smart Monitor",
    category: "Electronics",
    brand: "VisionPlus",
    price: 26000,
    stock: 5,
    available: true,
    launch_date: ISODate("2026-03-01"),
    colors: ["Black"],
    specifications: { screen_size: "27 inch", resolution: "4K", warranty_years: 2 }
  },
  {
    product_id: 105,
    product_name: "Gaming Chair",
    category: "Furniture",
    brand: "SeatPro",
    price: 18500,
    stock: 0,
    available: false,
    launch_date: ISODate("2026-01-05"),
    colors: ["Black", "Red"],
    specifications: { material: "Leather", adjustable: true, warranty_years: 3 }
  },
  {
    product_id: 106,
    product_name: "Mechanical Keyboard",
    category: "Accessories",
    brand: "KeyWorks",
    price: 5200,
    stock: 18,
    available: true,
    launch_date: ISODate("2026-04-12"),
    colors: ["Black", "White"],
    specifications: { backlit: true, wireless: false, warranty_years: 1 }
  }
])
