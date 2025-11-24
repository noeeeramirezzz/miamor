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

  # Devuelve JSON del servicio (incluye categoría)
  def show
    @servicio = Servicio.find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        render json: {
          id: @servicio.id,
          nombre: @servicio.nombre,
          categoria: @servicio.categoria
        }
      end
    end
  end

  # ==========================
  # 💥 Empleados por servicio
  # ==========================
  #
  # Ya NO usamos esta ruta → /servicios/:id/empleados
  # (Ahora usamos EmpleadosController#por_categoria)
  #
  # Pero dejamos este método por compatibilidad
  #
  def empleados
    servicio = Servicio.find(params[:id])
    categoria = servicio.categoria

    categorias_a_cargos = {
      "Decoración" => [1, 2, 3, 4],
      "Luces" => [5],
      "Sonido" => [6, 7, 8],
      "Fotografias" => [9],
      "Servicio de Atención" => [10, 11, 12],
      "Animación" => [13, 14]
    }

    cargos_ids = categorias_a_cargos[categoria] || []
    empleados = Empleado.where(cargo_id: cargos_ids)

    render json: empleados.select(:id, :nombre)
  end

  # Formulario nuevo
  def new
    @servicio = Servicio.new
  end

  # Formulario editar
  def edit
    @servicio = Servicio.find(params[:id])
  end

  # JSON para costo base
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

    if @servicio.asignacion_detalles.exists? || @servicio.detalle_contratos.exists?
      redirect_to servicios_path, alert: "No se puede eliminar: el servicio está siendo usado en asignaciones o contratos."
    else
      @servicio.destroy
      redirect_to servicios_path, notice: "Servicio eliminado correctamente."
    end
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
