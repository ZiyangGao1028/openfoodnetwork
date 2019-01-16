class Api::V1::PetsController < ApplicationController
  # GET /api/v1/pets
  # GET /api/v1/pets.json
  def index
    @api_v1_pets = Api::V1::Pet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @api_v1_pets }
    end
  end

  # GET /api/v1/pets/1
  # GET /api/v1/pets/1.json
  def show
    @api_v1_pet = Api::V1::Pet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @api_v1_pet }
    end
  end

  # GET /api/v1/pets/new
  # GET /api/v1/pets/new.json
  def new
    @api_v1_pet = Api::V1::Pet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @api_v1_pet }
    end
  end

  # GET /api/v1/pets/1/edit
  def edit
    @api_v1_pet = Api::V1::Pet.find(params[:id])
  end

  # POST /api/v1/pets
  # POST /api/v1/pets.json
  def create
    @api_v1_pet = Api::V1::Pet.new(params[:api_v1_pet])

    respond_to do |format|
      if @api_v1_pet.save
        format.html { redirect_to @api_v1_pet, notice: 'Pet was successfully created.' }
        format.json { render json: @api_v1_pet, status: :created, location: @api_v1_pet }
      else
        format.html { render action: "new" }
        format.json { render json: @api_v1_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /api/v1/pets/1
  # PUT /api/v1/pets/1.json
  def update
    @api_v1_pet = Api::V1::Pet.find(params[:id])

    respond_to do |format|
      if @api_v1_pet.update_attributes(params[:api_v1_pet])
        format.html { redirect_to @api_v1_pet, notice: 'Pet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @api_v1_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/pets/1
  # DELETE /api/v1/pets/1.json
  def destroy
    @api_v1_pet = Api::V1::Pet.find(params[:id])
    @api_v1_pet.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_pets_url }
      format.json { head :no_content }
    end
  end
end
