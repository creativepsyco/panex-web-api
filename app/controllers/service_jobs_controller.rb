class ServiceJobsController < ApplicationController
  # GET /service_jobs
  # GET /service_jobs.json
  def index
    @service_jobs = ServiceJob.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @service_jobs }
    end
  end

  # GET /service_jobs/1
  # GET /service_jobs/1.json
  def show
    @service_job = ServiceJob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service_job }
    end
  end

  # GET /service_jobs/new
  # GET /service_jobs/new.json
  def new
    @service_job = ServiceJob.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service_job }
    end
  end

  # GET /service_jobs/1/edit
  def edit
    @service_job = ServiceJob.find(params[:id])
  end

  # POST /service_jobs
  # POST /service_jobs.json
  def create
    @service_job = ServiceJob.new(params[:service_job])

    respond_to do |format|
      if @service_job.save
        format.html { redirect_to @service_job, notice: 'Service job was successfully created.' }
        format.json { render json: @service_job, status: :created, location: @service_job }
      else
        format.html { render action: "new" }
        format.json { render json: @service_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /service_jobs/1
  # PUT /service_jobs/1.json
  def update
    @service_job = ServiceJob.find(params[:id])

    respond_to do |format|
      if @service_job.update_attributes(params[:service_job])
        format.html { redirect_to @service_job, notice: 'Service job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_jobs/1
  # DELETE /service_jobs/1.json
  def destroy
    @service_job = ServiceJob.find(params[:id])
    @service_job.destroy

    respond_to do |format|
      format.html { redirect_to service_jobs_url }
      format.json { head :no_content }
    end
  end
end
