class AsignacionesController < ApplicationController

  # Lista de asignaciones
  def index
    @q = params[:q]
    asignaciones = if @q.present?
                     Asignacion.joins(:evento).where(
                       "eventos.nombre_evento ILIKE ? OR asignaciones.estado ILIKE ?",
                       "%#{@q}%", "%#{@q}%"
                     )
                   else
                     Asignacion.all.includes(:evento)
                   end

    @asignaciones = asignaciones.order(:id).page(params[:page]).per(10)
  end

  # Formulario nuevo
  def new
    @asignacion = Asignacion.new

    # NECESARIO PARA QUE APAREZCA LA PRIMERA FILA EN LA TABLA
    @asignacion.asignacion_detalles.build
  end

  # Formulario editar
  def edit
    @asignacion = Asignacion.includes(:asignacion_detalles).find(params[:id])
    @asignacion.asignacion_detalles.build if @asignacion.asignacion_detalles.empty?
  end


  # Crear asignación
  def create
    @asignacion = Asignacion.new(asignacion_params)

    if @asignacion.save
      redirect_to asignaciones_path, notice: "Asignación creada exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Actualizar asignación
  def update
    @asignacion = Asignacion.find(params[:id])

    if @asignacion.update(asignacion_params)
      redirect_to asignaciones_path, notice: "Asignación actualizada exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Eliminar asignación
  def destroy
    @asignacion = Asignacion.find_by(id: params[:id])

    unless @asignacion
      return redirect_to asignaciones_path, alert: "La asignación ya no existe o ya fue eliminada."
    end

    @asignacion.destroy
    redirect_to asignaciones_path, notice: "Asignación eliminada exitosamente."
  end



  private

  def asignacion_params
    params.require(:asignacion).permit(
      :evento_id,
      :estado,
      asignacion_detalles_attributes: [:id, :servicio_id, :empleado_id, :tarea, :_destroy]
    )
  end

end
