use("attendance_tracker");

db.task_feedback.createIndex({ employee_id: 1 });
db.task_feedback.createIndex({ department: 1 });
db.task_feedback.createIndex({ department: 1, rating: -1 });   
db.task_feedback.createIndex({ tags: 1 });                  

printjson(db.task_feedback.getIndexes());

// Sample queries (explain confirms the index is used)
printjson(db.task_feedback.find({ employee_id: 6 }).toArray());
printjson(db.task_feedback.find({ department: "Sales", rating: { $lte: 2 } }).toArray());
printjson(db.task_feedback.find({ "follow_up.required": true }).toArray());
printjson(db.task_feedback.find({ employee_id: 6 }).explain("executionStats").queryPlanner.winningPlan);
