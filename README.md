Problema: Aprobación de Solicitudes de Gasto de un Proyecto

En este escenario, estamos abordando el proceso de aprobación de solicitudes de gasto en una organización. Para gestionar este proceso, utilizamos el patrón de diseño "Chain of Responsibility", que permite que las solicitudes sean manejadas por una serie de manejadores o aprobadores en una jerarquía, en este caso sera entre Empleado, Supervisor, Gerente.

Funcionamiento:

Las solicitudes de gasto se envían a través de una cadena de manejadores(Compose) comenzando desde el nivel más bajo (Empleado) hasta el nivel más alto (Gerente). Cada manejador toma una decisión basada en su límite de aprobación y aprueba o pasa la solicitud al siguiente nivel según corresponda. Si la solicitud no se aprueba en ningún nivel, se considera no aprobada.

Este enfoque permite una gestión eficiente y jerárquica de las solicitudes de gasto, donde cada nivel de aprobación tiene su propia capacidad de decisión. La estructura de cadena de responsabilidad asegura que las solicitudes sean manejadas por el nivel adecuado y se optimice el proceso de aprobación en toda la organización.





