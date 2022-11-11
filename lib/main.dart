import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutteranimation/widgets/text_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<OutfitList> _list = OutfitList.generate();

  PageController? pageController;

  double viewportFraction = 0.6;

  double? pageOffset = 0;

  List<HeaderClass> topList = HeaderClass.generate();

  @override
  void initState() {
    WidgetsBinding.instance;

    pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page;
            });
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.04,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                    ),
                    color: Colors.black.withOpacity(0.7),
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                    ),
                    color: Colors.black.withOpacity(0.7),
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    color: Colors.black.withOpacity(0.7),
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextWidget(
                  text: 'Find your style',
                  textcolor: Colors.black,
                  textsize: 28,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: SizedBox(
                  height: height * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: Image.asset(
                                  topList[index].image,
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: TextWidget(
                                  text: topList[index].title,
                                  textcolor: Colors.black.withOpacity(0.7),
                                  textsize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.06,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              _slider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * 0.04,
                  ),
                  TextWidget(
                    text: 'Most Popular',
                    textcolor: Colors.black,
                    textsize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const Spacer(),
                  TextWidget(
                    text: 'See all',
                    textcolor: Colors.red,
                    textsize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.08,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/14.jpg',
                      height: height * 0.3,
                      width: width * 0.38,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/12.jpg',
                      height: height * 0.3,
                      width: width * 0.38,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _slider() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          double scale = max(viewportFraction,
              (1 - (pageOffset! - index).abs()) + viewportFraction);

          double angle = (pageOffset! - index).abs();

          if (angle > 0.5) {
            angle = 1 - angle;
          }
          return Container(
            padding: EdgeInsets.only(
              right: 10,
              left: 20,
              top: 60 - scale * 25,
              bottom: 10,
            ),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(
                  3,
                  2,
                  0.001,
                )
                ..rotateY(angle),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          _list[index].outfitUrl,
                          height: MediaQuery.of(context).size.height * 0.38,
                          width: MediaQuery.of(context).size.width * 0.44,
                          fit: BoxFit.cover,
                          alignment:
                              Alignment((pageOffset! - index).abs() * 0.5, 0),
                        ),
                      ),
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: AnimatedOpacity(
                      opacity: angle == 0 ? 1 : 0,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _list[index].outfitName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '€',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                _list[index].outfitPrice.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: _list.length,
      ),
    );
  }
}

class HeaderClass {
  String image;
  String title;
  HeaderClass({
    required this.image,
    required this.title,
  });

  static List<HeaderClass> generate() {
    return [
      HeaderClass(image: 'assets/images/1.jpg', title: 'All'),
      HeaderClass(image: 'assets/images/2.jpg', title: 'Man'),
      HeaderClass(image: 'assets/images/3.jpg', title: 'Woman'),
      HeaderClass(image: 'assets/images/4.jpg', title: 'Shoes'),
      HeaderClass(image: 'assets/images/5.jpg', title: 'Kids'),
      HeaderClass(image: 'assets/images/6.jpg', title: 'Jeans'),
    ];
  }
}

class OutfitList {
  String outfitUrl;
  String outfitName;
  int outfitPrice;
  OutfitList({
    required this.outfitUrl,
    required this.outfitName,
    required this.outfitPrice,
  });

  static List<OutfitList> generate() {
    return [
      OutfitList(
          outfitUrl: 'assets/images/7.jpg',
          outfitName: 'Casual Outfit',
          outfitPrice: 250),
      OutfitList(
          outfitUrl: 'assets/images/8.jpg',
          outfitName: 'Classic Outfit',
          outfitPrice: 390),
      OutfitList(
          outfitUrl: 'assets/images/9.jpg',
          outfitName: 'Party Outfit',
          outfitPrice: 470),
      OutfitList(
          outfitUrl: 'assets/images/10.jpg',
          outfitName: 'HipHop Outfit',
          outfitPrice: 250),
      OutfitList(
          outfitUrl: 'assets/images/11.jpg',
          outfitName: 'Classic Outfit',
          outfitPrice: 610),
      OutfitList(
          outfitUrl: 'assets/images/12.jpg',
          outfitName: 'Summer Outfit',
          outfitPrice: 540),
      OutfitList(
          outfitUrl: 'assets/images/13.jpg',
          outfitName: 'Classic Outfit',
          outfitPrice: 230),
      OutfitList(
          outfitUrl: 'assets/images/14.jpg',
          outfitName: 'Party Outfit',
          outfitPrice: 700),
    ];
  }
}
