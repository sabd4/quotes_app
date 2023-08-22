import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quotes_app/constants.dart';
import 'package:quotes_app/models/Quote.dart';
import 'package:quotes_app/models/RandomImage.dart';
import 'package:quotes_app/service/RandomQuote.dart';
import 'package:quotes_app/service/image_background.dart';
import 'package:share_plus/share_plus.dart';

class QuteImageScreen extends StatefulWidget {
  const QuteImageScreen({super.key});

  @override
  State<QuteImageScreen> createState() => _QuteImageScreenState();
}

class _QuteImageScreenState extends State<QuteImageScreen> {
  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytes;

  Future<void> _capturePng() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // if (boundary.debugNeedsPaint) {
    if (kDebugMode) {
      print("Waiting for boundary to be painted.");
    }
    await Future.delayed(const Duration(milliseconds: 20));
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    pngBytes = byteData!.buffer.asUint8List();
    if (kDebugMode) {
      print(pngBytes);
    }
    if (mounted) {
      _onShareXFileFromAssets(context, byteData);
    }
    // }
  }

  void _onShareXFileFromAssets(BuildContext context, ByteData? data) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // final data = await rootBundle.load('assets/flutter_logo.png');
    final buffer = data!.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'screen_shot.png',
          mimeType: 'image/png',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share result: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Shared to: ${result.raw}")
        ],
      ),
    );
  }

  Quote quote = Quote();
  bool _isLoaded = false;
  final ImageProvider _assetImage = const AssetImage('images/bg.jpg');
  late ImageProvider _imageProvider;
  RandomBackgroundImage randomBackgroundImage = RandomBackgroundImage();
  getQuote() async {
    // setState(() {
    //   _assetImage = AssetImage('images/bg.jpg');
    // });
    setState(() {
      _isLoaded = false;
    });
    quote = await RandomQuote().getRandomQuote();
    setState(() {});
    randomBackgroundImage = await RandomImageBackground()
        .getRandomBacgroundImage(quote.tags![0].toString());
    setState(() {
      _imageProvider = NetworkImage(randomBackgroundImage.url!);
      _imageProvider
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((image, synchronousCall) {
        setState(() {
          _isLoaded = true;
        });
      }));
    });
    // randomBackgroundImage = await getBackground();
  }

  loadImage() {}
  // Future<RandomBackgroundImage> getBackground(String category) async {
  //  return  await RandomImageBackground().getRandomBacgroundImage(category);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, //_capturePng,
        label: const Text('Take screenshot'),
        icon: const Icon(Icons.share_rounded),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.lightGreen,
                size: 40,
              ),
              onPressed: () {
                getQuote();
                setState(() {});
              },
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  // color: Colors.white,
                  // image: DecorationImage(image: AssetImage(''),),
                  ),
              child: Image(
                image: !_isLoaded ? _assetImage : _imageProvider,

                // randomBackgroundImage.url ??
                //     'https://images.unsplash.com/photo-1687121014163-68c94a1db365?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=1080&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY5MDExNDg5Nw&ixlib=rb-4.0.3&q=80&w=1920',
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.6),
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    quote.content ?? 'Quote.........',
                    style: quoteStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      quote.author ?? 'Author.......',
                      style: authorStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // FloatingActionButton(
            //   onPressed: () {},
            //   shape: ,
            //   child: Row(
            //     children: [

            //       Icon(
            //         Icons.share,
            //         size: 32,
            //         color: Colors.black,
            //       ),
            //       Text(
            //         'Take ScreenShot',
            //         style: TextStyle(
            //           color: Colors.black,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            //   Padding(
            //     padding: const EdgeInsets.only(top: 780.0, right: 20),
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            //       onPressed: () {},
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Icon(
            //             Icons.share,
            //             size: 32,
            //             color: Colors.black,
            //           ),
            //           Text(
            //             'Take ScreenShot',
            //             style: TextStyle(
            //               color: Colors.black,
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // MyHomePage(),
          ],
        ),
      ),
    );
  }
}
