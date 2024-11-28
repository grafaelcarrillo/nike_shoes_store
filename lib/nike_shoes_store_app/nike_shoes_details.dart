import 'package:flutter/material.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shoes.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/nike_shopping_cart.dart';
import 'package:nike_shoes_store/nike_shoes_store_app/shake_transition.dart';

class NikeShoesDetails extends StatelessWidget {
  NikeShoesDetails({super.key, required this.shoes});
  final NikeShoes shoes;

  final ValueNotifier<bool> notifierButtomVisible = ValueNotifier(false);

  Future<void> _openShoppingCart(BuildContext context) async{
    notifierButtomVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, animation2){
          return FadeTransition(
            opacity: animation1, 
            child: NikeShoppingCart(shoes: shoes),
          );
        },
      ),
    );
  notifierButtomVisible.value = true;
  }

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
                  height: size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Hero(
                          tag: 'background_${shoes.model}',
                          child: Container(
                            color: Color(shoes.color),
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
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      PageView.builder(itemCount: shoes.images.length, itemBuilder: (context, index){
                        final tag = index == 0 ? 'image_${shoes.model}' : 'image_${shoes.model}_$index';
                        return Container(
                          alignment: Alignment.center,
                          child: ShakeTransition(
                            axis: Axis.vertical,
                            duration: const Duration(milliseconds: 1400),
                            offset: 10,
                            child: Hero(
                              tag: tag,
                              child: Image.asset(shoes.images[index], height: 200, width: 200,)
                            ),
                          ),
                        );
                      }
                      ),
                    ],
                  ),
                );
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtomVisible.value = true;
    });
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset('assets/nike_shoes_store/nike_logo.png', height: 40,),
        leading: const BackButton(color: Colors.black,),
      ),
      body: Stack(
        fit: StackFit.expand,
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
                    children: <Widget> [
                      FloatingActionButton(
                        heroTag: 'fav_1',
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.favorite, color: Colors.black,),
                        onPressed: () {}
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        heroTag: 'fav_2',
                        backgroundColor: Colors.black,
                        child: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          _openShoppingCart(context);
                        }
                      ),
                    ],
                  ),
                ),
              );
            }
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
    return  Padding(
      padding: const EdgeInsets.all(5),
      child: Text('US $text', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11,),),
    );
  }
}