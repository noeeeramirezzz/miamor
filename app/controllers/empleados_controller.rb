class EmpleadosController < ApplicationController
  before_action :set_empleado, only: [:edit, :update, :destroy]

  CATEGORIAS_A_CARGOS = {
    "Decoración" => [1, 2, 3, 4],
    "Luces" => [5],
    "Sonido" => [6, 7, 8],
    "Fotografias" => [9],
    "Servicio de Atención" => [10, 11, 12],
    "Animación" => [13, 14]
  }

  def index
    @q = params[:q]
    empleados = if @q.present?
                  Empleado.joins(:cargo).where(
                    "empleados.nombre ILIKE ? OR empleados.email ILIKE ? OR cargos.nombre ILIKE ?",
                    "%#{@q}%", "%#{@q}%", "%#{@q}%"
                  )
                else
                  Empleado.all.includes(:cargo)
                end

    @empleados = empleados.order(:id).page(params[:page]).per(10)
  end

  def new
    @empleado = Empleado.new
    @cargos = Cargo.all
  end

  def edit
    @cargos = Cargo.all
  end

  def create
    @empleado = Empleado.new(empleado_params)
    @empleado.creado_en = Time.zone.now
    @empleado.actualizado_en = Time.zone.now

    if @empleado.save
      redirect_to empleados_path, notice: "Empleado creado correctamente."
    else
      @cargos = Cargo.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @empleado.actualizado_en = Time.zone.now

    if @empleado.update(empleado_params)
      redirect_to empleados_path, notice: "Empleado actualizado exitosamente."
    else
      @cargos = Cargo.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @empleado = Empleado.find(params[:id])

    if @empleado.asignacion_detalles.exists?
      redirect_to empleados_path, alert: "No se puede eliminar: el empleado tiene asignaciones registradas."
    else
      @empleado.destroy
      redirect_to empleados_path, notice: "Empleado eliminado correctamente."
    end
  end

  # 💥 Acción definitiva — devuelve empleados según categoría del servicio
  def por_categoria
    categoria = params[:categoria]

    cargos_ids = CATEGORIAS_A_CARGOS[categoria] || []

    empleados = Empleado.where(cargo_id: cargos_ids)
                        .where.not(activo: false)  # ⬅️ SOLO ocultamos inactivos

    render json: empleados.select(:id, :nombre)
  end


  private

  def set_empleado
    @empleado = Empleado.find(params[:id])
  end

  def empleado_params
    params.require(:empleado).permit(
      :nombre,
      :telefono,
      :email,
      :salario,
      :fecha_contratacion,
      :activo,
      :cargo_id
    )
  end
end
