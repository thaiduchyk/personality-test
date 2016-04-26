class User < ActiveRecord::Base
  has_many :results
  has_many :personalities, through: :results

  after_create :add_results

  attr_accessor :skip_password_validation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable :rememberable
  devise :database_authenticatable,:registerable,
         :recoverable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: {case_sensitive: false}

  VALID_PASSWORD_REGEX = /(?=.*\d)(?=.*[a-zA-Z])/
  validates :password, length: {minimum: 6},
             format: { with: VALID_PASSWORD_REGEX },
             unless: :skip_password_validation

  VALID_NAME_REGEX = /\A[A-ZА-Я][a-zа-я]{2,}\z/
  validates :name, presence:true,
            format: { with: VALID_NAME_REGEX }

  validates :surname, presence:true,
            format: { with: VALID_NAME_REGEX }

  scope :own_result, -> (id) { User.find(id).personalities.joins(:results).where('results.own_result = true') }

  private

  def add_results
    self.personalities << Personality.all
  end

end
