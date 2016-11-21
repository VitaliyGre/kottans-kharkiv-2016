require 'rspec'
require 'rspec/its'
require_relative '../week2-task3/wombat'
require 'matchers'

describe 'Wombat' do

  subject(:wombat) { Wombat.new }

  let(:burrow) { Burrow.new(wombat) }
  let(:other_burrow) { Burrow.new(Wombat.new) }

  it { is_expected.not_to be_nil }

  its(:home) { is_expected.to eq 'Australia' }

  describe 'characteristics' do
    its (:length) { is_expected.to be_within(30).of(100) }

    it 'weight' do
      expect(20..45).to cover wombat.weight
    end

    it { is_expected.to be_marsupial }

    it 'can run' do
      expect(wombat).to respond_to(:run)
    end

    it 'cannot fly' do
      expect { wombat.fly }.to raise_error NoMethodError
    end
  end

  it 'eats grasses' do
    expect(wombat.eat 'grasses').not_to be_nil
  end

  it 'does not eat meat' do
    expect(wombat.eat 'meat').to be_nil
  end

  it 'eats grasses and becomes fed' do
    expect { wombat.eat('grasses') }.to change(wombat, :hungry?).from(true).to(false)
  end

  it 'does not eat meat and stays hungry' do
    expect{wombat.eat('meat')}.to_not change{wombat.hungry?}.from(true)
  end

  it 'eats and becomes hungry after 14 days' do
    wombat.eat('grasses', Date.today - 15)
    expect(wombat.hungry?).to be_truthy
  end

  it 'needs a few water' do
    expect(wombat).to get_enough_water(1)
  end

  it 'but needs water at all' do
    expect(wombat).not_to get_enough_water(0.1)
  end

  it 'lives in his burrow' do
    expect(wombat).to live_in burrow
  end

  it 'does not live in other burrow' do
    expect(wombat).not_to live_in other_burrow
  end

end