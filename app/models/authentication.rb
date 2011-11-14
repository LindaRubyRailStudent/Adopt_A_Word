class Authentication < ActiveRecord::Base
  #require 'twitter'
  belongs_to :user

  def provider_name
    provider.titleize
  end


end
