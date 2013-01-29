require 'test_helper'

class CagesHelperTest < ActionView::TestCase
  class StrategyContext
    def validate attr
    end
  end

  class ValidateAsString < StrategyContext
    def ValidateAsString::validate attr
      # test length 0
      attr_value = ""
      # test setter
      attr_value = "test"
    end
  end

  class ValidateAsNumeric < StrategyContext
    def ValidateAsNumeric::validate attr
      # test min
      attr_value = 0
      # test max
      attr_value = 90
    end
  end

  def CagesHelperTest::validate_attr attr_value
    if attr_value.is_a? String
      ValidateAsString::validate(attr_value)
    elsif attr_value.is_a? Numeric
      ValidateAsNumeric::validate(attr_value)
    end
  end

end
