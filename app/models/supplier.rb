class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true

  def description
    "#{corporate_name} - #{registration_number}"
  end
end
