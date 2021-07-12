class GroceriesController < ApplicationController
  before_action :set_grocery, only: %i[ show edit update destroy ]

  # GET /groceries or /groceries.json
  def index
    @groceries = Grocery.all
  end

  # GET /groceries/1 or /groceries/1.json
  def show
  end

  # GET /groceries/new
  def new
    @grocery = Grocery.new
  end

  # GET /groceries/1/edit
  def edit
  end

  # POST /groceries or /groceries.json
  def create
    @grocery = Grocery.new(grocery_params)

    respond_to do |format|
      if @grocery.save
        format.html { redirect_to @grocery, notice: "Grocery was successfully created." }
        format.json { render :show, status: :created, location: @grocery }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grocery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groceries/1 or /groceries/1.json
  def update
    respond_to do |format|
      if @grocery.update(grocery_params)
        format.html { redirect_to @grocery, notice: "Grocery was successfully updated." }
        format.json { render :show, status: :ok, location: @grocery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grocery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groceries/1 or /groceries/1.json
  def destroy
    @grocery.destroy
    respond_to do |format|
      format.html { redirect_to groceries_url, notice: "Grocery was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grocery
      @grocery = Grocery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grocery_params
      params.require(:grocery).permit(:author_id, :name, :amount, :unit)
    end
end
