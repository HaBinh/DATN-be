class DashboardsController < ApplicationController
    def index
        @result = Array.new
        @imported_price = []
        sql1 = "SELECT d.month, SUM(quantity*imported_price) AS total 
              FROM (SELECT generate_series( date_trunc('month','#{11.months.ago}'::date), date_trunc('month','#{Date.today}'::date), '1 month') as month) d 
              left join imports on date_trunc('month', created_at) = d.month group by d.month order by d.month"
        @imported_price = ActiveRecord::Base.connection.execute(sql1).to_a
        @result << {imported_price: @imported_price}

        @total_amount = []
        sql2 = "SELECT d.month, SUM(total_amount) AS total 
                FROM (SELECT generate_series( date_trunc('month','#{11.months.ago}'::date), date_trunc('month','#{Date.today}'::date), '1 month') as month) d 
                left join orders on date_trunc('month', created_at) = d.month group by d.month order by d.month"
        @total_amount = ActiveRecord::Base.connection.execute(sql2).to_a
        @result << {total_amount: @total_amount}

        @profit = Array.new
        (0..11).each do |n| 
            if @imported_price[n]['total'] === nil
                @imported_price[n]['total'] = 0
            end
            if @total_amount[n]['total'] === nil
                @total_amount[n]['total'] = 0
            end 
            @profit<<{month: @total_amount[n]['month'][0..6] , total: @total_amount[n]['total'] - @imported_price[n]['total']}           
            
        end
        @result << {profit: @profit}
        
        @inventory = []
        sql3 = "SELECT SUM(imported_price*(quantity-quantity_sold)) AS total 
                FROM imports"
        @inventory =ActiveRecord::Base.connection.execute(sql3).to_a
        @result << {inventory: @inventory}

        @sales = []
        sql4 = "SELECT SUM(imported_price*quantity_sold) AS total 
                FROM imports"
        @sales =ActiveRecord::Base.connection.execute(sql4).to_a
        @result << {sales: @sales}
        
        @expected = Array.new
        sql5 = "SELECT SUM(default_sale_price*(quantity-quantity_sold)) AS total 
                FROM imports LEFT JOIN products ON imports.product_id = products.id AND imports.quantity > imports.quantity_sold"
        @expected =ActiveRecord::Base.connection.execute(sql5).to_a
        @result <<  {expected: @expected}
        render( json:{result:@result})
    end
end

