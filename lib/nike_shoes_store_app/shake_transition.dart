import 'package:flutter/material.dart';

/// Un widget personalizado que aplica una transición de "sacudida" a su hijo.
/// Este efecto de animación utiliza un desplazamiento gradual que se suaviza al final.
class ShakeTransition extends StatelessWidget {
  const ShakeTransition({
    super.key,
    required this.duration, // Duración de la animación
    required this.offset, // Desplazamiento máximo del efecto de sacudida
    this.axis = Axis.horizontal, // Dirección de la sacudida (horizontal o vertical)
    required this.child, // El widget hijo al que se aplicará la animación
  });

  final Widget child; // Widget al que se aplica la transición
  final Duration duration; // Tiempo que toma completar la animación
  final double offset; // Magnitud del desplazamiento en el eje especificado
  final Axis axis; // Eje de la sacudida (por defecto, horizontal)

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      // El widget hijo que será animado
      child: child,
      // Duración total de la animación
      duration: duration,
      // Curva de animación para suavizar el movimiento, aquí se usa elasticOut
      // para que el desplazamiento parezca rebotar suavemente.
      curve: Curves.elasticOut,
      // Define los valores inicial y final del Tween (1.0 a 0.0).
      // Esto controla la interpolación de los valores durante la animación.
      tween: Tween(begin: 1.0, end: 0.0),
      // Construye el widget animado en cada frame
      builder: (context, value, child) {
        return Transform.translate(
          // Aplica el desplazamiento en el eje definido (horizontal o vertical)
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0.0) // Desplazamiento horizontal
              : Offset(0.0, value * offset), // Desplazamiento vertical
          child: child, // El widget animado
        );
      },
    );
  }
}
