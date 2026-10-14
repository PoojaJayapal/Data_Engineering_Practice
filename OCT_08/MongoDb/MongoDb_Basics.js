// -- Basics and CRUD Operations --

db.products.insertOne({
    product_id: 101,
    product_name: "Wireless Mouse",
    category: "Electronics",
    brand: "Logitech",
    price: 1500,
    stock: 25,
    available: true
})

db.products.insertMany([
    {
        product_id: 102,
        product_name: "Mechanical Keyboard",
        category: "Electronics",
        brand: "Keychron",
        price: 4500,
        stock: 15,
        available: true
    },
    {
        product_id: 103,
        product_name: "Office Chair",
        category: "Furniture",
        brand: "GreenSoul",
        price: 8500,	
        stock: 8,
        available: true
    },
    {
        product_id: 104,
        product_name: "Laptop Stand",
        category: "Accessories",
        brand: "Portronics",
        price: 1800,
        stock: 20,
        available: true
    },
    {
        product_id: 105,
        product_name: "27 Inch Monitor",
        category: "Electronics",
        brand: "Samsung",
        price: 18000,
        stock: 10,
        available: true
    },
    {
        product_id: 106,
        product_name: "Study Table",
        category: "Furniture",
        brand: "UrbanWood",
        price: 12000,
        stock: 5,
        available: false
    }
])

db.products.find()

db.products.findOne({product_id: 103})

db.products.find({category: 'Electronics'})

db.products.find({
    price: {
        $gt: 5000
    }
})

db.products.find({
    category: "Electronics",
    price: {
        $gt: 2000
    }
})

db.products.find(
    {},
    {
        product_name: 1,
        price: 1,
        _id: 0
    }
)

db.products.updateOne({
	product_id: 101 }, 
	{$set: {
		price: 1700
	}
})

db.products.updateOne({
	product_id: 106 }, 
	{$set: {
		price: 11000, 
		stock: 12, 
		available: 'true'
	}
})

db.products.updateOne({
	product_id: 102 }, 
	{$inc: {
		stock: 5
	}
})

db.products.updateMany({
	category: 'Electronics' }, 
	{$mul: {
		price: 1.10
	}
})

db.products.deleteOne({product_id: 104})

------------------------------------------------------------------------------

db.createCollection("products_schema_demo")

// -- Different types of document storages --

db.products_schema_demo.insertMany([
    {
        product_id: 101,
        product_name: "Laptop",
        category: "Electronics",
        price: 65000,
        stock: 10
    },
    {
        product_id: 102,
        name: "Wireless Mouse",
        category: "Electronics",
        price: "1500", -- int not string
        stock: 25
    },
    {
        product_id: 103,
        product_name: "Office Chair",
        category: "Furniture",
        price: 8500,
        quantity: 12 -- stock not quantity
    },
    {
        product_id: 104,
        product_name: "Keyboard",
        category: 100, -- string not int
        price: 2500,
        stock: "20" -- int not string
    }
]) -- Schema less so we can store any field as any data type --
 
// -- Flat document storage --
db.products_structure.insertOne({
    product_id: 201,
    product_name: "Gaming Laptop",
    brand: "Lenovo",
    category: "Electronics",
    price: 85000,
    ram: "16 GB",
    storage: "1 TB SSD",
    processor: "Intel Core i7"
})

// -- Nested document Storage --
db.products_structure.insertOne({
    product_id: 202,
    product_name: "Gaming Laptop",
    brand: "Lenovo",
    category: "Electronics",
    price: 85000,

    specifications: {
        ram: "16 GB",
        storage: "1 TB SSD",
        processor: "Intel Core i7"
    }
})

db.products_structure.insertOne({
    product_id: 203,
    product_name: "Office Desk",
    category: "Furniture",
    price: 12000,

    supplier: {
        supplier_name: "Home Furnishings",
        city: "Hyderabad",
        phone: "9876543210"
    }
})

// -- Array Storage --
db.products_structure.insertOne({
    product_id: 204,
    product_name: "Running Shoes",
    category: "Footwear",
    price: 4500,

    colors: [
        "Black",
        "White",
        "Blue"
    ]
})

db.products_structure.find({
    colors: "Black"
})

// -- Embedded Document Storage --
db.products_structure.insertOne({
    product_id: 205,
    product_name: "Smart Watch",
    category: "Electronics",
    price: 15000,

    reviews: [
        {
            customer: "Rohan",
            rating: 5,
            comment: "Excellent"
        },
        {
            customer: "Meera",
            rating: 4,
            comment: "Good battery"
        },
        {
            customer: "Kabir",
            rating: 3,
            comment: "Average display"
        }
    ]
})

// -- Datatypes in MongoDB --
db.createCollection("datatype_demo")

db.datatype_demo.insertOne({
    product_id: 301,

    product_name: "Smart TV",              // String

    price: 45999.99,                       // Double

    stock: NumberInt(25),                  // Integer

    total_views: NumberLong(150000),        // Long

    available: true,                       // Boolean

    launch_date: ISODate("2026-10-01"),    // Date

    discount: null,                        // Null

    tags: [
        "Electronics",
        "Smart TV",
        "4K"
    ],                                     // Array

    specifications: {
        screen_size: "55 inch",
        resolution: "4K",
        wifi: true
    },                                     // Embedded Document

    product_code: ObjectId()               // ObjectId
})

// -- Data type reference table --

| Data Type | Example |
| String | 	"Laptop" |  
| Integer |	NumberInt(10) | 
| Long	| NumberLong(100000) | 
| Double	| 45999.99 | 
| Decimal	| NumberDecimal("45999.99") | 
| Boolean	| true / false | 
| Date	| ISODate("2026-10-01") | 
| Null	| null | 
| Array	| ["Black", "Blue"] | 
| Object / Document | 	{ ram: "16 GB" } | 
| ObjectId	| ObjectId(...) | 
