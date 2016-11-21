RSpec::Matchers.define :get_enough_water do |water|
  match do |wombat|
    0.022 * wombat.weight < water
  end
end

RSpec::Matchers.define :live_in do |burrow|
  match do |wombat|
    burrow.wombat == wombat
  end
end
