package com.example.startupreneur;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.view.WindowManager.LayoutParams;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class TrialActivity extends FlutterActivity {



  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    String hashSequence = "cP1FIrbh|10|adhin|adhinsuper2@gmail.com|KipwPSEQ510kB55rfTyMBSBzlU0bdzSzx2qNFQK0yXY=|nTbaPsZskK";
    String serverCalculatedHash= hashCal("SHA-512", hashSequence);
  }
  public static String hashCal(String type, String hashString) {
    StringBuilder hash = new StringBuilder();
    MessageDigest messageDigest = null;
    try {
      messageDigest = MessageDigest.getInstance(type);
      messageDigest.update(hashString.getBytes());
      byte[] mdbytes = messageDigest.digest();
      for (byte hashByte : mdbytes) {
        hash.append(Integer.toString((hashByte & 0xff) + 0x100, 16).substring(1));
      }
    } catch (NoSuchAlgorithmException e) {
      e.printStackTrace();
    }
    return hash.toString();
  }
}