require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new chefname: 'shibabu', email: 'test@test.com'
  end

  test 'chef should be valid' do

    assert @chef.valid?
  end

  test 'chefname should be present' do
    @chef.chefname=''

    assert_not @chef.valid?
  end

  test 'chefname should not be too long' do
    @chef.chefname='a'*41

    assert_not @chef.valid?
  end

  test 'chefname should not be too short' do
    @chef.chefname='aa'

    assert_not @chef.valid?
  end

  test 'email should be present' do
    @chef.email=''

    assert_not @chef.valid?
  end

  test 'email should not be too long' do
    @chef.email='a'*100+'@example.com'

    assert_not @chef.valid?
  end

  test 'email should be unique' do
    @chef.save
    @chef=Chef.new chefname: 'shibabu2', email: 'Test@tesT.com'

    assert_not @chef.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses=%w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au
                                                                            laura+joke@monk.cm]

    valid_addresses.each do |addr|
      @chef.email=addr

      assert @chef.valid?, '#{addr.inspect} should be valid'
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses=%w[user@exampl,com user_at_eee.org user.name@example. eee@i_am_lee.com
                                                                            foo@bar+boo.co]

    invalid_addresses.each do |addr|
      @chef.email=addr

      assert_not @chef.valid?, '#{addr.inspect} should not be valid'
    end
  end

end
