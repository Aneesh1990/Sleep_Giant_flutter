import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sleep_giant/Style/colors.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {

  // <editor-fold desc=" Build UI">
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Premium Plan"),
            flexibleSpace: Image(
              image: AssetImage('assets/theme_bg.png'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.orange),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body:Container(
          decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/theme_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40,right: 10,left:10,bottom: 100),
              child: Html(
                    defaultTextStyle: TextStyle(color: AppColors.white),
              data: """
                              What is included in your purchase the Sleep Giant - Sleep Fitness system featuring Brain Sugar audio AtmospheresTM support for all aspects of sleep and recovery.<br /><br />Included in the system<br /><br />Components<br /><br />1. The Sleep Giant dedicated App<br />2. Zero-G Halo (bone conduction headset) for<br />&nbsp;&nbsp;&nbsp; active listening without restriction<br />3. Zero-G Vibe (mini vibrational speaker)<br />&nbsp;&nbsp;&nbsp; create audio atmosphere in any space<br />4. Zero-G Bubble (noise cancelling<br />&nbsp;&nbsp;&nbsp; headphones) nap anywhere in your own<br />&nbsp;&nbsp;&nbsp; “bubble”<br />5. Zero-G Thredz (light weight ear buds)<br />&nbsp;&nbsp;&nbsp; utility headset – use with any Brian Sugar<br />&nbsp;&nbsp;&nbsp; Giant Atmospheres<br />6. Zero-G Eye Blanket (Eye Cover) combine<br />&nbsp;&nbsp;&nbsp; with Zero-G Bubble to create a sleep<br />&nbsp;&nbsp;&nbsp; environment anywhere<br />7. Travel carry case<br />8. 12 Month Brain Sugar Subscription – new<br />&nbsp;&nbsp;&nbsp; Atmospheres, Sleep Fit updates<br /><br />Brain Sugar audio Atmoshperes&trade;<br /><br />Sleep Deck – programable all night sleep support -  in the morning.<br /><br />&#8226;&nbsp; Wind Down – sleep preparation before bed<br />&nbsp;&nbsp;&nbsp; use w/ Zero-G Halo<br />&#8226;&nbsp; Deep Sleep –  full cycle all night sleep<br />&nbsp;&nbsp;&nbsp; support<br />&#8226;&nbsp; Wake Up – wakes you up gently in the<br />&nbsp;&nbsp;&nbsp; morning<br /><br />Nap Recovery Atmospheres<br /><br />&#8226;&nbsp; Ninja Nap – (15 minutes) maintain Ninja<br />&nbsp;&nbsp;&nbsp; mind/body sharpness during your busy day<br />&#8226;&nbsp; CatNap – (30 minutes) visit deep sleep<br />&nbsp;&nbsp;&nbsp; briefly and brings you back to fully awake<br />&nbsp;&nbsp;&nbsp; refreshed<br /><br />After you place your order you will receive your premium license access pin along with your kit – this pin will allow you to upgrade the App to access all services.
                              """,
              padding: EdgeInsets.all(8.0),
              onLinkTap: (url) {
              print("Opening $url...");
              },
              ),
            ),
            ),
            Positioned(bottom: 0,child:Container(height: 100,color: AppColors.primary_color,
              child: Center(
                child: Container(height: 60,width:MediaQuery.of(context).size.width,child: Padding(
                  padding: const EdgeInsets.only(left:30.0,right: 30.0),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.transparent)),
                    onPressed: ()  {





                    },
                    color: AppColors.your_sleep_deck_color_button,
                    textColor: AppColors.white,
                    child: Text("PURCHASE SLEEP GIANT NOW",
                        style: TextStyle(fontSize: 14)),
                  ),
                ),),
              ),
            ) ,)

          ],
        )
    ));
  }
// </editor-fold>
}
