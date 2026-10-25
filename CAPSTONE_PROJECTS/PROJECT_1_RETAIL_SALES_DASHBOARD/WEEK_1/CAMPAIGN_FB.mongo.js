// MongoDB (mongosh): campaign feedback + indexes
use("retail_feedback");

db.campaign_feedback.insertMany([
  { campaign: "WINTER25",  store_id: 1, region: "West",    product_id: 1, rating: 5, comment: "Great discount!",        date: new Date("2025-01-15") },
  { campaign: "WINTER25",  store_id: 2, region: "Midwest", product_id: 2, rating: 3, comment: "Limited stock.",         date: new Date("2025-01-16") },
  { campaign: "FITNESS25", store_id: 1, region: "West",    product_id: 2, rating: 4, comment: "Good bundle offer.",     date: new Date("2025-01-18") },
  { campaign: "FITNESS25", store_id: 3, region: "East",    product_id: 3, rating: 5, comment: "Loved the yoga mat deal.",date: new Date("2025-01-19") },
  { campaign: "SPRING25",  store_id: 4, region: "South",   product_id: 4, rating: 2, comment: "Sizes ran out quickly.", date: new Date("2025-01-20") },
  { campaign: "SPRING25",  store_id: 5, region: "North",   product_id: 5, rating: 4, comment: "Smart watch price was good.", date: new Date("2025-01-21") }
]);

// Indexes: search by product and region
db.campaign_feedback.createIndex({ product_id: 1 });
db.campaign_feedback.createIndex({ region: 1 });

// Example search
db.campaign_feedback.find({ product_id: 2, region: "West" });
