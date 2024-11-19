import 'package:flutter/material.dart';

class NikeShoesDetails extends StatelessWidget {
  NikeShoesDetails({super.key});

  final ValueNotifier<bool> notifierButtomVisible = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifierButtomVisible.value = true;
    });
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder<bool>(
            valueListenable: notifierButtomVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight,
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
                        onPressed: () {}
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