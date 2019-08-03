require 'uri'
require 'net/http'
require 'httparty'

class AssignmentsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  def get_smartthing
	  url = URI("https://api.smartthings.com/devices/e0669a94-37d8-40ac-8555-13bc4f90d442/status")

	  http = Net::HTTP.new(url.host, url.port)
	  http.use_ssl = true
	  
	  request = Net::HTTP::Get.new(url)
	  request["Content-Type"] = 'application/x-www-form-urlencoded'
	  request["Authorization"] = 'Bearer 8999214c-f19a-4df3-bea3-031a35383635'
	  request["User-Agent"] = 'PostmanRuntime/7.15.0'
	  request["Accept"] = '*/*'
	  request["Cache-Control"] = 'no-cache'
	  request["Postman-Token"] = 'b1fef25d-5881-4764-b85d-b7787b3c6d16,577b1b2a-680e-45e7-83b9-d22703582e9a'
	  request["Host"] = 'api.smartthings.com'
	  request["Connection"] = 'keep-alive'
	  request["cache-control"] = 'no-cache'

	  response = http.request(request)
	  # puts response.read_body
	  north_x = JSON.parse(response.read_body)["components"]["main"]["threeAxis"]["threeAxis"]["value"][0] 
	  north_y = JSON.parse(response.read_body)["components"]["main"]["threeAxis"]["threeAxis"]["value"][1] 
	  north_z = JSON.parse(response.read_body)["components"]["main"]["threeAxis"]["threeAxis"]["value"][2] 

	  north_theta = Math.atan(north_x / (Math.sqrt(north_y**2 + north_z**2))) * 180 / Math::PI
	  north_psi = Math.atan(north_y / (Math.sqrt(north_x**2 + north_z**2))) * 180 / Math::PI
	  north_phi = Math.atan(Math.sqrt(north_x**2 + north_y**2)/ north_z) * 180 / Math::PI

	  url = URI("https://api.smartthings.com/devices/dd82296e-44ce-46ee-a8c9-8cfdb57e67c5/status") 

	  http = Net::HTTP.new(url.host, url.port)
	  http.use_ssl = true
	  
	  request = Net::HTTP::Get.new(url)
	  request["Content-Type"] = 'application/x-www-form-urlencoded'
	  request["Authorization"] = 'Bearer 8999214c-f19a-4df3-bea3-031a35383635'
	  request["User-Agent"] = 'PostmanRuntime/7.15.0'
	  request["Accept"] = '*/*'
	  request["Cache-Control"] = 'no-cache'
	  request["Postman-Token"] = 'b1fef25d-5881-4764-b85d-b7787b3c6d16,577b1b2a-680e-45e7-83b9-d22703582e9a'
	  request["Host"] = 'api.smartthings.com'
	  request["Connection"] = 'keep-alive'
	  request["cache-control"] = 'no-cache'

	  response = http.request(request)

	  south_x = JSON.parse(response.read_body)["components"]["main"]["threeAxis"]["threeAxis"]["value"][0] 
	  south_y = JSON.parse(response.read_body)["components"]["main"]["threeAxis"]["threeAxis"]["value"][1] 
	  south_z = JSON.parse(response.read_body)["components"]["main"]["threeAxis"]["threeAxis"]["value"][2] 

	  south_theta = Math.atan(south_x / (Math.sqrt(south_y**2 + south_z**2))) * 180 / Math::PI
	  south_psi = Math.atan(south_y / (Math.sqrt(south_x**2 + south_z**2))) * 180 / Math::PI
	  south_phi = Math.atan(Math.sqrt(south_x**2 + south_y**2)/ south_z) * 180 / Math::PI

	  @dif_theta = (north_theta-south_theta).round(2)

	  @dif_psi = north_psi - south_psi
	  @dif_phi = north_phi - south_phi
	  
	  puts north_x-south_x
	  puts north_y-south_y
	  puts north_z-south_z
  end


  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:member_id, :committee_id)
    end
end
