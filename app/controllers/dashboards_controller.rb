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

        #Binh: thêm trả về  thu chi 30 ngày & 7 ngày
        @imported_price_month = []
        sql1 = "SELECT d.day, SUM(quantity*imported_price) AS total 
              FROM (SELECT generate_series( date_trunc('day','#{30.day.ago}'::date), date_trunc('day','#{Date.today}'::date), '1 day') as day) d 
              left join imports on date_trunc('day', created_at) = d.day group by d.day order by d.day"
        @imported_price_month = ActiveRecord::Base.connection.execute(sql1).to_a
        @result << {imported_price_month: @imported_price_month}

        @total_amount_month = []
        sql2 = "SELECT d.day, SUM(total_amount) AS total 
                FROM (SELECT generate_series( date_trunc('day','#{30.day.ago}'::date), date_trunc('day','#{Date.today}'::date), '1 day') as day) d 
                left join orders on date_trunc('day', created_at) = d.day group by d.day order by d.day"
        @total_amount_month = ActiveRecord::Base.connection.execute(sql2).to_a
        @result << {total_amount_month: @total_amount_month}

        @profit_month = Array.new
        (0..30).each do |n| 
            if @imported_price_month[n]['total'] === nil
                @imported_price_month[n]['total'] = 0
            end
            if @total_amount_month[n]['total'] === nil
                @total_amount_month[n]['total'] = 0
            end 
            @profit_month<<{day: @total_amount_month[n]['day'][5..9] , total: @total_amount_month[n]['total'] - @imported_price_month[n]['total']}
        end
        @result << {profit_month: @profit_month}        

        @imported_price_week = @imported_price_month[24..30]
        @total_amount_week = @total_amount_month[24..30]
        @profit_week = @profit_month[24..30]
        @result << {imported_price_week: @imported_price_week}        
        @result << {total_amount_week: @total_amount_week}        
        @result << {profit_week: @profit_week}        
        
        render( json:{result:@result})
    end
end

