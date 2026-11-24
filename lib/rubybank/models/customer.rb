
module RubyBank

class Customer
  
  STATES = %i[active blocked inative].freeze

  attr_accessor :id, :name, :cpf, :email, :status

  def initialize(id, name, cpf, email, status: :active)
    @id = id
    @name = name
    @cpf = cpf
    @email = email
    @status = status
  end

  begin
    if name == nil || name.empty?
      rescue ArgumentError => e
        puts "#{e.message}, Name cannot be nil or empty"
    end

    elsif !(name.is_a?(String))
    rescue ArgumentError => e
      puts "#{e.message}, Name must be a string"
    end

    elsif cpf == nil || cpf.empty?
      rescue ArgumentError => e
        puts "#{e.message}, CPF cannot be nil or empty"
    end

    elsif !(cpf.is_a?(String))
      rescue ArgumentError => e
        puts "#{e.message}, CPF must be a string"
    end

    elsif email == nil || email.empty?
      rescue ArgumentError => e
        puts "#{e.message}, Email cannot be nil or empty"
    end

    elsif !(email.is_a?(String))
      rescue ArgumentError => e
        puts "#{e.message}, Email must be a string"
    end
  end

end

def normalizar_cpf(cpf)
  cpf = cpf.gsub!(/[^0-9]/, "")
  if cpf.length != 11
    raise ArgumentError, "CPF must have 11 digits"
  end
  cpf

#metodos com ? e ! para estados
#metodos com ? são metodos de consulta

def active?
  @status == :active  
end

def blocked?
  @status == :blocked
end

def inative?
  @status == :inative 
end

#metodos com ! são metodos de alteração de estado

def activate!
  @status = :active
end

def block!
  @status = :blocked
end

def inactivate!
  @status = :inative
end

end

end
