require 'rails_helper'

describe 'Artist' do
  let(:adele) {Artist.create(name: "Adele")}
  let(:foo_fighters) {Artist.create(name: "Foo Fighters")}

  it 'can initialize an artist' do
    expect(Artist.new).to be_an_instance_of(Artist)
  end

  it 'has a name' do
    expect(adele.name).to eq("Adele")
    expect(foo_fighters.name).to eq("Foo Fighters")
  end

  it 'doesn\'t save if name is empty' do
    artist = Artist.create()
    expect(artist.errors.count).to be > 0
    expect(artist.errors.messages[:name].first).to eq("can't be blank")
  end

  it 'must have a unique name' do
    queen_1 = Artist.create(name: "Queen")
    queen_2 = Artist.create(name: "Queen")
    expect(queen_2.errors.count).to be > 0
    expect(queen_2.errors.messages[:name].first).to eq("has already been taken")
  end
end