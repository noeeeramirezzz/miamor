class ClientesController < ApplicationController
  # Lista de clientes
  def index
    @q = params[:q]
    clientes = if @q.present?
                 Cliente.where("nombre ILIKE ? OR email ILIKE ? OR telefono ILIKE ?", "%#{@q}%", "%#{@q}%", "%#{@q}%")
               else
                 Cliente.all
               end

    @clientes = clientes.order(:id).page(params[:page]).per(10)
  end

  # Formulario para nuevo cliente
  def new
    @cliente = Cliente.new
  end

  # Formulario para editar cliente
  def edit
    @cliente = Cliente.find(params[:id])
  end

  # Crear cliente
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      redirect_to clientes_path, notice: 'Cliente creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Actualizar cliente
  def update
    @cliente = Cliente.find(params[:id])

    if @cliente.update(cliente_params)
      redirect_to clientes_path, notice: 'Cliente actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Eliminar cliente
  def destroy
    @cliente = Cliente.find(params[:id])

    if @cliente.eventos.exists?
      redirect_to clientes_path, alert: "No se puede eliminar: el cliente tiene eventos registrados."
    else
      @cliente.destroy
      redirect_to clientes_path, notice: "Cliente eliminado correctamente."
    end
  end


  private

  def cliente_params
    params.require(:cliente).permit(:nombre, :tipo, :telefono, :email, :direccion, :creado_en, :actualizado_en)
  end
end


