# Create admin and user

%w( admin user ).each do |user|
  email = "#{user}@blog.com"
  unless User.find_by(email: email).present?
    name = user.capitalize
    password = "#{user}1234"
    User.create(email: email, password: password, nickname: name, first_name: name)
  end
end
