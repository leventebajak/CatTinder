import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'data/disk/disliked_model.dart';
import 'data/disk/liked_model.dart';
import 'ui/page/home.dart';
import 'ui/page/disliked.dart';
import 'ui/page/liked.dart';
import 'ui/navbar.dart';
import 'ui/my_colors.dart';
import 'provider/cards.dart';
import 'provider/liked.dart';
import 'provider/disliked.dart';

void main() async {
  // Initializing Hive
  await Hive.initFlutter();
  var dislikedBox = await Hive.openBox<List<String>>('dislikedBox');
  var dislikedModel = DislikedModel(dislikedBox);
  var likedBox = await Hive.openBox<List<String>>('likedBox');
  var likedModel = LikedModel(likedBox);

  runApp(CatTinderApp(
    likedModel,
    dislikedModel,
  ));

  // Changing the color of the navigation bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: MyColors.primary,
  ));
}

/// Main app
class CatTinderApp extends StatelessWidget {
  const CatTinderApp(this.likedModel, this.dislikedModel, {super.key});

  /// The model of liked images
  final LikedModel likedModel;

  /// The model of disliked images
  final DislikedModel dislikedModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayLarge: GoogleFonts.manrope(
            fontWeight: FontWeight.w800,
            color: MyColors.primary,
          ),
        ),
      ),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      home: CatTinderPage(likedModel, dislikedModel),
    );
  }
}

/// The main page of the app
class CatTinderPage extends StatefulWidget {
  const CatTinderPage(this.likedModel, this.dislikedModel, {super.key});

  /// The model of disliked images
  final DislikedModel dislikedModel;

  /// The model of liked images
  final LikedModel likedModel;

  @override
  State<CatTinderPage> createState() => _CatTinderPageState();
}

/// The state of the [CatTinderPage]
class _CatTinderPageState extends State<CatTinderPage> {
  var _currentPageIndex = 1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: Stack(
        children: [
          Container(
            height: height * 0.6,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.gradientStart,
                  MyColors.gradientEnd,
                ],
              ),
            ),
          ),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => LikedProvider(widget.likedModel),
              ),
              ChangeNotifierProvider(
                create: (context) => DislikedProvider(widget.dislikedModel),
              ),
              ChangeNotifierProvider(
                create: (context) => CardsProvider(
                  10,
                  widget.likedModel,
                  widget.dislikedModel,
                ),
              ),
            ],
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                /// Disliked page
                DislikedPage(),

                /// Cards page
                HomePage(),

                /// Liked page
                LikedPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
