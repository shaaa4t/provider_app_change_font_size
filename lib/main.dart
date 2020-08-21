import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app_change_font_size/api/dummy_data.dart';
import 'package:provider_app_change_font_size/providers/font_size.dart';
import 'package:provider_app_change_font_size/providers/rate.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => RateNotifier(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FontSizeNotifier(),
        ),
      ],
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    print('the build tree has been rebuild !! ');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: Text('Data from API')),
            FutureBuilder(
              future: DummyData.getData(),
              builder: (context, snapshot) {
                return Center(
                    child: snapshot.connectionState == ConnectionState.done
                        ? Text(
                            snapshot.data.toString(),
                            style: TextStyle(color: Colors.red),
                          )
                        : CircularProgressIndicator());
              },
            ),
            SizedBox(
              height: 277,
            ),
            Selector<FontSizeNotifier, double>(
              selector: (context, fontSize)=>fontSize.getFontSize,
              builder: (context, fontSize, widget) {
                print("11");
                return Text(
                  'Rate us',
                  style: TextStyle(
                      fontSize: fontSize, color: Colors.red),
                );
              },
            ),
            SizedBox(
              height: 33,
            ),
            Selector<RateNotifier,double>(
              selector: (context, rate) => rate.getRate,
              builder: (context, rate, widget) {
                print("22");
                return getFaces(
                  rate.toInt(),
                );
              },
            ),
            Expanded(child: Container()),
            Text(
              'change the text size',
              style: TextStyle(color: Colors.white70),
            ),
            Consumer<FontSizeNotifier>(
              builder: (context, fontSizeNotifier, widget) {
                return Slider(
                  value: fontSizeNotifier.fontSize,
                  onChanged: (newValue) {
                    fontSizeNotifier.changeFontSize(newValue);
                  },
                  max: 50,
                  min: 20,
                );
              },
            ),
            Text(
              'rate them',
              style: TextStyle(color: Colors.white70),
            ),
            Consumer<RateNotifier>(
              builder: (context, rateNotifier, widget) {
                return Slider(
                  value: rateNotifier.rate,
                  onChanged: (newValue) {
                    rateNotifier.changeRating(newValue);
                  },
                  max: 4,
                  min: 0,
                );
              },
            ),
            SizedBox(
              height: 44,
            ),
          ],
        ),
      ),
    );
  }

  getFaces(int index) {
    switch (index) {
      case 0:
        return Icon(
          Icons.sentiment_very_dissatisfied,
          size: 60,
          color: Colors.red,
        );
      case 1:
        return Icon(
          Icons.sentiment_dissatisfied,
          size: 60,
          color: Colors.redAccent,
        );
      case 2:
        return Icon(
          Icons.sentiment_neutral,
          size: 60,
          color: Colors.amber,
        );
      case 3:
        return Icon(
          Icons.sentiment_satisfied,
          size: 60,
          color: Colors.lightGreen,
        );
      case 4:
        return Icon(
          Icons.sentiment_very_satisfied,
          size: 60,
          color: Colors.green,
        );
    }
  }
}
