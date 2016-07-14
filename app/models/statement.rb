class Statement
  include ActiveModel::Validations
  extend  ActiveModel::Naming

  validates_length_of :first_name, :last_name, :email, :phone_number, :allow_blank => true, :minimum => 3

  attr_accessor :first_name, :last_name, :email, :phone_number

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end if attributes
  end

  def execute
    users = User.scoped(:order => 'last_name, first_name')
    users = users.where('first_name like ?', "%#{first_name}%")                          unless first_name.blank?
    users = users.where('last_name like ?', "%#{last_name}%")                            unless last_name.blank?
    users = users.where('email = ?', email)                                              unless email.blank?
    users = users.includes(:phone_number).where('phone_numbers.value = ?', phone_number) unless phone_number.blank?
    users
  end

end