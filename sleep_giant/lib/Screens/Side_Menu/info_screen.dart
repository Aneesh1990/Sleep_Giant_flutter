import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';

import 'package:sleep_giant/Style/colors.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key key}) : super(key: key);

  void _onIntroEnd(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0);
    const box = BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/theme_bg.png"),
        fit: BoxFit.cover,
      ),
    );
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: AppColors.primary_color,
      imagePadding: EdgeInsets.zero,
    );
    return Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/theme_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              titleWidget: Text(
                "Welcome to the Sleep Giant\nSleep Fitness System\na new approch to sleep, health & life performance",
                style: TextStyle(color: Colors.white),
              ),
              bodyWidget: Text(
                "Featuring a comperhensive set of designed audio programs to support all aspects of improving and maximizing sleep fitness.\n\n Benefit from the same system that elite athletes and performers, students, parents, business people and travelers have been using to enhance their sleep, recovery and quality of life.",
                style: TextStyle(color: Colors.white),
              ),
              image: Align(
                child: Image.asset('assets/tutorial_image_1.png',
                    width: MediaQuery.of(context).size.width),
                alignment: Alignment.bottomCenter,
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Text(
                "Sleep Giant incorporates a complete set of sleep specific Brain Sugar Almospheres immersive audio soundscapes, with the ability to personalized your optimal sleep environment anywhere at any time.",
                style: TextStyle(color: Colors.white),
              ),
              bodyWidget: Text(
                "Sleep Fitness elements\n\n * Ready for bed - so sleep comes naturally when your head hits the pillow\n * Deep Sleep - improve sleep quality throughout the night\n * Wake up gently - end alarm clock shock\n Powerful Napping - drop into sleep quickly and wake up refreshed.",
                style: TextStyle(color: Colors.white),
              ),
              image: Align(
                child: Image.asset('assets/tutorial_image_2.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width),
                alignment: Alignment.bottomCenter,
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget: Text(
                "To maximize your sleep fitness, Sleep Giant offers the ability to custom program your sleep support each night - the Sleep Deck allows you to personalize each night's sleep to the time you have available.",
                style: TextStyle(color: Colors.white),
              ),
              bodyWidget: Text(
                "Whether you're travelling for business or a busy parent, studing for a test, getting ready for a game or want the benefit of really being sleep fit...",
                style: TextStyle(color: Colors.white),
              ),
              image: Align(
                child: Image.asset('assets/tutorial_image_3.png',
                    width: MediaQuery.of(context).size.width),
                alignment: Alignment.bottomCenter,
              ),
              footer: RaisedButton(
                onPressed: () {/* Nothing */},
                child: const Text(
                  'Purchase Now!',
                  style: TextStyle(color: Colors.white),
                ),
                color: AppColors.your_sleep_deck_color_button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          skip: const Text(
            'Skip',
            style: TextStyle(color: Colors.white),
          ),
          next: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          done: const Text(
            'Done',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ));
  }
}
