import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';


/// Legacy intro/carousel screen. Can be added to routes if needed.
class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  int widgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: IndexedStack(
        index: widgetIndex,
        children: [
          _introImage(w, h, 1, "assets/images/intro_image/stImage.jpg", "", "Next",
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
          _introImage(w, h, 2, "assets/images/intro_image/stImage.jpg", "", "Next",
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
          _introImage(w, h, 3, "assets/images/intro_image/stImage.jpg", "", "Done",
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
        ],
      ),
    );
  }

  Container _introImage(double w, double h, int indexPage, String img, String headingImg, String btnText, String detailText) {
    return Container(
      width: w * 1,
      height: h * 1,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.fill)),
      child: Stack(
        children: [
          Positioned(
            right: w * .05,
            top: h * .05,
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: h * .06,
                child: Text("Skip",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: h * .02,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: w * 1,
              height: h * .3,
              decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                children: [
                  SizedBox(height: h * .01),
                  if (headingImg.isNotEmpty)
                    SizedBox(
                      height: h * .05,
                      width: w * .4,
                      child: Image.asset(headingImg),
                    ),
                  SizedBox(height: h * .01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(detailText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(3, (i) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: widgetIndex == i ? Colors.blue : Colors.grey,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          )),
                        ),
                        InkWell(
                          onTap: () {
                            if (btnText == "Done") {
                              Get.offAllNamed(Routes.login);
                            } else {
                              setState(() => widgetIndex = indexPage);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                Text("$btnText  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: h * .02,
                                        fontWeight: FontWeight.w400)),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
