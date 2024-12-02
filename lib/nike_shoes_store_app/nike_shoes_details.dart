import 'package:flutter/material.dart';
// Importa la biblioteca principal de Flutter para crear interfaces gráficas.

import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shopping_cart.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/shake_transition.dart';
// Importa módulos personalizados relacionados con la tienda de zapatos Nike: 
// `nike_shoes.dart` para los datos de los zapatos, 
// `nike_shopping_cart.dart` para el carrito de compras, 
// `shake_transition.dart` para animaciones de transición.

class NikeShoesDetails extends StatelessWidget {
// Define un widget sin estado (`StatelessWidget`) para mostrar los detalles de los zapatos.

  NikeShoesDetails({super.key, required this.shoes});
  // Constructor que recibe un objeto `shoes` de tipo `NikeShoes`.

  final NikeShoes shoes;
  // Variable que contiene la información del zapato seleccionado.

  final ValueNotifier<bool> notifierButtomVisible = ValueNotifier(false);
  // `ValueNotifier` permite notificar cambios de estado a los widgets dependientes. Aquí controla la visibilidad del botón inferior.

  Future<void> _openShoppingCart(BuildContext context) async {
    notifierButtomVisible.value = false;
    // Oculta el botón antes de navegar.

    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoppingCart(shoes: shoes),
          );
          // Abre el carrito con una animación de desvanecimiento.
        },
      ),
    );
    notifierButtomVisible.value = true;
    // Vuelve a mostrar el botón al regresar.
  }

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Obtiene las dimensiones de la pantalla.

    return SizedBox(
      height: size.height * 0.5,
      // Contenedor que ocupa el 50% de la altura de la pantalla.

      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Hero(
              tag: 'background_${shoes.model}',
              child: Container(
                color: Color(shoes.color),
                // Muestra un fondo de color asociado al modelo del zapato.
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: Hero(
              tag: 'number_${shoes.model}',
              child: ShakeTransition(
                axis: Axis.vertical,
                duration: const Duration(milliseconds: 1400),
                offset: 15,
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.05),
                        fontWeight: FontWeight.bold,
                      ),
                      // Muestra un número de modelo como fondo decorativo.
                    ),
                  ),
                ),
              ),
            ),
          ),
          PageView.builder(
            itemCount: shoes.images.length,
            itemBuilder: (context, index) {
              final tag = index == 0 ? 'image_${shoes.model}' : 'image_${shoes.model}_$index';
              return Container(
                alignment: Alignment.center,
                child: ShakeTransition(
                  axis: Axis.vertical,
                  duration: const Duration(milliseconds: 1400),
                  offset: 10,
                  child: Hero(
                    tag: tag,
                    child: Image.asset(
                      shoes.images[index],
                      height: 200,
                      width: 200,
                      // Muestra imágenes del zapato con animación.
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtomVisible.value = true;
      // Hace visible el botón después de que la construcción del widget haya terminado.
    });
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/nike_shoes_store/nike_logo.png',
          height: 40,
          // Barra de navegación con el logotipo de Nike.
        ),
        leading: const BackButton(color: Colors.black),
        // Botón de regreso.
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildCarousel(context),
                // Muestra el carrusel de imágenes.

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
                            Text(
                              shoes.model,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              // Muestra el modelo del zapato.
                            ),
                            const Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '\$${shoes.oldPrice.toInt().toString()}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13,
                                    ),
                                    // Precio anterior tachado.
                                  ),
                                  Text(
                                    '\$${shoes.currentPrice.toInt().toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    // Precio actual.
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ShakeTransition(
                        duration: Duration(milliseconds: 1400),
                        offset: 20,
                        child: Text(
                          'AVAILABLE SIZES',
                          style: TextStyle(fontSize: 14),
                          // Título para las tallas disponibles.
                        ),
                      ),
                      const SizedBox(height: 20),
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
                            // Botones de selección de talla.
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(fontSize: 11),
                        // Título para la descripción.
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: notifierButtomVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight * 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: 'fav_1',
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.favorite, color: Colors.black),
                        onPressed: () {
                          // Acción para añadir a favoritos.
                        },
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        heroTag: 'fav_2',
                        backgroundColor: Colors.black,
                        child: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          _openShoppingCart(context);
                          // Abre el carrito de compras.
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

class _ShoesSizeItem extends StatelessWidget {
  const _ShoesSizeItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        'US $text',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
        // Muestra una talla en un botón.
      ),
    );
  }
}
