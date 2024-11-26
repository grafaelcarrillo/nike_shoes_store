import 'package:flutter/material.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart';

double _buttonSizeWidth = 160;
double _buttonSizeHeight = 60;
double _buttonCircularSize = 60.0;
double _finalImageSize = 30.0;
double _imageSize = 120;
class NikeShoppingCart extends StatefulWidget {
  const NikeShoppingCart({super.key, required this.shoes});

  final NikeShoes shoes;

  @override
  State<NikeShoppingCart> createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation _animationResize;
  late Animation _animationMovementIn;
  late Animation _animationMovementOut;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2)));
    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.45, 0.6)));
    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0)));
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;
    final currentImageSize = (_imageSize * _animationResize.value).clamp(_finalImageSize, _imageSize);
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
      tween: Tween(begin: 1, end: 0.0),
      builder: (context, value, child){
        return Transform.translate(
          offset: Offset(0.0, value * size.height * 0.7),
          child: child,
        );
      },
      child: Container(
        height: (size.height * 0.7 * _animationResize.value).clamp(_buttonCircularSize, size.height * 0.7),
        width: (size.width * _animationResize.value).clamp(_buttonCircularSize, size.width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30), 
            topRight: const Radius.circular(30),
            bottomLeft: _animationResize.value == 1 ? const Radius.circular(0) : const Radius.circular(30),
            bottomRight: _animationResize.value == 1 ? const Radius.circular(0) : const Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationResize.value == 1.0 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(widget.shoes.images.first, height: currentImageSize,),
                  if (_animationResize.value == 1.0)...[
                  
                    const SizedBox(width: 20,),
                  
                    Column(
                      children: <Widget>[
                        Text(
                          widget.shoes.model,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                        Text(
                          '\$${widget.shoes.currentPrice.toInt.toString()}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
    final size = MediaQuery.of(context).size;
    return Material(
      
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        
        builder: (context, child) {
          final buttonSizeWidth = (_buttonSizeWidth * _animationResize.value).clamp(_buttonCircularSize, _buttonSizeWidth);
          final panelSizeWidth = (size.width * _animationResize.value).clamp(_buttonCircularSize, size.width);
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.black87,
                  ),
                ),
              ),
              Positioned.fill(
                child: Stack(
                  children: <Widget>[
                    if (_animationMovementIn.value != 1.0 )
                    Positioned(
                      top: size.height * 0.3 + (_animationMovementIn.value * size.height * 0.45),
                      left: size.width / 2 -panelSizeWidth/2,
                      width: panelSizeWidth,
                      child: _buildPanel(),
                    ),
                    Positioned(                  
                      bottom: (40 - (_animationMovementOut.value * 100)).toDouble(),
                      left: size.width / 2 - buttonSizeWidth / 2,
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        tween: Tween(begin: 1, end: 0.0),
                        builder: (context, value, child){
                          return Transform.translate(
                            offset: Offset(0.0, value * size.height * 0.7),
                            child: child,
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            _controller.forward();
                          },
                          child: Container(
                            width: buttonSizeWidth,
                            height: (_buttonSizeHeight * _animationResize.value).clamp(_buttonCircularSize, _buttonSizeHeight),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget> [
                                  const Expanded(
                                    child: Icon(
                                      Icons.shopping_cart, 
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (_animationResize.value == 1) ...[
                                    const SizedBox(width: 5,),
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'ADD TO CART', 
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ]
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
        }
      ),
    );
  }
}