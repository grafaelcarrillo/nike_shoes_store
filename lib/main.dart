// Importa las dependencias necesarias para el proyecto.
import 'package:flutter/material.dart'; // Librería principal de Flutter para diseño y widgets.
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart'; // Archivo que contiene la definición del modelo de los zapatos.
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes_details.dart'; // Archivo que contiene la vista de detalles de los zapatos.

// Define la función principal que inicia la aplicación.
void main() => runApp(const MyApp()); // Llama a la clase `MyApp` como la raíz de la aplicación.

// Define la clase principal de la aplicación, que extiende de StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor para definir la clave única del widget.

  @override
  Widget build(BuildContext context) {
    // Devuelve la estructura principal de la aplicación.
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la marca de depuración.
      theme: ThemeData.light(), // Usa el tema claro de Material Design.
      home: NikeShoesStoreHome(), // Establece la pantalla principal de la aplicación.
    );
  }  
}

// Clase principal para la página inicial de la tienda.
class NikeShoesStoreHome extends StatelessWidget {
  NikeShoesStoreHome({super.key}); // Constructor.

  // Define un ValueNotifier para manejar la visibilidad de la barra inferior.
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  // Método que se ejecuta cuando se selecciona un zapato.
  void _onShoesPressed(NikeShoes shoes, BuildContext context) async {
    notifierBottomBarVisible.value = false; // Oculta la barra inferior.
    await Navigator.of(context).push( // Navega hacia la pantalla de detalles con una transición.
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1, // Aplica un efecto de transición de desvanecimiento.
            child: NikeShoesDetails(shoes: shoes), // Muestra la página de detalles.
          );
        },
      ),
    );
    notifierBottomBarVisible.value = true; // Vuelve a mostrar la barra inferior.
  }

  @override
  Widget build(BuildContext context) {
    // Devuelve la estructura visual principal.
    return Scaffold(
      backgroundColor: Colors.white, // Establece el fondo blanco.
      body: Stack(
        children: <Widget>[
          // Contenedor principal con un logo y lista de zapatos.
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Alinea los elementos en la columna.
              children: <Widget>[
                Image.asset('assets/nike_shoes_store/nike_logo.png', height: 40), // Muestra el logo de Nike.
                Expanded(
                  child: ListView.builder(
                    itemCount: shoes.length, // Número de elementos en la lista.
                    padding: const EdgeInsets.only(bottom: 40), // Espaciado inferior.
                    itemBuilder: (context, index) {
                      final shoesItem = shoes[index]; // Obtiene un zapato de la lista.
                      return NikeShoesItem(
                        shoesItem: shoesItem, 
                        onTap: () {
                          _onShoesPressed(shoesItem, context); // Navega a los detalles del zapato.
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Barra inferior animada.
          ValueListenableBuilder<bool>(
            valueListenable: notifierBottomBarVisible, // Escucha cambios en la visibilidad.
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 600), // Duración de la animación.
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight, // Posiciona la barra según su visibilidad.
                height: kToolbarHeight, // Altura estándar de la barra.
                child: Container(
                  color: Colors.white.withOpacity(0.7), // Fondo semi-transparente.
                  child: const Row(
                    children: <Widget>[
                      Expanded(child: Icon(Icons.home)), // Icono de inicio.
                      Expanded(child: Icon(Icons.search)), // Icono de búsqueda.
                      Expanded(child: Icon(Icons.favorite_border)), // Icono de favoritos.
                      Expanded(child: Icon(Icons.shopping_cart_outlined)), // Icono de carrito.
                      Expanded(
                        child: Center(
                          child: CircleAvatar(
                            radius: 13, // Tamaño del avatar.
                            backgroundImage: AssetImage('assets/nike_shoes_store/icon_person.jpg'), // Imagen del avatar.
                          ),
                        ),
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

// Widget para mostrar cada zapato en la lista.
class NikeShoesItem extends StatelessWidget {
  const NikeShoesItem({super.key, required this.shoesItem, required this.onTap}); // Constructor.
  final NikeShoes shoesItem; // Información del zapato.
  final VoidCallback onTap; // Acción al hacer clic.

  @override
  Widget build(BuildContext context) {
    const itemHeight = 200.0; // Altura de cada tarjeta.
    return InkWell(
      onTap: onTap, // Acción al presionar la tarjeta.
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0), // Margen vertical.
        child: SizedBox(
          height: 200, // Altura del contenedor.
          child: Stack(
            fit: StackFit.expand, // Acomoda los elementos dentro del espacio disponible.
            children: <Widget>[
              // Fondo con color dinámico basado en el modelo.
              Positioned.fill(
                child: Hero(
                  tag: 'background_${shoesItem.model}', // Etiqueta única para animaciones.
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0), // Bordes redondeados.
                      color: Color(shoesItem.color), // Color dinámico del fondo.
                    ),
                  ),
                ),
              ),
              // Número del modelo en el fondo.
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'number_${shoesItem.model}',
                  child: SizedBox(
                    height: itemHeight * 0.8,
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                          shoesItem.modelNumber.toString(), // Número del modelo.
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.05), // Color tenue.
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Imagen del zapato.
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.65,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(
                    shoesItem.images.first, // Primera imagen del zapato.
                    fit: BoxFit.contain, // Ajusta la imagen al contenedor.
                  ),
                ),
              ),
              // Iconos interactivos.
              const Positioned(
                bottom: 20,
                left: 20,
                child: Icon(Icons.favorite_border, color: Colors.grey), // Icono de favoritos.
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: Icon(Icons.shopping_cart_outlined, color: Colors.grey), // Icono de carrito.
              ),
              // Información del zapato (modelo y precio).
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      shoesItem.model, // Nombre del modelo.
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}', // Precio anterior.
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough, // Subraya el precio como tachado.
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${shoesItem.currentPrice.toInt().toString()}', // Precio actual.
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
