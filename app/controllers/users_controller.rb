class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])

    if @user
      @prototypes = @user.prototypes
    else
      redirect_to root_path
    end
  end
end