class CargosController < ApplicationController
  def show
    @cargo = Cargo.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @cargo }
    end
  end

end
