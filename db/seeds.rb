# Create admin user

unless User.find_by(email: 'admin@blog.com').present?
  User.create(email: 'admin@blog.com', password: 'admin1234', nickname: 'Admin', first_name: 'Admin')
end
