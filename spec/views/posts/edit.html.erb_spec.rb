require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :title => "MyString",
      :slug => "MyString",
      :url => "MyString",
      :text_md => "MyText",
      :text_html => "MyText",
      :user => nil
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "input#post_slug[name=?]", "post[slug]"

      assert_select "input#post_url[name=?]", "post[url]"

      assert_select "textarea#post_text_md[name=?]", "post[text_md]"

      assert_select "textarea#post_text_html[name=?]", "post[text_html]"

      assert_select "input#post_user_id[name=?]", "post[user_id]"
    end
  end
end
