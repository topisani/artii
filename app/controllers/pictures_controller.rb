class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :check_user, only: [:edit, :update, :destroy, :create, :new]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = (params[:username] != nil) ? User.find_by_username(params[:username]).pictures : Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/picker
  def picker
  end
  # GET /pictures/new
  def new
    @picture = @current_user.pictures.new
  end

  # GET /pictures/1/edit
  def edit
    render layout: "empty"
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = @current_user.pictures.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render json: { message: "success", file_id: @picture.id, action: "create"}, :status => 200}
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    @picture.image.crop params[:picture][:image_crop_x].to_i, params[:picture][:image_crop_y].to_i, params[:picture][:image_crop_w].to_i, params[:picture][:image_crop_h].to_i
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render json: { message: "success", file_id: @picture.id, action: "update" } }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { render json: { message: "success", action: "destroy" } }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def check_user
    unless logged_in?
      redirect_to login_url
    end
    begin
      unless @picture.user == @current_user
        redirect_to login_url
      end
    rescue
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :name, :image)
  end
end
