class EmpleadosController < ApplicationController
  before_action :set_empleado, only: [:edit, :update, :destroy, :show]

  # Lista de empleados
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


  #  Formulario para nuevo empleado
  def new
    @empleado = Empleado.new
    @cargos = Cargo.all
  end

  # Formulario para editar empleado
  def edit
    @cargos = Cargo.all
  end

  # Crear empleado
  def create
    @empleado = Empleado.new(empleado_params)
    @empleado.creado_en = Time.zone.now
    @empleado.actualizado_en = Time.zone.now

    if @empleado.save
      salario_formateado = ActionController::Base.helpers.number_to_currency(
        @empleado.salario,
        unit: "₲",
        separator: ",",
        delimiter: "."
      )
      redirect_to empleados_path, notice: "Empleado creado correctamente ."
    else
      @cargos = Cargo.all
      render :new, status: :unprocessable_entity
    end
  end

  #  Actualizar empleado
  def update
    @empleado.actualizado_en = Time.zone.now

    if @empleado.update(empleado_params)
      redirect_to empleados_path, notice: "Empleado actualizado exitosamente."
    else
      @cargos = Cargo.all
      render :edit, status: :unprocessable_entity
    end
  end

  #  Eliminar empleado
  def destroy
    @empleado.destroy
    redirect_to empleados_path, notice: "Empleado eliminado exitosamente."
  end

  #  Mostrar detalle del empleado
  def show
  end

  private

  # Buscar empleado por ID
  def set_empleado
    @empleado = Empleado.find(params[:id])
  end

  #  Parámetros permitidos
  def empleado_params
    params.require(:empleado).permit(:nombre, :telefono, :email, :salario, :fecha_contratacion, :activo, :cargo_id)
  end

end
