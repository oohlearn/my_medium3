class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # relationships
  has_many :stories
  has_many :follows
  has_one_attached :avatar
  has_many :bookmarks

  # validations
  validates :username, presence: true, uniqueness: true
  # 驗證username必填，且不得重複


  enum role: {
    user: 0,
    vip_user: 1,
    platium_user: 2,
    admin: 3
  }

  # instance method
  def paid_user?
    vip_user? or platium_user?
    
  end

  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy
      return "Unbookmarked"
    else
      bookmarks.create(story: story)
      return "Bookmarked"
    end
  end


  # instance method
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return "Follow"
    else
      follows.create(following: user)
      return "Followed"
    end
  end



end
