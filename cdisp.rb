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

DENOMINATIONS = {
  :Hundred => 10000,
  :Twenty => 2000,
  :Ten => 1000,
  :Five => 500,
  :One => 100,
  :Quarter => 25,
  :Dime => 10,
  :Nickel =>  5,
  :Penny =>  1,
}

# IN : Cents no decimal place
# Divide amount by value until can't 
# Dispense minimum quantity of bills and coins
#

def make_change(amount, denominations = DENOMINATIONS)
  change = {}  
  denominations.each{|coin, value|
    num, amount = amount.divmod(value)
    change[coin] = num if num > 0
  }
  print " "
  change
end
 
[213,1120,1122,166,6543,234678,4242,66,8838].each{|i|
 puts "%-4i: %-10s" % [ i, make_change(i)]
