package com.example.startupreneur;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.view.WindowManager.LayoutParams;

public class TrialActivity extends FlutterActivity {
  private static final String CHANNEL = "hello.world.hi";
//  String hashSequence = cP1FIrbh|10|adhin|adhinsuper2@gmail.com|nTbaPsZskK;
//  String serverCalculatedHash= hashCal("SHA-512", hashSequence);


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

  }
}