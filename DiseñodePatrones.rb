# Definir la clase Handler base
class Handler
  attr_accessor :next_handler

  def initialize(next_handler = nil)
    @next_handler = next_handler
  end

  def aprobar(solicitud)
    if @next_handler
      @next_handler.aprobar(solicitud)
    else
      puts "Solicitud rechazada: #{solicitud}"
    end
  end
end

# Definir la clase CompositeHandler para manejar aprobaciones compuestas
class CompositeHandler < Handler
  def initialize
    @subordinates = []
    super()
  end

  def add_subordinate(subordinate)
    @subordinates << subordinate
  end

  def aprobar(solicitud)
    @subordinates.each do |subordinate|
      subordinate.aprobar(solicitud)
    end
  end
end

# Definir la clase EmpleadoHandler
class EmpleadoHandler < Handler
  def initialize(limite_aprobacion)
    @limite_aprobacion = limite_aprobacion
    super()
  end

  def aprobar(solicitud)
    if solicitud <= @limite_aprobacion
      puts "Solicitud aprobada por Empleado hasta $#{@limite_aprobacion}: #{solicitud}"
    else
      super(solicitud)
    end
  end
end

# Definir la clase SupervisorHandler
class SupervisorHandler < Handler
  def initialize(limite_aprobacion)
    @limite_aprobacion = limite_aprobacion
    super()
  end

  def aprobar(solicitud)
    if solicitud <= @limite_aprobacion
      puts "Solicitud aprobada por Supervisor hasta $#{@limite_aprobacion}: #{solicitud}"
    else
      super(solicitud)
    end
  end
end

# Definir la clase GerenteHandler
class GerenteHandler < Handler
  def initialize(limite_aprobacion)
    @limite_aprobacion = limite_aprobacion
    super()
  end

  def aprobar(solicitud)
    if solicitud <= @limite_aprobacion
      puts "Solicitud aprobada por Gerente hasta $#{@limite_aprobacion}: #{solicitud}"
    else
      super(solicitud)
    end
  end
end

# Crear la jerarquía de aprobadores
gerente = GerenteHandler.new(5000)
supervisor = SupervisorHandler.new(2000)
empleado = EmpleadoHandler.new(1000)

supervisor.next_handler = gerente
empleado.next_handler = supervisor

# Crear un arreglo de solicitudes con diferentes montos
solicitudes = [500, 1500, 350, 700, 1200, 4000, 5500, 6000]
solicitudes.sort!
solicitudes_aprobadas = []
puts "Solicitudes A aprobar: #{solicitudes}"

# Iterar a través de las solicitudes y procesarlas
solicitudes.each do |solicitud|
  if empleado.aprobar(solicitud)
    solicitudes_aprobadas << solicitud
  end
end

