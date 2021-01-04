import 'package:bloc_task/bloc/news_bloc.dart';
import 'package:bloc_task/components/navigation_bar.dart';
import 'package:bloc_task/model/news.dart';
import 'package:bloc_task/screens/webview_screen.dart';
import 'package:bloc_task/size_config.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    newsBloc.eventSink.add(NewsAction.Fetch);
  }

  @override
  void dispose() {
    super.dispose();
    newsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Color(0xffDB0162),
                    size: SizeConfig.screenWidth * 0.1,
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: SizeConfig.screenWidth * 0.1,
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: SizeConfig.screenWidth * 0.1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<News>(
                stream: newsBloc.newsStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffDB0162)),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error,
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.045,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.articles.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return getContentCard(
                            context,
                            index,
                            snapshot.data.articles[index].title,
                            snapshot.data.articles[index].urlToImage,
                            snapshot.data.articles[index].publishedAt,
                            snapshot.data.articles[index].url);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }

  Widget getContentCard(BuildContext context, int index, String title,
      String imageURL, DateTime publishedAt, String webPageURL) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebviewScreen(
                    webPageURL: webPageURL,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: imageURL == null
                  ? Icon(
                      Icons.terrain,
                      color: Colors.black,
                      size: SizeConfig.screenWidth * 0.1,
                    )
                  : Image.network(imageURL),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.045,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: Colors.black,
                  size: SizeConfig.screenWidth * 0.035,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '7.5M | ',
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.035,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Text(
                  '#cricket',
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.035,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Text(
                  timeago.format(publishedAt),
                  style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.035,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
