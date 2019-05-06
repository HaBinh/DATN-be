# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/quote_price
  def quote_price
    email = 'doanminhthuan274@gmail.com'
    html = get_html
    OrderMailer.quote_price(email, html)
  end

  private 
  def get_html
    '<div class="widget-box transparent"> <div class="widget-header widget-header-large transparent"> <h6 class="widget-title grey lighter"> <img src="http://sv1.upsieutoc.com/2017/11/16/logo09542f38a8977863.jpg" alt="logo09542f38a8977863.jpg" border="0"/> </h6> <div class="widget-toolbar no-border invoice-info"> <h4><strong>CÔNG TY TNHH MTV VIỆT KHẢI HƯNG </strong></h4> <h5><em>Nhà phân phối vật tư thiết bị điện, nước, vật liệu hoàn thiện khác.</em></h5> </div></div><div class="widget-header widget-header-large margin-top transparent"> <span>Đ/c: Số 19 Nguyễn Công Trứ - Đông Hà - Quảng Trị &nbsp &nbsp &nbsp</span> <span> Email: vietkhaihung@gmail.com</span> <br/> <span>ĐT: 0944552333 - 02333588333; Fax: 02333. 852890</span> </div><div class="widget-body"> <div class="widget-main"> <div class="space-6"></div><div class="row"> <h4 class="text-center"><strong>BÁO GIÁ SẢN PHẨM</strong></h5> </div><div class="row"> <h5>Kính gửi: Quý khách hàng</h5> </div></div></div></div><div class="" id="print-section"> <div class=""> <table id="simple-table" class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0" width="100%"> <thead> <tr> <th>Mã sản phẩm</th> <th>Tên</th> <th class="right-align">Số lượng</th> <th class="right-align">Giá hãng</th> <th class="right-align">Chiết khấu</th> <th class="right-align">Giá bán</th> <th>Thành tiền</th> </tr></thead> <tbody> <tr> <td>WIF-1056</td><td>iPad Pro</td><td class="right-align"> 1 </td><td class="right-align"> 699 </td><td class="right-align"> 0 % </td><td class="right-align"> 699 </td><td class="right-align"> 699 </td></tr><tr> <td>LCD-5634</td><td>iPhone 8</td><td class="right-align"> 1 </td><td class="right-align"> 919 </td><td class="right-align"> 0 % </td><td class="right-align"> 919 </td><td class="right-align"> 919 </td></tr><tr> <td colspan="6"> <h6 class="text-center"><strong> Tổng cộng </strong></h6> </td><td id="total" colspan="2"> <h5>1618</h5> </td></tr></tbody> </table> </div></div>'
  end

end
