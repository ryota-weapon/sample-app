class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following,  through: :active_relationships, source: :followed 
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :followers,  through: :passive_relationships, source: :follower 
  
  #source 見たいもののデフォルトの名前, :followingが名前のオーバーライド
  attr_accessor :remember_token  #アクセス用の仮想の属性
  attr_accessor :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: {maximum: 50}
  # validates(:name, presence: true)
  
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]{1,}\.)+[a-z]+\z/i

  validates :email, presence: true, length: {maximum: 255}, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # 更新時にパスワードをいらなくする、でも登録時は必要

  # 渡された文字列のハッシュ値を返すf
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)                           
  end
  
  # 試作feedの定義
  # 完全な実装は次章の「ユーザーをフォローする」を参照
  def feed
    Micropost.where("user_id = ?", id)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end
  
 # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  def session_token
    remember_digest || remember
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
 def authenticated?(attribute, token)
  digest = self.send("#{attribute}_digest")
  return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(token) #バカみたいにわかりづらいけど真偽値返してる
 end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # update attributes related to resetting password
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # sending email for resetting
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now  
  end
  
  def password_reset_expired?
    self.reset_sent_at < 2.hours.ago
  end

  def follow(other_user)
    self.following << other_user unless self == other_user
  end

  def unfollow(other_user)
    self.following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end





  private
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end


