Feature: Factura Venta
    Scenario: Agregar una nueva factura venta
        Given aplicacion esta corriendo 
        And estoy en la pantalla de factura venta
        When presiono el botón con el icono de "plus"
        And relleno los campos del formulario con la información la factura venta
        And presiono el botón de guardar
        Then debería ver un mensaje de confirmación de que factura ha sido creada exitosamente
    
    Scenario: Agregar una nueva factura venta sin llenar ningun campo
        Given aplicacion esta corriendo 
        And estoy en la pantalla de factura venta
        When presiono el botón con el icono de "plus"
        And presiono el botón de guardar        
        Then debería ver un mensaje de error