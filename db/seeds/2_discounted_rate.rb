@rates = [0, 0.02, 0.05, 0.1, 0.2,0.3, 0.5]

@rates.each do |rate|
  DiscountedRate.create!(
    rate: rate
  )
end