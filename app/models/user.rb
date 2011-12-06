class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  require 'twitter'
  require 'fb_graph'

  has_many :authentications
  has_many :adoptions
  has_many :words, :through => :adoptions
  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

   ## method to allow user have omniauth hash passed to it.
   def apply_omniauth(omniauth)
     case omniauth['provider']
       when 'facebook'
         self.apply_facebook(omniauth)
       when 'twitter'
         self.apply_twitter(omniauth)
     end
    authentications.build(hash_from_omniauth(omniauth))
   end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
    @fb_user.fetch
  end

  def facebook_search
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end

  def facebook_searchable
    @fb_user ||=FbGraph::Searchable.search(params)
  end

   ## overriding the password validations
  def password_required?
    ## only validate a password when no authentication password is available
    ## delegate to super so we can inherit that behaviour too
   (authentications.empty? || !password.blank?) && super
  end

  def twitter
    unless @twitter_user
      provider = self.authentications.find_by_provider('twitter')
      @twitter_user = Twitter::Client.new(:oauth_token => provider.token, :oauth_token_secret => provider.secret )rescue nil
    end
    @twitter_user
  end

    def twitter_search
    unless @twitter_user
      provider = self.authentications.find_by_provider('twitter')
      @twitter_user = Twitter::Search.new
    end
    @twitter_user
  end


#class TwitterToken < ConsumerToken
#  TWITTER_SETTINGS={:site=>"http://api.twitter.com", :request_endpoint => 'http://api.twitter.com',}
#  def self.consumer
#    @consumer||=OAuth::Consumer.new credentials[:key],credentials[:secret],TWITTER_SETTINGS
#  end
#
#  def client
#    Twitter.configure do |config|
#      config.consumer_key = TwitterToken.consumer.key
#      config.consumer_secret = TwitterToken.consumer.secret
#      config.oauth_token = token
#      config.oauth_token_secret = secret
#    end
#    @client ||= Twitter::Client.new
#  end
#end


   #Twitter.configure do |config|
#    config.consumer_key = 'oK9Qv5IPAe1qiR9bkKxZbw'
#    config.consumer_secret = 'RNxEtuFbTG9wwXClGDMSw42qMnKeAZUEvoRfYMqw'
#    config.oauth_token = '404315507-iOFLGPnKjRMwMRRIwODfHAc87WTFIo7HLY9EVZb'
#    config.oauth_token_secret = '4Vkly1RITFYEkzumQfu5Ml4u5D9U113SHOnaMcYBuqU'
#  end

  protected

  def apply_facebook(omniauth)
  if (extra = omniauth['extra']['user_hash'] rescue false)
    self.email = (extra['email'] rescue '')
  end
end

  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
    end
  end

    def hash_from_omniauth(omniauth)
      {
          :provider => omniauth['provider'],
          :uid => omniauth['uid'],
          :token => (omniauth['credentials']['token'] rescue nil),
          :secret => (omniauth['credentials']['secret'] rescue nil),
        #  :screenname => (omniauth['user_info']['nickname'] rescue nil)
      }
    end

end
