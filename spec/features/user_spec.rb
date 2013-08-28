require 'spec_helper'

feature 'User browsing the website' do
  before do 
    Post.create(title: 'Testy postaaaa', content:'thee content mi Lord Jeremiah.', is_published: true)
  end

  context "on homepage" do
    it "sees a list of recent posts titles" do
      visit posts_path
      page.should have_content "Testy Postaaaa"
      page.should have_content "thee content mi Lord Jeremiah."
    end

    # it "can click on titles of recent posts and should be on the post show page" do
    #   pending
    #   # given a user and a list of posts
    #   # user visits the homepage
    #   # when a user can clicks on a post title they should be on the post show page
    # end
  end

  context "post show page" do
    it "sees title and body of the post" do
      post = Post.find_by_title("Testy Postaaaa")
      visit post_path(id: post.id)
      page.should have_content "Testy Postaaaa"
      page.should have_content "thee content mi Lord Jeremiah."
    end
  end
end
