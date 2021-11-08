class SpotsController < ApplicationController
  before_action :set_spot, only: %i[show edit update destroy]

  # GET /spots or /spots.json
  def index
    @spots = Spot.all
    @users = User.all
  end

  # GET /spots/1 or /spots/1.json
  def show
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit
  end

  # POST /spots or /spots.json
  def create
    @spot = Spot.new(spot_params)

    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: 'Spot was successfully created.' }
        format.json { render :show, status: :created, location: @spot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spots/1 or /spots/1.json
  def update

    # if @spot.update(spot_params) == true
    # @history = History.new
    # @history = current_user
    # if @history.save
    #   flash[:notice] = "Parking spot has been reserved by"
    # end
    # end
    #
    #
    # @user = User.find(params[:id])
    if (set_spot.reserved != true)
      spot = set_spot        # Search a spot in database by id
      user = current_user
      history = History.new(user_id: user.id, spot_id: spot.id)
      history.save
      if history.save
        flash[:notice] = "User #{user.username} reserved spot #{spot.name}"
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

  # DELETE /spots/1 or /spots/1.json
  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_url, notice: 'Spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_spot
    @spot = Spot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def spot_params
    params.require(:spot).permit(:name, :reserved)
  end

end
