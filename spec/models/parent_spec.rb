require 'spec_helper'

describe 'Parent' do 
  before do
    @parent = Parent.create(:username => "daddy Mike", :email => "parent@example.com", :password => "test")
  end
  it 'can slug the username' do
    expect(@parent.slug).to eq("daddy-mike")
  end

  it 'can find a user based on the slug' do
    slug = @parent.slug
    expect(Parent.find_by_slug(slug).username).to eq("daddy Mike")
  end

  it 'has a secure password' do

    expect(@parent.authenticate("baby")).to eq(false)
    expect(@parent.authenticate("test")).to eq(@parent)

  end
end