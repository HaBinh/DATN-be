require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do

  let(:email) { "doanminhthuan274@gmail.com" }
  let(:code_html) { "<h1> Thuan dep trai </h1> "}

  describe "quote_price" do
    let(:mail) { OrderMailer.quote_price(email, code_html) }

    it "renders the headers" do
      expect(mail.subject).to eq("Quote price")
      expect(mail.to).to eq([email])
      expect(mail.from).to eq(["vkh@novahub.vn"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Thuan")
    end
  end

end
