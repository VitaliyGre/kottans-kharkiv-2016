require 'rspec'
require_relative '../week2-task3/wombat'
require 'matchers'

describe 'Wombat' do

  subject(:wombat) { Wombat.new }

  let(:burrow) {Burrow.new(wombat)}
  let(:other_burrow) {Burrow.new(Wombat.new)}

  it 'exists' do
    expect(wombat).not_to eq nil
  end

  it 'lives in Australia' do
    expect(wombat.home).to eq 'Australia'
  end

  it 'does not live in Austria' do
    expect(wombat.home).not_to eq 'Austria'
  end

  context 'characteristics' do
    it 'length /cm/' do
      expect(wombat.length).to be_within(70).of(130)
    end

    it 'weight /kg/' do
      expect(wombat.weight).to be_within(20).of(45)
    end

    it 'marsupial' do
      expect(wombat.marsupial?).to eq true
    end

    it 'can run' do
      expect(wombat).to respond_to(:run)
    end

    it 'cannot fly' do
      expect { wombat.fly }.to raise_error NoMethodError
    end
  end

  it 'eats grasses' do
    expect(wombat.eat 'grasses').to eq true
  end

  it 'does not eat meat' do
    expect(wombat.eat 'meat').to eq false
  end

  it 'needs a few water' do
    expect(wombat).to get_enough_water(1)
  end

  it 'but needs water at all' do
    expect(wombat).not_to get_enough_water(0.1)
  end

  it 'lives in his burrow' do
    expect(wombat).to lives_in_burrow(burrow)
  end

  it 'does not live in other burrow' do
    expect(wombat).not_to lives_in_burrow(other_burrow)
  end

end