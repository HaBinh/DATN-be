require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.new(name: "Example Customer", email: "user@example.com", phone: "01688534943", address: "DN")
  end

  test "should be valid" do
    assert @customer.valid?
  end

  test "name should be present" do
    @customer.name = "     "
    assert_not @customer.valid?
  end

  test "email should be present" do
    @customer.email = "     "
    assert_not @customer.valid?
  end

  test "name should not be too long" do
    @customer.name = "a" * 51
    assert_not @customer.valid?
  end

  test "email should not be too long" do
	@customer.email = "a" * 244 + "@example.com"
    assert_not @customer.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @customer.email = invalid_address
      assert_not @customer.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @customer.email = mixed_case_email
    @customer.save
    assert_equal mixed_case_email.downcase, @customer.reload.email
  end

  test "phone number should not be too long" do
    @customer.phone = "1" * 16
    assert_not @customer.valid?
  end
end
