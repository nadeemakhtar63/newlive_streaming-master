

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AppUtile{
  static Future<String>buildDynmicLink()async{
    String url='https://lsukapp.page.link';
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters parameters=DynamicLinkParameters(
        link:Uri.parse('$url/post/54'),
        uriPrefix: url,
      androidParameters: const AndroidParameters(
        packageName: 'com.example.video_app_lsuk',
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        description: 'Join Meting Through Invitation',
        title: 'Breaking code post'
      ),
    );

    final ShortDynamicLink dynamicLink=await dynamicLinks.buildShortLink(parameters);
    return dynamicLink.shortUrl.toString();

  }
}