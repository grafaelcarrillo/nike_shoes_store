class NikeShoes {
  // Clase que representa un modelo de zapatos Nike.

  NikeShoes({
    // Constructor de la clase, requiere valores para todos los parámetros.
    required this.model, 
    required this.oldPrice, 
    required this.currentPrice, 
    required this.images, 
    required this.modelNumber,
    required this.color,
  });

  final String model; 
  // Nombre del modelo del zapato.

  final double oldPrice; 
  // Precio original del zapato antes de cualquier descuento.

  final double currentPrice; 
  // Precio actual del zapato con descuento (si aplica).

  final List<String> images; 
  // Lista de rutas de las imágenes del zapato.

  final int modelNumber; 
  // Número de modelo del zapato, que puede servir como identificador único o referencia.

  final int color; 
  // Código de color en formato hexadecimal (0xRRGGBB) que define el color principal asociado al zapato.
}

// Lista de objetos `NikeShoes` que representan los zapatos disponibles.
final shoes = <NikeShoes>[
  // Primer modelo de zapato.
  NikeShoes(
    model: 'AIR MAX 90 EZ BLACK', 
    // Nombre del modelo.

    oldPrice: 299, 
    // Precio original en la moneda configurada.

    currentPrice: 149, 
    // Precio actual, después del descuento.

    images: [
      // Lista de imágenes que representan diferentes vistas del zapato.
      'assets/nike_shoes_store/shoes1_1.png',
      'assets/nike_shoes_store/shoes1_2.png',
      'assets/nike_shoes_store/shoes1_3.png',
    ], 

    modelNumber: 90, 
    // Número del modelo específico.

    color: 0xFFF6F6F6, 
    // Color principal del zapato, representado como un valor hexadecimal.
  ),

  // Segundo modelo de zapato.
  NikeShoes(
    model: 'AIR MAX 270 Gold', 
    oldPrice: 349, 
    currentPrice: 199, 
    images: [
      'assets/nike_shoes_store/shoes2_1.png',
      'assets/nike_shoes_store/shoes2_2.png',
      'assets/nike_shoes_store/shoes2_3.png',
    ], 
    modelNumber: 270, 
    color: 0xFFFCF5EB, 
  ),

  // Tercer modelo de zapato.
  NikeShoes(
    model: 'AIR MAX 95 Red', 
    oldPrice: 399, 
    currentPrice: 299, 
    images: [
      'assets/nike_shoes_store/shoes3_1.png',
      'assets/nike_shoes_store/shoes3_2.png',
      'assets/nike_shoes_store/shoes3_3.png',
    ], 
    modelNumber: 95, 
    color: 0xFFFEEFEF,
  ),

  // Cuarto modelo de zapato.
  NikeShoes(
    model: 'AIR MAX 98 FREE', 
    oldPrice: 349, 
    currentPrice: 299, 
    images: [
      'assets/nike_shoes_store/shoes4_1.png',
      'assets/nike_shoes_store/shoes4_2.png',
      'assets/nike_shoes_store/shoes4_3.png',
    ], 
    modelNumber: 98, 
    color: 0xFFEDF3FE,
  ),
];
