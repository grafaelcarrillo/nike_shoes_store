import 'package:flutter/material.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart';

// Declaración de tamaños constantes que se utilizarán para los elementos animados
double _buttonSizeWidth = 160; // Ancho inicial del botón de "Añadir al carrito"
double _buttonSizeHeight = 60; // Altura inicial del botón
double _buttonCircularSize = 60.0; // Tamaño del botón reducido (circular)
double _finalImageSize = 30.0; // Tamaño final de la imagen del zapato durante la animación
double _imageSize = 120; // Tamaño inicial de la imagen del zapato

class NikeShoppingCart extends StatefulWidget {
  const NikeShoppingCart({super.key, required this.shoes});

  // Recibe como parámetro un objeto "shoes" con la información del zapato seleccionado
  final NikeShoes shoes;

  @override
  State<NikeShoppingCart> createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  // Controlador de animaciones para gestionar el estado de las transiciones
  late AnimationController _controller;

  // Animaciones específicas:
  late Animation _animationResize; // Cambia el tamaño de elementos durante la animación
  late Animation _animationMovementIn; // Mueve el panel hacia adentro
  late Animation _animationMovementOut; // Mueve el botón hacia afuera

  @override
  void initState() {
    super.initState();

    // Configura el controlador de animación con una duración total de 2000 ms
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Define las diferentes animaciones con sus curvas de transición y momentos específicos
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3), // Ocurre en el 0%-30% de la animación
      ),
    );

    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticIn),
      ),
    );

    // Listener para detectar cuándo la animación llega a su fin
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Cierra la pantalla al completar la animación
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    // Libera los recursos del controlador al destruir el widget
    _controller.dispose();
    super.dispose();
  }

  /// Construye el panel inferior donde se muestra el zapato y sus detalles.
  Widget _buildPanel() {
    final size = MediaQuery.of(context).size; // Tamaño de la pantalla del dispositivo

    // Calcula el tamaño actual de la imagen basado en la animación de redimensionamiento
    final currentImageSize = (_imageSize * _animationResize.value)
        .clamp(_finalImageSize, _imageSize);

    // Widget animado que mueve el panel de abajo hacia arriba
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn, // Transición suave al aparecer
      tween: Tween(begin: 1, end: 0.0), // Animación de desplazamiento
      builder: (context, value, child) {
        return Transform.translate(
          // Mueve el panel en el eje Y según el progreso de la animación
          offset: Offset(0.0, value * size.height * 0.6),
          child: child,
        );
      },
      child: Container(
        // Ajusta el tamaño del panel según la animación de redimensionamiento
        height: (size.height * 0.6 * _animationResize.value)
            .clamp(_buttonCircularSize, size.height * 0.6),
        width: (size.width * _animationResize.value)
            .clamp(_buttonCircularSize, size.width),
        decoration: BoxDecoration(
          color: Colors.white, // Color de fondo del panel
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30),
            topRight: const Radius.circular(30),
            bottomLeft: _animationResize.value == 1
                ? const Radius.circular(0)
                : const Radius.circular(30),
            bottomRight: _animationResize.value == 1
                ? const Radius.circular(0)
                : const Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationResize.value == 1.0
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Imagen del zapato con tamaño animado
                  Image.asset(
                    widget.shoes.images.first,
                    height: currentImageSize,
                  ),
                  if (_animationResize.value == 1.0) ...[
                    const SizedBox(width: 20), // Espaciado entre imagen y texto
                    Column(
                      children: <Widget>[
                        // Texto que muestra el modelo del zapato
                        Text(
                          widget.shoes.model,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        // Texto que muestra el precio del zapato
                        Text(
                          '\$${widget.shoes.currentPrice.toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Calcula el ancho del botón basado en la animación
          final buttonSizeWidth = (_buttonSizeWidth * _animationResize.value)
              .clamp(_buttonCircularSize, _buttonSizeWidth);
          final panelSizeWidth = (size.width * _animationResize.value)
              .clamp(_buttonCircularSize, size.width);

          return Stack(
            fit: StackFit.expand, // El stack ocupará todo el espacio disponible
            children: <Widget>[
              // Fondo oscuro que se puede tocar para cerrar el panel
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Cierra la pantalla
                  },
                  child: Container(
                    color: Colors.black87,
                  ),
                ),
              ),
              // Panel y botón animados
              Positioned.fill(
                child: Stack(
                  children: <Widget>[
                    if (_animationMovementIn.value != 1.0)
                      // Panel inferior que contiene la información del zapato
                      Positioned(
                        top: size.height * 0.4 +
                            (_animationMovementIn.value * size.height * 0.45),
                        left: size.width / 2 - panelSizeWidth / 2,
                        width: panelSizeWidth,
                        child: _buildPanel(),
                      ),
                    // Botón flotante de "Añadir al carrito"
                    Positioned(
                      bottom: (40 - (_animationMovementOut.value * 100))
                          .toDouble(),
                      left: size.width / 2 - buttonSizeWidth / 2,
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        tween: Tween(begin: 1, end: 0.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            // Mueve el botón verticalmente durante la animación
                            offset: Offset(0.0, value * size.height * 0.6),
                            child: child,
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            _controller.forward(); // Inicia la animación
                          },
                          child: Container(
                            // Dimensiones y estilo del botón
                            width: buttonSizeWidth,
                            height: (_buttonSizeHeight * _animationResize.value)
                                .clamp(_buttonCircularSize, _buttonSizeHeight),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Expanded(
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (_animationResize.value == 1) ...[
                                    const SizedBox(width: 5),
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'ADD TO CART',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
