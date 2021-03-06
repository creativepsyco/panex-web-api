class AppsController < ApplicationController
  include AppsHelper
  before_filter :authenticate_user!, :except => [:index, :show]
  # GET /apps
  # GET /apps.json
  def index
    @user = nil
    if not params[:user_id].nil?
      @user = User.find(params[:user_id])
    end

    if not @user.nil?
      @apps = App.find_all_by_user_id(@user.id)
    else
      @apps = App.all  
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @app = App.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.zip { generate_zip(@app) }
      format.json { render json: @app }
    end
  end

  # GET /apps/new
  # GET /apps/new.json
  def new
    @app = App.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @app = App.find(params[:id])
  end

  # POST /apps
  # POST /apps.json
  def create
    puts params
    # XXX: make sure authenticated person is same
    app_data = {
      :name => params[:name],
      :description => params[:description],
      :thumbnail => params[:thumbnail],
      :helpLink => params[:helpLink],
      :version => params[:version],
      :user_id => params[:user_id],
      :appFile => params[:appFile]
    }
    @app = App.new(app_data)
    
    respond_to do |format|
      if @app.save
        format.html #{ redirect_to @app, notice: 'App was successfully created.' }
        format.json { render json: @app, status: :created }
      else
        format.html # { render action: "new" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.json
  def update
    @app = App.find(params[:id])
    @app.user = User.find(params[:user_id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html # { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html # { redirect_to apps_url }
      format.json { head :no_content }
    end
  end
end
