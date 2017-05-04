class User < ActiveRecord::Base
  has_one :user_setting, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :request_to_fixes
  has_many :gifts, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :book_lists, dependent: :destroy
  has_many :user_books, dependent: :destroy
  has_friendship

  before_save :downcase_email
  before_create :generate_authentication_token!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_confirmation_of :password, on: :create
  validates :login, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates_uniqueness_of :login
  validates :auth_token, uniqueness: true
  VALID_NAME_REGEX = /\A[A-z]*\z/
  validates :name, format: { with: VALID_NAME_REGEX }
  validates :surname, format: { with: VALID_NAME_REGEX }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end


end
