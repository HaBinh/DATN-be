json.users @users.each do |user| 
    json.extract! user, :id, :email, :name, :role, :active
end