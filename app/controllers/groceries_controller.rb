class GroceriesController < ApplicationController
  before_action :set_grocery, only: %i[show edit destroy]
  before_action :authorize

  # GET /groceries/index/my-groceries or /groceries/index/my-external-groceries
  def index
    case params[:mode]
    when 'my-groceries'
      @groceries = Grocery.where(author_id: current_user.id).order(created_at: :desc)
      @total = @groceries.count
      @title = 'My Groceries'
    when 'my-external-groceries'
      @groceries = Grocery.where(author_id: current_user.id).order(created_at: :desc).select do |grocery|
        grocery.groups.none?
      end
      @total = @groceries.count
      @title = 'My External Groceries'
    else
      redirect_to '/404'
    end
  end

  # GET /groceries/1 or /groceries/1.json
  def show
    @grocery_groups = @grocery.groups
  end

  # GET /groceries/new
  def new
    @grocery = Grocery.new
    @grocery.private = true
    @groups = Group.all
  end

  # GET /groceries/1/edit
  def edit
    @groups = Group.all
  end

  # POST /groceries/index/my-groceries
  def create
    @grocery = Grocery.new(grocery_params)
    @grocery.author_id = current_user.id

    respond_to do |format|
      if @grocery.save
        @grocery.groups = Group.where(id: params[:grocery][:group_ids])
        format.html { redirect_to @grocery, notice: 'Grocery was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groceries/index/1
  def update
    @grocery = Grocery.find(params[:mode])
    respond_to do |format|
      if @grocery.update(grocery_params)
        @grocery.groups = Group.where(id: params[:grocery][:group_ids])
        format.html { redirect_to @grocery, notice: 'Grocery was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groceries/1 or /groceries/1.json
  def destroy
    redirect_to '/404' unless @grocery.author == current_user

    @grocery.destroy
    respond_to do |format|
      format.html { redirect_to groceries_path('my-groceries'), notice: 'Grocery was successfully deleted.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_grocery
    @grocery = Grocery.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def grocery_params
    params.require(:grocery).permit(:name, :amount, :unit, :private, :group_ids)
  end
end
