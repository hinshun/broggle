module Broggle
  class BrogglesController < ApplicationController
    def index
    end

    def create
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    def deploy
      broggle.deploy(params[:branches])
      redirect_to action: "index"
    end

    def search
      json = broggle.branches_flex_score(params[:query], 10)
      render json: json
    end

    def broggle
      @broggle ||= Broggle.new
    end
  end
end
