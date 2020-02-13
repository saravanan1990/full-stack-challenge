class CompaniesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    respond_to do |format|
      format.html {}
      format.json {render json: {message: @companies}, status: 200}
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    response_hash = @company.get_company_detail
    respond_to do |format|
      format.html {}
      format.json {render json: {message: response_hash}, status: 200}
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    respond_to do |format|
      format.html {}
      format.json {render json: {message: @company}, status: 200}
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    params[:company][:founded_on] = params[:company][:founded_on].blank? ? Date.today : params[:company][:founded_on].to_date
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        response_hash = @company.get_company_detail
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json {render json: {message: response_hash}, status: 200}
      else
        format.html { render :new }
        error = @company.errors.keys[0].to_s.capitalize+" "+@company.errors.values[0][0].to_s
        format.json { render json: {message: error}, status: 400 }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        response_hash = @company.get_company_detail
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json {render json: {message: response_hash}, status: 200}
      else
        format.html { render :edit }
        error = @company.errors.keys[0].to_s.capitalize+" "+@company.errors.values[0][0].to_s
        format.json { render json: {message: error}, status: 422 }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    @companies = Company.all
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json {render json: {message: @companies}, status: 200}
    end
  end

  def search_companies
    col_name = 'name'
    @companies = Company.where("LOWER(#{col_name}) LIKE ?",'%' + params[:company][:name] + '%')
    respond_to do |format|
      format.html {}
      format.json {render json: {message: @companies}, status: 200}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :city, :state, :founded_on, :description)
    end
end
