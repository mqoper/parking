class SpotsController < ApplicationController
  before_action :set_spot, only: [:update, :destroy]
  before_action :require_user, except: [:index]
  # before_action :require_same_user, only: [:update]
  # before_action :require_same_user, only: [:edit, :update, :destroy]


  def free
    spot = Spot.find(params[:format])
    spot.reserved = false
    spot.save
    redirect_to spots_url
  end

  def book
    spot = Spot.find(params[:format])
    spot.reserved = true
    spot.save
    history = History.new(user_id: current_user.id, spot_id: spot.id)
    history.save
    # byebug
    redirect_to spots_url
  end

  def index
    @spots = Spot.all
    @users = User.all
    @history = History.all
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    # @spot.user = current_user
    if @spot.save
      flash[:notice] = "Spot was created successfully."
      redirect_to @spot
    else
      render 'new'
    end
  end

  def update
    if (set_spot.reserved != true)
      spot = set_spot        # Search a spot in database by id
      user = current_user
      history = History.new(user_id: user.id, spot_id: spot.id)
      history.save
      if history.save
        flash[:notice] = "User #{user.full_name} reserved spot #{spot.name}"
      end
      # byebug
    end

    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to @spot , notice: 'Spot was successfully updated.'}
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_url, notice: 'Spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :reserved)
  end
end
