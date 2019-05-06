json.discoutRate do
    json.partial! "product_discoutedrates/product_discoutedrate", discoutedRate: @discoutedRates
end