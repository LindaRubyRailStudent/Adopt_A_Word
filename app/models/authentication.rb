class Authentication < ActiveRecord::Base
  ## an authentication belongs to a user
  belongs_to :user

  ## format the providers name by titleizing it to ensure consistency
  def provider_name
    provider.titleize
  end

end
