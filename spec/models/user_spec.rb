require 'rails_helper'

describe User do
  it "authenticates with matching username and password" do
    user = create(:user, username: "batman", password: "secret")
    
    expect(User.authenticate("batman", "secret")).to eq(user)
  end

  it "does not authenticate with incorrect password" do
    create(:user, username: "batman", password: "secret")
    
    expect(User.authenticate("batman", "incorrect")).to be_nil
  end

  it "can manage articles he owns" do
    article = build(:article)
    user = article.user
    
    expect(user.can_manage_article?(article)).to be_truthy
    expect(user.can_manage_article?(Article.new)).to be_falsey
  end

  it "can manage any articles as admin" do
    expect(build(:admin).can_manage_article?(Article.new)).to be_truthy
    expect(build(:user).can_manage_article?(Article.new)).to be_falsey
  end
end
