User.create(email: 'admin@admin.com',
            nickname: 'Admin', 
            name: 'Admin', 
            password: "admin123",
            password_confirmation: "admin123", 
            role: "manager")

5.times do |n|
  User.create(email: "staff#{n}@staff.com", 
            nickname: "Staff #{n}", 
            name: "Staff #{n}", 
            password: "staff123",
            password_confirmation: "staff123")
end
