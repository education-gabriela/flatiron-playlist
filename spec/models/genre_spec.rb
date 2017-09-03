require 'rails_helper'

describe 'Genre' do
  let(:pop) {Genre.create(name: "pop")}
  let(:rock_1) {Genre.create(name: "rock")}

  it 'can initialize a genre' do
    expect(Genre.new).to be_an_instance_of(Genre)
  end

  it 'has a name' do
    expect(pop.name).to eq("pop")
    expect(rock_1.name).to eq("rock")
  end

  it 'doesn\'t save if name is empty' do
    genre = Genre.create()
    expect(genre.errors.count).to be > 0
    expect(genre.errors.messages[:name].first).to eq("can't be blank")
  end

  it 'must have a unique name' do
    rock_1 = Genre.create(name: "rock")
    rock_2 = Genre.create(name: "rock")
    expect(rock_2.errors.count).to be > 0
    expect(rock_2.errors.messages[:name].first).to eq("has already been taken")
  end
end