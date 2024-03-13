
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig{
  static FirebaseOptions get platformOptions{
     if(Platform.isIOS) {
       //ios & mac
       return const FirebaseOptions(
         appId: '1:832808556224:ios:374589a6796be44772ff25',
         apiKey: 'AIzaSyBde6B1U5T4WnqYCwDRcpUdRsbf1qcrwPs',
         projectId: 'hiwetaan',
         messagingSenderId:'832808556224',
         iosBundleId: 'com.example.hiwetaan',
       );
     }else{
       //android
       return const FirebaseOptions(
         appId: '1:832808556224:android:f9b4f54ac3983d2d72ff25',
         apiKey: 'AIzaSyAywYGCPO5Y2pVKvLMBns_yOGi35M11G40',
         projectId:'com.example.hiwetaan',
         messagingSenderId: '832808556224',



       );
     }
     }

  }
