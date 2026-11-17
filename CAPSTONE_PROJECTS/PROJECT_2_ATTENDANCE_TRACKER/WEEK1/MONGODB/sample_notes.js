use("attendance_tracker");

db.task_feedback.drop();

db.task_feedback.insertMany([
  {
    employee_id: 1, department: "Engineering",
    feedback_type: "manager_review", rating: 5,
    comment: "Fixed the login bug ahead of schedule. Clean code and good test coverage.",
    tags: ["quality", "fast"], created_at: new Date("2026-10-14")
  },
  {
    employee_id: 2, department: "Engineering",
    feedback_type: "peer_review", rating: 5,
    comment: "Excellent PR reviews. Mentors junior developers regularly.",
    tags: ["mentoring", "teamwork"], created_at: new Date("2026-10-15")
  },
  {
    employee_id: 3, department: "Engineering",
    feedback_type: "manager_review", rating: 3,
    comment: "Test reports delivered late twice this month. Needs better planning.",
    tags: ["deadline", "planning"], created_at: new Date("2026-10-16")
  },
  {
    employee_id: 6, department: "Sales",
    feedback_type: "manager_review", rating: 2,
    comment: "Frequent absences affecting client follow-ups. Discussed attendance expectations.",
    tags: ["absenteeism", "client"], created_at: new Date("2026-10-17"),
    follow_up: { required: true, date: new Date("2026-10-30") }
  },
  {
    employee_id: 7, department: "Sales",
    feedback_type: "self_review", rating: 4,
    comment: "Closed two accounts. Need help with the CRM reporting tool.",
    tags: ["sales", "training-needed"], created_at: new Date("2026-10-18")
  },
  {
    employee_id: 9, department: "Finance",
    feedback_type: "manager_review", rating: 2,
    comment: "Late logins and incomplete reconciliations. Performance improvement plan suggested.",
    tags: ["late", "pip"], created_at: new Date("2026-10-19"),
    follow_up: { required: true, date: new Date("2026-11-02") }
  },
  {
    employee_id: 10, department: "Support",
    feedback_type: "customer_feedback", rating: 4,
    comment: "Customer praised the polite and quick resolution.",
    tags: ["customer", "positive"], created_at: new Date("2026-10-20")
  },
  {
    employee_id: 5, department: "HR",
    feedback_type: "note",
    comment: "Led the onboarding session for 6 new hires. Very well organised.",
    tags: ["leadership"], created_at: new Date("2026-10-21")
  }
]);

print("Inserted documents: " + db.task_feedback.countDocuments());
