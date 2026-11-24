require 'bigdecimal'
require 'bigdecimal/util'


module RubyBank

  class Account
    
  TYPES = %i[checking savings].freeze
  STATES = %i[active blocked closed].freeze

  attr_accessor :id, :name, :cpf, :email, :status

  def initialize(number, customer, type, balance: 0.00, status: :active)
    @number = number
    @customer = customer
    @type = type
    @balance = BigDecimal(balance.to_s)
    @status = status
  end

#metodos para vonferencia de estados

def active?
  @status == :active  
end

def blocked?
  @status == :blocked
end

def closed?
  @status == :closed
end

#metodos para mudar estados
def active!
  @status = :active
end

def blocked!
  @status = :blocked
end

begin
  def closed!
    unless @balance == 0
      rescue ArgumentError => e
        puts "Cannot close account with non-zero balance"
    end
    @status = :closed
  end
end

def validate_active_account!
  unless @status == :active
    raise AccountBlockedError, "Account is blocked"
  end
end

def validate_amount!(amount)
  unless amount.is_a?(Numeric) && amount > 0
    raise ArgumentError, "Amount must be a positive number"
  end
end

def to_bigdecimal(value)
  BigDecimal(value.to_s)
end

def credit!(amount)
  validate_active_account!
  validate_amount!(amount)

  @balance = to_bigdecimal(@balance) + to_bigdecimal(amount)
end

def debit!(amount)
  validate_active_account!
  validate_amount!(amount)

  if amount > @balance
    raise InsufficientFundsError, "Insufficient funds"
  end

  @balance = to_bigdecimal(@balance) - to_bigdecimal(amount)
end





  end
end
