class DatabasesController < ApplicationController
  def index
  end

  def create
    @database = Database.create
    respond_to do |format|
      format.json do
        render :json => @database.attributes.merge(:config => { 'DATABASE_URL' => @database.url }).to_json,
               :status => 201
      end
      format.html do
        flash.now[:notice] = "Database created"
      end
    end
  end

  def destroy
    @database = Database.find params[:id]
    @database.destroy
    respond_to do |format|
      format.json do
        head :ok
      end
      format.html do
        flash[:notice] = "Database destroyed"
        redirect_to :action => :index
      end
    end
  rescue Database::Error
    respond_to do |format|
      format.json do
        head :status => 422
      end
      format.html do
        flash.now[:error] = "Could not find database"
        render :select_database
      end
    end
  end
end
