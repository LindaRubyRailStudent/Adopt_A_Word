class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  require 'twitter'
  require 'fb_graph'

  ## the user has many authentications
  ## the user can have many adoptions
  ## the user has many words through adoptions
  ## the user has many posts

  has_many :authentications
  has_many :adoptions
  has_many :words, :through => :adoptions
  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

   ## method to allow user have omniauth hash passed to it
   ## authentication is created from the omniauth hash
   ## the fields of the authentication are mapped from the hash_from_omniauth method
   def apply_omniauth(omniauth)
     case omniauth['provider']
       when 'facebook'
         self.apply_facebook(omniauth)
       when 'twitter'
         self.apply_twitter(omniauth)
     end
    authentications.build(hash_from_omniauth(omniauth))
   end

  ## find_tweets method
  ## Save the users tweets to the database
  def find_tweets(current_user)
    @screen_name = current_user.authentications[2].to_s
    @another_tweet = self.twitter.user_timeline(@screen_name)
    @tweet = Tweets.new
    @another_tweet.each do |t|
      @tweet.screenname = t.screen_name
      @tweet.text = t.text
      @tweet.created_at = t.created_at
    end
     @tweet.save
  end

  ## contact Facebook to acccess the FbGraph
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

  ## contact Twitter to instantiate a new Twitter Client
  ## pass the provider token and the provider secret
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

  def tweet_search

  end

  protected

  ## method to build an authentication from facebook
  def apply_facebook(omniauth)
  if (extra = omniauth['extra']['user_hash'] rescue false)
    self.email = (extra['email'] rescue '')
  end
end

  ## method to build an authentication from twitter
  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
    end
  end

  ## method to map the details from the omniauth hash to the attributes of the authentication
    def hash_from_omniauth(omniauth)
      {
          :provider => omniauth['provider'],
          :uid => omniauth['uid'],
          :token => (omniauth['credentials']['token'] rescue nil),
          :secret => (omniauth['credentials']['secret'] rescue nil),
          :screenname => (omniauth['user_info']['nickname'] rescue nil)
      }
    end

end
