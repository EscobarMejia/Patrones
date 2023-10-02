# Patrones de diseño
## Integrantes:
- Yarleque Ramos Gabriel Gerardo
- Escobar Mejia Alejandro Maycoll
# Implementacion de los patrones "Chain of Responsability" y "Composite"
El problema que resolvemos involucra lo siguiente:
Se requiere aprobar cierto monto financiero en una empresa, esta empresa tiene una jerarquía de empleado, supervisor y gerente.
El empleado puede aprobar ciertos montos hasta cierto límite, si el monto dado excede lo que el empleado puede aprobar, entonces la aprobación pasa a manos
del supervisor, de la misma forma, si el monto excede lo aceptado por el supervisor, entonces pasaría a gerente en última instancia, finalmente, si el gerente no esta habilitado para
aprobar el monto dado, entonces se rechaza la solicitud de monto.
# Funcionamiento

Las solicitudes de gasto se envían a través de una cadena de manejadores comenzando desde el nivel más bajo (Empleado) hasta el nivel más alto (Gerente). 
Cada manejador toma una decisión basada en su límite de aprobación y aprueba o pasa la solicitud al siguiente nivel según corresponda. 
Si la solicitud no se aprueba en ningún nivel, se considera no aprobada.

Este enfoque permite una gestión eficiente y jerárquica de las solicitudes de gasto, 
donde cada nivel de aprobación tiene su propia capacidad de decisión. 
La estructura de cadena de responsabilidad asegura que las solicitudes sean manejadas por el nivel adecuado y se optimice el proceso de aprobación en toda la organización.

# Definición de clase handler
Esta es la clase base para todos los manejadores. 
Tiene una propiedad next_handler que apunta al próximo manejador en la cadena (por defecto, es nil). 
El método aprobar es el método que maneja la solicitud. Si hay un próximo manejador en la cadena `(@next_handler)`, pasa la solicitud a ese manejador; de lo contrario, la solicitud se rechaza.
```ruby
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
  ```
  # Definimos la clase CompositeHandler para manejar aprobaciones compuestas(patron composite)
  Esta clase hereda de `Handler` y representa un manejador compuesto que agrupa a otros manejadores. Tiene una lista de @subordinates que almacena los manejadores que componen esta cadena. 
  El método add_subordinate se utiliza para agregar manejadores a la cadena. 
  Cuando se llama al método aprobar, itera a través de todos los manejadores en `@subordinates` y pasa la solicitud a cada uno de ellos.
  ```ruby
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
  ```
  # Definimos la clase EmpleadoHandler
  ```ruby
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
  ```
  # Definimos la clase SupervisorHandler
```ruby
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
  ```
  # Definir la clase GerenteHandler
```ruby
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
```
Estas últimas clases heredan de `Handler` y representan manejadores individuales con límites de aprobación diferentes. 
Cada uno tiene su propio límite `(@limite_aprobacion)`. El método aprobar verifica que el monto no pase lo establecido por estas clase, si el monto no puede ser aprobado por la primera entidad empleado,
pasa la solicitud al próximo manejador en la cadena llamando al método super. 
# Aplicación de los patrones y clases 
Creamos los objetos anteriormente mencionados, y asignamos el monto máximo que pueden aceptar, luego definimos un arreglo que contiene los montos que deben pasar a ser aprobados, o rechazados.
```ruby
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
```
