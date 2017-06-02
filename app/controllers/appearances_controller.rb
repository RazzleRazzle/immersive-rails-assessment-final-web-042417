class AppearancesController < ApplicationController
  validates :rating, length: {in: 1..5}

  def index
    @appearances = Appearance.all
  end

  def new
    @appearance = Appearance.new
  end

  def create
    @appearance = Appearance.new(appearance_params)
      if @appearance.save
       @appearance.user_id = current_user.id
      redirect_to @appearance.episode
    else
      redirect_to new_appearance_path
    end
  end

  def edit
    @appearance = Appearance.find(params[:id])
  end

  def update
    @appearance = Appearance.find(params[:id])
    if @appearance.update_attributes(appearance_params)
      redirect_to guests_path
    else
      render 'edit'
    end
  end

  private

  def appearance_params
    params.require(:appearance).permit(:guest_id, :episode_id, :rating)
  end

end
