class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy, :make_admin, :revoke_admin]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)
    @address.admin = false

    respond_to do |format|
      if @address.not_duplicate && @address.save
        format.html { redirect_to action: 'index', notice: 'Address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        flash[:alert] = "Make sure address is unique and formatted correctly."
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
    end
  end

  def make_admin
    if user = User.find_by_email(@address.email)
      user.admin = true
      user.save
    end
    @address.admin = true
    @address.save
    flash[:notice] = "User is now has admin privileges."
    redirect_to :action => 'index'
  end
  
  def revoke_admin
    if user = User.find_by_email(@address.email)
      user.admin = false
      user.save
    end
    @address.admin = false
    @address.save
    flash[:notice] = "User no longer has admin privileges. This will take effect on reload or redirect."
    redirect_to :action => 'index'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:email, :admin)
    end
end
