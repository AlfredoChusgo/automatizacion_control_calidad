Feature: Cliente
    Scenario: Agregar un nuevo cliente
        Given aplicacion esta corriendo 
        and estoy en la pantalla de clientes
        When presiono el botón con el icono de "plus"
        And relleno los campos del formulario con la información del cliente
        And presiono el botón de guardar
        Then debería ver un mensaje de confirmación de que el cliente ha sido agregado exitosamente