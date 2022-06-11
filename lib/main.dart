import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gojek_home_page/theme_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gojek Home Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: ThemeColors.primary,
        ),
        scaffoldBackgroundColor: ThemeColors.white,
        fontFamily: 'Maison Neue',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<int> _currentNavBarIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const <Widget>[
          GojekHomePage(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentNavBarIndex,
        builder: (_, int currentIndex, __) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: _onNavBarItemTapped,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedItemColor: Colors.grey[400],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: Colors.grey[400]),
            selectedItemColor: ThemeColors.primary,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  child: Stack(
                    children: <Widget>[
                      const Icon(Icons.percent),
                      Positioned(
                        right: -0.1,
                        top: 0.1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: ThemeColors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                label: 'Promos',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24,
                  child: Stack(
                    children: <Widget>[
                      const Icon(Icons.chat),
                      const Icon(Icons.percent),
                      Positioned(
                        right: -0.5,
                        top: 0.1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: ThemeColors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                label: 'Chat',
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _currentNavBarIndex.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarItemTapped(int index) {
    _currentNavBarIndex.value = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}

class GojekHomePage extends StatelessWidget {
  const GojekHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        GojekHomeAppBar(),
        SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        SliverToBoxAdapter(
          child: GopayBalanceContainer(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          sliver: GojekCategoryContainer(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 8),
        ),
        SliverToBoxAdapter(
          child: GojekLoyaltyLevelProgressContainer(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: GojekPromoContainer(),
        ),
      ],
    );
  }
}

class GojekHomeAppBar extends StatelessWidget {
  const GojekHomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey[700],
                ),
                hintText: 'Find services, food, or places',
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: ThemeColors.white,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.white),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeColors.white),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                constraints: const BoxConstraints(maxHeight: 40),
                contentPadding: const EdgeInsets.all(4),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundColor: ThemeColors.white,
            maxRadius: 20,
            child: Icon(
              Icons.person,
              color: ThemeColors.primary,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class GojekPromoContainer extends StatelessWidget {
  const GojekPromoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Saatnya panen GoPay Coins 😍',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Langsung klik buat nikmatin promonya!'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const PageScrollPhysics(),
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Promo 1',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Promo 1',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GojekLoyaltyLevelProgressContainer extends StatelessWidget {
  const GojekLoyaltyLevelProgressContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.orange[900],
            size: 40,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '126 XP to your next treasure',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0.4,
                  backgroundColor: Colors.grey[300],
                  color: ThemeColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.chevron_right_rounded,
            size: 30,
          ),
        ],
      ),
    );
  }
}

class GojekCategoryContainer extends StatelessWidget {
  const GojekCategoryContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 4,
      crossAxisSpacing: 16,
      children: <Widget>[
        Column(
          children: const <Widget>[
            Icon(
              Icons.motorcycle,
              color: ThemeColors.primary,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('GoRide'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.local_taxi,
              color: ThemeColors.primary,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('GoCar'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.restaurant,
              color: ThemeColors.red,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('GoFood'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.inventory_2,
              color: ThemeColors.primary,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('GoSend'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.local_mall,
              color: ThemeColors.red,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('GoMart'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.directions_bus,
              color: ThemeColors.primary,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('GoTransit'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.verified,
              color: ThemeColors.peduliLindungiBlue,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('Check in'),
          ],
        ),
        Column(
          children: const <Widget>[
            Icon(
              Icons.apps,
              size: 32,
            ),
            SizedBox(height: 4),
            Text('More'),
          ],
        ),
      ],
    );
  }
}

class GopayBalanceContainer extends StatelessWidget {
  const GopayBalanceContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: ThemeColors.darkBlue,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            margin: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'gopay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Rp64.667',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tap for history',
                  style: TextStyle(
                    color: ThemeColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: ThemeColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_upward_rounded,
                          color: ThemeColors.darkBlue,
                          size: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Pay',
                        style: TextStyle(
                          color: ThemeColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: ThemeColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: ThemeColors.darkBlue,
                          size: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Top Up',
                        style: TextStyle(
                          color: ThemeColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: ThemeColors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: const Icon(
                          Icons.rocket_launch,
                          color: ThemeColors.darkBlue,
                          size: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Explore',
                        style: TextStyle(
                          color: ThemeColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
