# frozen_string_literal: true

class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users

  validates_presence_of :name, :email
  validates :email, email: true, uniqueness: true

  ## Line 11: bcrypt gem validation
  has_secure_password

  def self.except_user(id)
    all.where.not(id: id)
  end
end
