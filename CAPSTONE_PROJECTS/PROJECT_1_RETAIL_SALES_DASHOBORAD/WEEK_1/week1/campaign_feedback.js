
use("retail_sales_db");

// 1. Create the campaign feedback collection
if (!db.getCollectionNames().includes("campaign_feedback")) {
    db.createCollection("campaign_feedback");
}

// 2. Insert promotional campaign feedback
db.campaign_feedback.insertMany([
    {
        campaign_id: 101,
        campaign_name: "Diwali Sale",
        store_id: 1,
        region: "South",
        customer_feedback: "Great discounts on electronics",
        rating: 5,
        feedback_date: ISODate("2026-10-10")
    },
    {
        campaign_id: 102,
        campaign_name: "Festive Furniture Offer",
        store_id: 2,
        region: "South",
        customer_feedback: "More furniture options needed",
        rating: 3,
        feedback_date: ISODate("2026-10-11")
    },
    {
        campaign_id: 103,
        campaign_name: "Mega Electronics Sale",
        store_id: 3,
        region: "West",
        customer_feedback: "Good offers but limited stock",
        rating: 4,
        feedback_date: ISODate("2026-10-12")
    }
]);

// 3. Create indexes
db.campaign_feedback.createIndex({ store_id: 1 });
db.campaign_feedback.createIndex({ region: 1 });
db.campaign_feedback.createIndex({ campaign_name: 1 });
db.campaign_feedback.createIndex({ rating: 1 });

// 4. Display all campaign feedback
db.campaign_feedback.find();

// 5. Find feedback with ratings of 4 or above
db.campaign_feedback.find({ rating: { $gte: 4 } });

// 6. Display all indexes
db.campaign_feedback.getIndexes();
