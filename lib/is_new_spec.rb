
# title, desc, id, source.

#
# This is the self-defined matcher, 
# which was used to verify an app was created actually
# with new id
# with the designated title, desc, and source.
#


RSpec::Matchers.define :be_a_new_app do |expected|
  match do |actual|
    (actual.title == expected.title) && (actual.source == expected.source) && (actual.desc == expected.desc) 
  end
end

# describe 5 do
#   it { should be_bigger_than(4).but_smaller_than(6) }
# end


#
# Links might be useful to refactor this file
# http://blog.bignerdranch.com/1529-rspec-tip-let-and-nested-describecontext-blocks/
# https://www.relishapp.com/rspec/rspec-expectations/v/2-9/docs/custom-matchers/define-matcher-with-fluent-interface
# 

require "rspec/expectations"
require "test/unit"

RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

class Test::Unit::TestCase
  include RSpec::Matchers
end

class TestMultiples < Test::Unit::TestCase

  def test_9_should_be_a_multiple_of_3
    9.should be_a_multiple_of(3)
  end

  def test_9_should_be_a_multiple_of_4
    9.should be_a_multiple_of(4)
  end
  
end