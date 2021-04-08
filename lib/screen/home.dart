import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_twitter/blocs/home/home_bloc.dart';
import 'package:test_twitter/screen/splash.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc = HomeBloc();
  @override
  void initState() {
    _homeBloc.add(SelectPage(0));
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      bottomNavigationBar: BlocBuilder(
        bloc: _homeBloc,
        builder: (context, state) => _buildBottomNav(state.index),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (prev, state) => state is LogoutProfile,
        listener: (contex, state) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SplashScreen()),
              (route) => false);
        },
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is HomeInitial) {
            return _buildLoader();
          }
          if (state is RenderTimeline) {
            return _buildTweetsList(state.timelineTweets);
          }
          if (state is RenderProfile) {
            return _buildProfile(state.tweets);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  CustomScrollView _buildProfile(List<Tweet> tweets) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverAppBar(
          // title: Text(tweets.first.user.name),
          automaticallyImplyLeading: false,
          floating: true,
          pinned: true,
          flexibleSpace: Container(
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            tweets.first.user.profileImageUrlHttps,
                            scale: 0.6,
                          ),
                        ),
                        VerticalDivider(),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: tweets.first.user.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: " "),
                              TextSpan(
                                text: "@${tweets.first.user.screenName}",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          expandedHeight: 200,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildTweetWidget(tweets[index]),
            childCount: tweets.length,
          ),
        )
      ],
    );
  }

  BottomNavigationBar _buildBottomNav(int index) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (index) => _homeBloc.add(SelectPage(index)),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded), label: "Profile"),
        BottomNavigationBarItem(
            icon: Icon(Icons.login_rounded), label: "Logout"),
      ],
    );
  }

  ListView _buildTweetsList(List<Tweet> tweets) {
    return ListView(
      shrinkWrap: true,
      children: tweets.map((e) => _buildTweetWidget(e)).toList(),
    );
  }

  Padding _buildTweetWidget(Tweet tweet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          tileColor: Colors.white,
          leading:
              ClipOval(child: Image.network(tweet.user.profileImageUrlHttps)),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tweet.fullText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: tweet.user.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: " "),
                TextSpan(
                  text: "@${tweet.user.screenName}",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildLoader() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CircularProgressIndicator(),
          ),
          Text(
            'fetching some fresh tweets',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
