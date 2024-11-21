import 'package:flutter/material.dart';
// Importación del paquete principal de Flutter para crear la interfaz gráfica.

class NikeShoesDetails extends StatelessWidget {
  // Clase que representa la pantalla de detalles de un zapato Nike.
  NikeShoesDetails({super.key});

  final ValueNotifier<bool> notifierButtomVisible = ValueNotifier(false);
  // `ValueNotifier` para controlar la visibilidad del botón flotante inferior.

  @override
  Widget build(BuildContext context) {
    // Método principal para construir la interfaz de usuario.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Callback que se ejecuta después de que el cuadro de la pantalla se renderiza completamente.
      notifierButtomVisible.value = true;
      // Cambia el valor del `ValueNotifier` a `true` para mostrar los botones flotantes.
    });

    return Scaffold(
      // Estructura básica de la pantalla.
      appBar: AppBar(),
      // Barra superior de la pantalla (puede incluir un título u otras acciones).

      body: Stack(
        // `Stack` permite superponer widgets en el área de contenido.
        children: <Widget>[
          ValueListenableBuilder<bool>(
            // Widget que escucha cambios en `notifierButtomVisible` y reconstruye su contenido en consecuencia.
            valueListenable: notifierButtomVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                // Widget que anima la posición de los botones flotantes en la parte inferior.
                duration: const Duration(milliseconds: 600),
                // Duración de la animación.

                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight,
                // Mueve los botones hacia arriba o fuera de la pantalla dependiendo del valor de `value`.

                child: Padding(
                  // Padding alrededor de los botones flotantes.
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    // Contenedor que organiza los botones en fila.
                    children: <Widget>[
                      FloatingActionButton(
                        // Primer botón flotante (favoritos).
                        heroTag: 'fav_1',
                        // Etiqueta única para evitar conflictos en la animación.

                        backgroundColor: Colors.white,
                        // Color de fondo del botón.

                        child: const Icon(
                          Icons.favorite,
                          color: Colors.black,
                        ),
                        // Ícono de corazón que representa la acción de añadir a favoritos.

                        onPressed: () {
                          // Acción que se ejecuta cuando el botón es presionado.
                        },
                      ),

                      const Spacer(),
                      // Añade espacio flexible entre los dos botones.

                      FloatingActionButton(
                        // Segundo botón flotante (carrito de compras).
                        heroTag: 'fav_2',
                        // Etiqueta única para evitar conflictos en la animación.

                        backgroundColor: Colors.black,
                        // Color de fondo del botón.

                        child: const Icon(Icons.shopping_cart_outlined),
                        // Ícono de carrito de compras que representa la acción de añadir al carrito.

                        onPressed: () {
                          // Acción que se ejecuta cuando el botón es presionado.
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
