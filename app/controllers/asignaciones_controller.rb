class AsignacionesController < ApplicationController
  # Lista de asignaciones
  def index
    @q = params[:q]
    asignaciones = if @q.present?
                     Asignacion.joins(:evento, :empleado).where(
                       "eventos.nombre_evento ILIKE ? OR empleados.nombre ILIKE ? OR asignaciones.estado ILIKE ?",
                       "%#{@q}%", "%#{@q}%", "%#{@q}%"
                     )
                   else
                     Asignacion.all.includes(:evento, :empleado)
                   end

    @asignaciones = asignaciones.order(:id).page(params[:page]).per(10)
  end

  # Formulario nuevo
  def new
    @asignacion = Asignacion.new
  end

  # Formulario editar
  def edit
    @asignacion = Asignacion.find(params[:id])
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
    @asignacion = Asignacion.find(params[:id])
    @asignacion.destroy
    redirect_to asignaciones_path, notice: "Asignación eliminada exitosamente."
  end

  private

  def asignacion_params
    params.require(:asignacion).permit(
      :evento_id,
      :empleado_id,
      :rol,
      :tarea,
      :estado,
      :creado_en,
      :actualizado_en
    )
  end
end
