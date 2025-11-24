class EventosController < ApplicationController

  # Lista de eventos
  def index
    @q = params[:q]
    eventos = if @q.present?
                Evento.joins(:cliente).where(
                  "eventos.nombre_evento ILIKE ? OR eventos.lugar ILIKE ? OR clientes.nombre ILIKE ?",
                  "%#{@q}%", "%#{@q}%", "%#{@q}%"
                )
              else
                Evento.all.includes(:cliente)
              end

    @eventos = eventos.order(:id).page(params[:page]).per(10)
  end

  # Formulario nuevo
  def new
    @evento = Evento.new
  end

  # Formulario editar
  def edit
    @evento = Evento.find(params[:id])
  end

  # Crear
  def create
    @evento = Evento.new(evento_params)

    if @evento.save
      redirect_to eventos_path, notice: 'Evento creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Actualizar
  def update
    @evento = Evento.find(params[:id])

    if @evento.update(evento_params)
      redirect_to eventos_path, notice: 'Evento actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Eliminar
  def destroy
    @evento = Evento.find(params[:id])
    @evento.destroy
    redirect_to eventos_path, notice: 'Evento eliminado exitosamente.'
  end

  # IMPORTANTE PARA JSON
  def show
    @evento = Evento.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @evento }
    end
  end

  private

  def evento_params
    params.require(:evento).permit(
      :cliente_id, :nombre_evento, :tipo_evento, :estado, :fecha_inicio, :fecha_fin, :lugar,
      asignaciones_attributes: [
        :id, :servicio_id, :empleado_id, :rol, :tarea, :estado, :_destroy
      ]
    )
  end

end
