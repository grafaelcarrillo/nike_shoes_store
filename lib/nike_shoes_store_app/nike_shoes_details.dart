// Importa las dependencias necesarias.
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shopping_cart.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/shake_transition.dart';
=======
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca

// Widget que representa la pantalla de detalles de los zapatos.
class NikeShoesDetails extends StatelessWidget {
<<<<<<< HEAD
  // Constructor que recibe un objeto NikeShoes para mostrar sus detalles.
  NikeShoesDetails({super.key, required this.shoes});
=======
  NikeShoesDetails({super.key});
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca

  // Objeto de tipo NikeShoes que contiene la información del producto.
  final NikeShoes shoes;

  // Notificador que controla la visibilidad de los botones flotantes.
  final ValueNotifier<bool> notifierButtomVisible = ValueNotifier(false);
<<<<<<< HEAD

  // Método para abrir el carrito de compras. Navega hacia la pantalla de carrito
  // con una transición y oculta temporalmente los botones flotantes.
  Future<void> _openShoppingCart(BuildContext context) async {
    notifierButtomVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // Permite que el fondo de la pantalla actual sea visible.
        pageBuilder: (_, animation1, animation2) {
          return FadeTransition(
            opacity: animation1, // Aplica un efecto de desvanecimiento.
            child: NikeShoppingCart(shoes: shoes), // Muestra la pantalla del carrito.
          );
        },
      ),
    );
    notifierButtomVisible.value = true; // Restaura la visibilidad de los botones flotantes.
  }

  // Método para construir el carrusel de imágenes de los zapatos.
  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla.
    return SizedBox(
      height: size.height * 0.5, // Define la altura del carrusel.
      child: Stack(
        children: <Widget>[
          // Fondo con un color correspondiente al zapato.
          Positioned.fill(
            child: Hero(
              tag: 'background_${shoes.model}', // Efecto Hero para la animación entre pantallas.
              child: Container(
                color: Color(shoes.color),
              ),
            ),
          ),
          // Texto del número de modelo.
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: Hero(
              tag: 'number_${shoes.model}', // Efecto Hero para el texto del modelo.
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
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Carrusel de imágenes de los zapatos.
          PageView.builder(
            itemCount: shoes.images.length, // Número de imágenes en el carrusel.
            itemBuilder: (context, index) {
              final tag = index == 0
                  ? 'image_${shoes.model}' // La primera imagen utiliza el tag principal.
                  : 'image_${shoes.model}_$index'; // Otras imágenes tienen tags únicos.
              return Container(
                alignment: Alignment.center,
                child: ShakeTransition(
                  axis: Axis.vertical,
                  duration: const Duration(milliseconds: 1400),
                  offset: 10,
                  child: Hero(
                    tag: tag,
                    child: Image.asset(
                      shoes.images[index], // Muestra la imagen correspondiente.
                      height: 200,
                      width: 200,
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

  // Método principal de construcción del widget.
=======
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
  @override
  Widget build(BuildContext context) {
    // Configura la visibilidad de los botones flotantes después de cargar la pantalla.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtomVisible.value = true;
    });
<<<<<<< HEAD

    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla.

    return Scaffold(
      // AppBar con el logo de Nike y un botón para regresar.
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/nike_shoes_store/nike_logo.png',
          height: 40,
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Contenido principal de la pantalla.
=======
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
<<<<<<< HEAD
                _buildCarousel(context), // Carrusel de imágenes.
=======
                _buildCarousel(context),
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
<<<<<<< HEAD
                      // Información del modelo y precios.
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
                            ),
                            const Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  // Precio anterior.
                                  Text(
                                    '\$${shoes.oldPrice.toInt().toString()}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13,
                                    ),
                                  ),
                                  // Precio actual.
                                  Text(
                                    '\$${shoes.currentPrice.toInt().toString()}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Tallas disponibles.
                      const ShakeTransition(
                        duration: Duration(milliseconds: 1400),
                        offset: 20,
                        child: Text(
                          'AVAILABLE SIZES',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Filas de tallas.
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
                      const SizedBox(height: 20),
                      // Descripción.
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(fontSize: 11),
                      ),
                      const SizedBox(height: 20),
=======
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
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
                    ],
                  ),
                ),
              ],
            ),
          ),
<<<<<<< HEAD
          // Botones flotantes para favoritos y carrito.
=======
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
          ValueListenableBuilder<bool>(
            valueListenable: notifierButtomVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
<<<<<<< HEAD
                duration: const Duration(milliseconds: 250),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight * 1.5,
=======
                duration: const Duration(milliseconds: 600),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight,
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      FloatingActionButton(
                        heroTag: 'fav_1',
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.favorite, color: Colors.black),
                        onPressed: () {}, // Acción del botón de favoritos.
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        heroTag: 'fav_2',
                        backgroundColor: Colors.black,
                        child: const Icon(Icons.shopping_cart_outlined),
<<<<<<< HEAD
                        onPressed: () {
                          _openShoppingCart(context); // Abre el carrito.
                        },
=======
                        onPressed: () {}
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
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
<<<<<<< HEAD
}

// Widget auxiliar para mostrar las tallas disponibles.
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
      ),
    );
  }
}
=======
}
>>>>>>> df405fd994fd1d65ad0aa424351df330944fecca
