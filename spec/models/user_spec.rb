require 'rails_helper'

describe 'User' do
  let(:user_1) do
    {:name => "John Smith", :email => "john@example.com", :password => "123"}
  end

  it 'can initialize a new user' do
    expect(User.new).to be_an_instance_of(User)
  end

  it 'can create a new user' do
    user = User.create(user_1)
    expect(user.id).not_to be_nil
  end

  it 'can\'t have an empty name' do
    user_1 = User.create(email: "john@example.com", password: "123")
    user_2 = User.create(name: "", email: "john@example.com", password: "123")
    expect(user_1.errors.messages[:name].first).to eq("can't be blank")
    expect(user_2.errors.messages[:name].first).to eq("can't be blank")
  end

  it  'can\'t have an empty or duplicated email' do
    valid_user = User.create(user_1)
    user_with_blank_email = User.create(name: "John Smith", password: "123")
    user_with_repeated_email = User.create(name: "John Dogget", email: "john@example.com", password: "123")
    expect(user_with_blank_email.errors.messages[:email].first).to eq("can't be blank")
    expect(user_with_repeated_email.errors.messages[:email].first).to eq("has already been taken")
  end
end