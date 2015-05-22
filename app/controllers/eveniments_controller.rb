class EvenimentsController < ApplicationController
  before_action :set_eveniment, only: [:show, :edit, :update, :destroy]

  # GET /eveniments
  # GET /eveniments.json
  def index
    @eveniments = Eveniment.all
  end

  # GET /eveniments/1
  # GET /eveniments/1.json
  def show
  end

  # GET /eveniments/new
  def new
    @eveniment = Eveniment.new
  end

  # GET /eveniments/1/edit
  def edit
  end

  # POST /eveniments
  # POST /eveniments.json
  def create
    @eveniment = Eveniment.new(eveniment_params)

    respond_to do |format|
      if @eveniment.save
        format.html { redirect_to @eveniment, notice: 'Eveniment was successfully created.' }
        format.json { render :show, status: :created, location: @eveniment }
      else
        format.html { render :new }
        format.json { render json: @eveniment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eveniments/1
  # PATCH/PUT /eveniments/1.json
  def update
    respond_to do |format|
      if @eveniment.update(eveniment_params)
        format.html { redirect_to @eveniment, notice: 'Eveniment was successfully updated.' }
        format.json { render :show, status: :ok, location: @eveniment }
      else
        format.html { render :edit }
        format.json { render json: @eveniment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eveniments/1
  # DELETE /eveniments/1.json
  def destroy
    @eveniment.destroy
    respond_to do |format|
      format.html { redirect_to eveniments_url, notice: 'Eveniment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eveniment
      @eveniment = Eveniment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eveniment_params
      params.require(:eveniment).permit(:title, :description, :date, :timestart, :timeend, :category, :price, :location)
    end
end
