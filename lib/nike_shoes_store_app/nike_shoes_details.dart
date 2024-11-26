import 'package:flutter/material.dart';

class NikeShoesDetails extends StatelessWidget {
  NikeShoesDetails({super.key});

  final ValueNotifier<bool> notifierButtomVisible = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    // Método principal para construir la interfaz de usuario.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Callback que se ejecuta después de que el cuadro de la pantalla se renderiza completamente.
      notifierButtomVisible.value = true;
      // Cambia el valor del `ValueNotifier` a `true` para mostrar los botones flotantes.
    });
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildCarousel(context),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  ShakeTransition(
                    duration: const Duration(milliseconds: 1400),
                    offset: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(shoes.model, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('\$${shoes.oldPrice.toInt().toString()}', style: const TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough, fontSize: 13),
                              ),
                              Text('\$${shoes.currentPrice.toInt().toString()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const ShakeTransition(
                    duration: Duration(milliseconds: 1400),
                    offset: 20, 
                    child: Text('AVAILABLE SIZES', style: TextStyle(fontSize: 14),)),
                  const SizedBox(height: 20,),
                  const ShakeTransition(
                    duration: Duration(milliseconds: 1400),
                    offset: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _ShoesSizeItem(text: '6'),
                        _ShoesSizeItem(text: '7'),
                        _ShoesSizeItem(text: '9'),
                        _ShoesSizeItem(text: '10'),
                        _ShoesSizeItem(text: '11'),
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('DESCRIPTION', style: TextStyle(fontSize: 11),),
                  const SizedBox(height: 20,),
                  ],),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.65,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          color: Color(shoes.color),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
            // Widget que escucha cambios en `notifierButtomVisible` y reconstruye su contenido en consecuencia.
            valueListenable: notifierButtomVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight,
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
                        onPressed: () {}
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