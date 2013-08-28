require 'spec_helper'

feature 'Admin panel' do
  before do 
    Post.create(title: 'Testy postaaaa', content:'thee content mi Lord Jeremiah.', is_published: true)
  end

  context "on admin homepage" do

    it "can see a list of recent posts" do
      visit admin_posts_path
      page.should have_content "Testy Postaaaa"
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_link "Edit"
      page.should have_content "Edit Testy Postaaaa"
    end

    # it "can delete a post by clicking the delete link next to a post" do
    #   visit admin_posts_path
    #   click_link "Delete"
    #   page.should have_content "Are you sure you want"
    # end

    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do

    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      click_link "Edit"
      find(:css, "#post_is_published").set(false)
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do

    before do 
      visit new_admin_post_url
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet"
         page.check('post_is_published')
         click_button "Save"
    end

    # it "can visit a post show page by clicking the title"

    it "can see an edit link that takes you to the edit post path" do
      click_link "Edit"
      page.should have_content "Edit Hello World!"
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      click_link "Admin welcome page"
      page.should have_content "Welcome to the admin panel!"
      page.should have_content "Hello World!"
    end
  end
end
