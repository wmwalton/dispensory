#/usr/bin/env ruby
# 
# Build a program to calculate change in minimum bill/coin
# denominations after accepting a starting USD$ value. 
# For example, a starting value of $11.00 would result 
# in (1) $10 and (1) $1 bills. 
#
# Design specs
# - Make use of all common USD$ denominations
#   * Hundred, Twenty, Ten, Five, One, Quarter, Dime, Nickel, Pennie
# - Calculate change using the minimum number of bills and coins necessary
# - Assume infinite amounts of each denomination in change machine
# - Use a language of your choice and provide source code for review
# - Functioning program must be demonstrable to reviewers in some fashion
#
# Tender order of preference is defined by ordered array.
# Valid in Ruby - for other lang - I'd sort -rn the array
# 
# Not using Money gem - do the work of parsing decimal places
#
# Need to take value from input - scrubbing various garbage 
# Dollars.Cents or various ugly alternatives
# 123  123.4  123.45  1.0  #  Fail on -1 or non numeric

# Explored gem 'Money' for in/out parsing, cleaner handling of decimal
require 'money'
   Money.use_i18n = false

# optparse does nice little banner and feedback on how to pass args, etc..
# Want to either run a little "Enter Amount" query or put "enter in cents"
# can use verbose for debug flag.  Trollop is another opt parser considered.

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options] ARGS
  Provide value in cents to dispense change in US currency
  example = $10.00  is  1000  "

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

# p options
# p ARGV

# Static Ordered Denom

DENOMINATIONS = {
  :$100 => 10000,
  :$20 => 2000,
  :$10 => 1000,
  :$5 => 500,
  :$1 => 100,
  :Quarters => 25,
  :Dimes => 10,
  :Nickels =>  5,
  :Pennies =>  1,
}

# Used Money Gem to provide clear USD output
#

def decimate(number)
  rounded = (number*100).to_i / 100.0
  if number == rounded
    usd = Money.new(number, "USD")
    puts "$#{usd}:"
    # printf "$#{usd}:"
    # fails
    # printf "%.02f\n", number
  else
    printf "%g\n", number
  end
end

# IN : Cents no decimal place
# Dispense minimum quantity of bills and coins
#
# Core algorhythm loops through DENOMINATIONS and 
# Divide amount by value until can't then next DENOM
#

def make_change(amount, denominations = DENOMINATIONS)
  change = {}  
    denominations.each{|coin, value|
    num, amount = amount.divmod(value)
    change[coin] = num if num > 0
  }
  # print " "
  change
end

[213,1120,1122,166,12112,6543,234678,4242,66,8838].each{|i|
  decimate(i)
  puts "%8s: %-10s" % [ i, make_change(i)]
}
