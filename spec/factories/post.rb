FactoryGirl.define do
  factory :post do
    title { Faker::Name.name }
    text_md { "# H1\r\n## H2\r\n### H3\r\n#### H4\r\n##### H5\r\n###### H6\r\n\r\nAlternatively, for H1 and H2, an underline-ish style:\r\n\r\nAlt-H1\r\n======\r\n\r\nAlt-H2\r\n------" }
    user { FactoryGirl.create(:user) }
    status 'new'
  end

  trait :published do
    after :create do |post|
      post.update(status: :published)
    end
  end

end


FactoryGirl.define do
  factory :post_published, class: Post do
    title Faker::Name.name
    text_md "# H1\r\n## H2\r\n### H3\r\n#### H4\r\n##### H5\r\n###### H6\r\n\r\nAlternatively, for H1 and H2, an underline-ish style:\r\n\r\nAlt-H1\r\n======\r\n\r\nAlt-H2\r\n------"
    user { FactoryGirl.create(:user)}
    status 'published'
  end

  factory :post_not_published, class: Post do
    title Faker::Name.name
    text_md "# H1\r\n## H2\r\n### H3\r\n#### H4\r\n##### H5\r\n###### H6\r\n\r\nAlternatively, for H1 and H2, an underline-ish style:\r\n\r\nAlt-H1\r\n======\r\n\r\nAlt-H2\r\n------"
    user { FactoryGirl.create(:user)}
    status 'new'
  end

  factory :post_invalid, class: Post do
    title ''
  end

end