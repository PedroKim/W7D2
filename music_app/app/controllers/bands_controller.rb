class BandsController < ApplicationController
    def index
        @bands = Band.all

        render :index
    end

    def show
        @band = Band.find_by(id: params[:id])

        render :show
    end

    def new
        @band = Band.new

        render :new
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            flash[:success] = "Successfully created band: #{ @band.name }"
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new, status: 422
        end
    end

    def edit
        @band = Band.find_by(id: params[:id])
        
        render :edit
    end

    def update
        @band = Band.find_by(id: params[:id])

        if @band.update_attributes(band_params)
            flash[:success] = "Successfully updated band: #{ @band.name }"
            redirect_to band_url(@band)
        else
            flash.now[:errors] = @band.errors.full_messages
            render :new, status: 422
        end
    end

    def destroy
        band = Band.find_by(id: params[:id])
        band.destroy
        flash[:success] = "Successfully deleted band: #{ band.name }"
        redirect_to bands_url
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end