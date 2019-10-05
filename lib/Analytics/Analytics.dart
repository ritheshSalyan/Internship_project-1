import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics{
  static FirebaseAnalytics analytics =  FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer;



  static void analyticsBehaviour(String eventName,String className) async {
    analytics.logEvent(name: eventName);
    analytics.setCurrentScreen(screenName: className);
  }
  static void setUserId(String userId){
    analytics.setUserId(userId);
  }
}