import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderClass extends StatelessWidget {
  const LoaderClass({super.key, this.colorOne, this.colorTwo});

  final Color? colorOne;
  final Color? colorTwo;

  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven
                ? colorOne ?? Colors.blue
                : colorTwo ?? Colors.blue.withValues(alpha: 0.5),
          ),
        );
      },
    );
  }
}

CancelFunc showLoading() {
  return BotToast.showCustomLoading(
      toastBuilder: (_) => Center(
              child: LoaderClass(
            colorOne: Colors.blue,
            colorTwo: Colors.blue.withValues(alpha: 0.5),
          )),
      animationDuration: const Duration(milliseconds: 300));
}
