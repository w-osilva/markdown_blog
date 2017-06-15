module Pages
  class Posts
    include Capybara::DSL

    def visit_page
      visit '/posts'
      self
    end

    def table
      find("table", class: "posts")
    end

    def items
      all(:css, ".post-item")
    end

    def paginator
      find('ul', class: 'pagination')
    end

    def paginate_to(page)
      paginator.find('a', text: page).click
    end

    def item_title(item)
      item.find('h3').text
    end

    def item_buttons(item)
      item.find('div', class: 'btn-toolbar')
    end

    def new_button
      find('a', text: 'New Post')
    end

    def fill_form(title: 'My title of post by capybara test', text_md: '# My title of post by capybara test')

      fill_in 'Title', with: title
      fill_in 'Text md', with: text_md
    end

    def fill_text_md(text)
      fill_in 'Text md', with: text
    end

    def button_preview_side
      find(:xpath, '//*[@id="new_post"]/fieldset/div[2]/div/div[1]/a[10]')
    end

    def preview_side
      find(:xpath, '//*[@id="new_post"]/fieldset/div[2]/div/div[3]')
    end

  end
end