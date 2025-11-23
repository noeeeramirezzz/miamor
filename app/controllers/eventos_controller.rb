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



  # Formulario para nuevo evento
  def new
    @evento = Evento.new
  end

  # Formulario para editar evento
  def edit
    @evento = Evento.find(params[:id])
  end

  # Crear evento
  def create
    @evento = Evento.new(evento_params)

    if @evento.save
      redirect_to eventos_path, notice: 'Evento creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Actualizar evento
  def update
    @evento = Evento.find(params[:id])

    if @evento.update(evento_params)
      redirect_to eventos_path, notice: 'Evento actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Eliminar evento
  def destroy
    @evento = Evento.find(params[:id])
    @evento.destroy
    redirect_to eventos_path, notice: 'Evento eliminado exitosamente.'
  end

  private

  def evento_params
    params.require(:evento).permit(:cliente_id, :nombre_evento, :tipo_evento, :fecha_inicio, :fecha_fin, :lugar, :estado, :creado_en, :actualizado_en)
  end
end
