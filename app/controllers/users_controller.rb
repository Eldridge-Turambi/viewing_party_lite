# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}"
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad."
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @party_users = PartyUser.attending(@user)
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to user_path(user)
    else
      flash[:error] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
