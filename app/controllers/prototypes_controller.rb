class PrototypesController < ApplicationController
 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:edit, :update, :destroy]
  before_action :check_authorization, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to prototypes_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def edit
    # @prototypeはset_prototypeメソッドで設定されています
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def check_authorization
    unless @prototype.user == current_user
      redirect_to root_path
    end
  end
end
