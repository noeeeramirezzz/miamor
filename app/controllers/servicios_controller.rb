class ServiciosController < ApplicationController
  # Lista de servicios
  def index
    @q = params[:q]
    servicios = if @q.present?
                  Servicio.where(
                    "nombre ILIKE ? OR categoria ILIKE ? OR descripcion ILIKE ?",
                    "%#{@q}%", "%#{@q}%", "%#{@q}%"
                  )
                else
                  Servicio.all
                end

    @servicios = servicios.order(:id).page(params[:page]).per(10)
  end


  # Formulario nuevo
  def new
    @servicio = Servicio.new
  end

  # Formulario editar
  def edit
    @servicio = Servicio.find(params[:id])
  end

  def precio
    servicio = Servicio.find(params[:id])
    render json: { precio: servicio.costo_base }
  end

  # Crear servicio
  def create
    @servicio = Servicio.new(servicio_params)

    if @servicio.save
      redirect_to servicios_path, notice: "Servicio creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Actualizar servicio
  def update
    @servicio = Servicio.find(params[:id])

    if @servicio.update(servicio_params)
      redirect_to servicios_path, notice: "Servicio actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Eliminar servicio
  def destroy
    @servicio = Servicio.find(params[:id])
    @servicio.destroy
    redirect_to servicios_path, notice: "Servicio eliminado exitosamente."
  end

  private

  def servicio_params
    params.require(:servicio).permit(
      :nombre,
      :categoria,
      :descripcion,
      :costo_base,
      :activo,
      :creado_en,
      :actualizado_en
    )
  end


end

