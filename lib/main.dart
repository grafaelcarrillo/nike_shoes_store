import 'package:flutter/material.dart';
// Importación de las bibliotecas necesarias para la interfaz gráfica en Flutter.

import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes_details.dart';
// Importación de módulos personalizados relacionados con la tienda de zapatos Nike.

void main() => runApp(const MyApp());
// Punto de entrada principal de la aplicación. `runApp` inicia la aplicación con el widget raíz `MyApp`.

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Clase principal que representa la aplicación. Es un widget sin estado (StatelessWidget).

  @override
  Widget build(BuildContext context) {
    // Método `build` que define la estructura visual de la aplicación.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Elimina el banner de "debug" en la esquina superior derecha.

      theme: ThemeData.light(),
      // Define el tema de la aplicación como claro.

      home: NikeShoesStoreHome(),
      // Define el widget inicial como `NikeShoesStoreHome`.
    );
  }
}

class NikeShoesStoreHome extends StatelessWidget {
  NikeShoesStoreHome({super.key});
  // Widget principal que representa la pantalla de inicio de la tienda de zapatos.

  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);
  // `ValueNotifier` se utiliza para notificar cambios en la visibilidad de la barra inferior.

  void _onShoesPressed(NikeShoes shoes, BuildContext context) async {
    // Método que se ejecuta al seleccionar un zapato de la lista.
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation1, animation2){
      return FadeTransition(
        opacity: animation1,
        child: NikeShoesDetails(),
        );
      },
    ));

    notifierBottomBarVisible.value = true;
    // Restaura la visibilidad de la barra inferior al regresar.
  }

  @override
  Widget build(BuildContext context) {
    // Método `build` que define la interfaz de esta pantalla.
    return Scaffold(
      backgroundColor: Colors.white,
      // Color de fondo de la pantalla.

      body: Stack(
        // `Stack` permite superponer widgets.
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            // Espaciado alrededor del contenido principal.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // Alinea los elementos horizontalmente para llenar todo el ancho.
              children: <Widget>[
                Image.asset('assets/nike_shoes_store/nike_logo.png', height: 40),
                // Muestra el logo de Nike.

                Expanded(
                  child: ListView.builder(
                    // Crea una lista desplazable de zapatos.
                    itemCount: shoes.length,
                    // Número de elementos en la lista.

                    padding: const EdgeInsets.only(bottom: 20),
                    // Margen inferior para evitar que los elementos queden muy pegados al borde.

                    itemBuilder: (context, index) {
                      final shoesItem = shoes[index];
                      // Recupera un zapato individual de la lista.

                      return NikeShoesItem(
                        // Crea un widget personalizado para cada zapato.
                        shoesItem: shoesItem,
                        onTap: () {
                          _onShoesPressed(shoesItem, context);
                          // Maneja la acción al tocar un zapato.
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          ValueListenableBuilder<bool>(
            // Escucha cambios en la visibilidad de la barra inferior.
            valueListenable: notifierBottomBarVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                // Anima la posición de la barra inferior.
                duration: const Duration(milliseconds: 600),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight,
                height: kToolbarHeight,
                child: Container(
                  // Barra inferior con iconos de navegación.
                  color: Colors.white.withOpacity(0.7),
                  child: const Row(
                    // Distribuye los iconos en la barra inferior.
                    children: <Widget>[
                      Expanded(
                        child: Icon(Icons.home),
                      ),
                      Expanded(
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: Icon(Icons.favorite_border),
                      ),
                      Expanded(
                        child: Icon(Icons.shopping_cart_outlined),
                      ),
                      Expanded(
                        child: Center(child: CircleAvatar(radius: 13, backgroundImage: AssetImage('assets/icon_person.png'),)),
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

class NikeShoesItem extends StatelessWidget {
  // Widget que representa cada elemento individual de zapato.
  const NikeShoesItem({super.key, required this.shoesItem, required this.onTap});

  final NikeShoes shoesItem;
  // Objeto que contiene la información del zapato.

  final VoidCallback onTap;
  // Función que se ejecuta al tocar este elemento.

  @override
  Widget build(BuildContext context) {
    const itemHeight = 290.0;
    // Altura predefinida para los elementos.

    return InkWell(
      // Widget táctil para manejar interacciones.
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SizedBox(
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Color(shoesItem.color),),
                ),
              ),
              Align(
                // Texto del número de modelo en el fondo.
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: itemHeight * 0.6,
                  child: FittedBox(
                    child: Text(shoesItem.modelNumber.toString(), style: TextStyle(color: Colors.black.withOpacity(0.05), fontWeight: FontWeight.bold,),),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.65,
                child: Image.asset(
                  shoesItem.images.first,  
                  fit: BoxFit.contain,
                ),
              ),
              const Positioned(
                // Icono de favorito.
                bottom: 20,
                left: 20,
                child: Icon(Icons.favorite_border, color: Colors.grey),
              ),
              const Positioned(
                // Icono de carrito.
                bottom: 20,
                right: 20,
                child: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  // Información del zapato: modelo, precio antiguo y precio actual.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      shoesItem.model,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}',
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${shoesItem.currentPrice.toInt().toString()}',
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
