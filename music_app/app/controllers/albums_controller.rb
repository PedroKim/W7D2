class AlbumsController < ApplicationController
    def show
        @album = Album.find_by(id: params[:id])

        render :show
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

end