class ContratosController < ApplicationController
  # Lista de contratos
  def index
    @q = params[:q]
    contratos = if @q.present?
                  Contrato.joins(:evento).where(
                    "eventos.nombre_evento ILIKE ? OR contratos.estado ILIKE ?",
                    "%#{@q}%", "%#{@q}%"
                  )
                else
                  Contrato.all.includes(:evento)
                end

    @contratos = contratos.order(:id).page(params[:page]).per(10)
  end


  def new
    @contrato = Contrato.new
    @contrato.detalle_contratos.build
  end

  def edit
    @contrato = Contrato.find(params[:id])
    @contrato.detalle_contratos.build if @contrato.detalle_contratos.empty?
  end

  # Crear contrato
  def create
    @contrato = Contrato.new(contrato_params)

    if @contrato.save
      redirect_to contratos_path, notice: "Contrato creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Actualizar contrato
  def update
    @contrato = Contrato.find(params[:id])

    if @contrato.update(contrato_params)
      redirect_to contratos_path, notice: "Contrato actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Eliminar contrato
  def destroy
    @contrato = Contrato.find(params[:id])
    @contrato.destroy
    redirect_to contratos_path, notice: "Contrato eliminado exitosamente."
  end

  private

  def contrato_params
    params.require(:contrato).permit(
      :numero_contrato,
      :evento_id,
      :fecha_contrato,
      :monto_total,
      :estado,
      detalle_contratos_attributes: [
        :id, :servicio_id, :cantidad, :precio_unitario, :subtotal, :notas, :_destroy
      ]
    )
  end

end
