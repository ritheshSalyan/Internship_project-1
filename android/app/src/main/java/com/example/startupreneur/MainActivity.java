package com.example.startupreneur;


import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.WindowManager.LayoutParams;
import android.widget.Toast;

// import androidx.core.content.FileProvider;

import com.razorpay.Checkout;
import com.razorpay.PaymentResultListener;
import org.json.JSONObject;

import java.io.File;
import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements PaymentResultListener {

  private static final String CHANNEL = "pay";
  ProgressDialog dialog;
  boolean val = false;
  Result result;
  Context context;


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    getWindow().addFlags(LayoutParams.FLAG_SECURE);


    // getWindow().addFlags(LayoutParams.FLAG_SECURE);
    AppCenter.start(getApplication(), "696a4582-dec3-47fd-8b0b-b5db09558f99", Analytics.class);
    Analytics.trackEvent("My custom event");
    Checkout.preload(getApplicationContext());
    dialog = new ProgressDialog(this);
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler((methodCall, result) -> {
      if(methodCall.method.equals("payment")){
        startPayment(result);
        Toast.makeText(getApplicationContext(),"Flutter toast",Toast.LENGTH_SHORT).show();
      }
      else{
        result.notImplemented();
      }
    });

    new MethodChannel(getFlutterView(),"email").setMethodCallHandler((methodCall, result) -> {
      if(methodCall.method.equals("sendEmail")){
        String uriFile = methodCall.argument("attachment").toString();
        String toMail = methodCall.argument("toMail");
        String subject = methodCall.argument("subject");
        String body = methodCall.argument("body");
        sendEmail(toMail,subject,body,uriFile);
//        \ sendEmail(toMail,subject,body, Uri.fromFile(new File(uriFile)));
        result.success("done");
      }
      else{
        result.notImplemented();
      }
    });
  }

  private void sendEmail(String toMail,String subject,String body,String file) {
//    context.grantUriPermission("com.example.startupreneur",file,Intent.FLAG_GRANT_READ_URI_PERMISSION |Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
//    context.revokeUriPermission(file, Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
    Intent intent = new Intent(Intent.ACTION_SEND);
    intent.setType("application/pdf");
    intent.putExtra(Intent.EXTRA_EMAIL, new String[]{toMail});
    intent.putExtra(Intent.EXTRA_SUBJECT, subject);
    intent.putExtra(Intent.EXTRA_TEXT,body+"\n"+file);
    intent.putExtra(Intent.EXTRA_STREAM, file);
    startActivityForResult(Intent.createChooser(intent,"Send Email.."),200);
  }

  public void startPayment(Result result){
    Checkout checkout = new Checkout();
    checkout.setImage(com.razorpay.razorpay_flutter.R.drawable.rzp_logo);
    final Activity activity = this;
    try{
      JSONObject options = new JSONObject();
      options.put("name","Subramanya");
      options.put("amount","100");
      options.put("contact","8618992869");
      options.put("email","subramanyarao4@gmail.com");
      checkout.open(activity,options);
//      checkout.onSuccess();
      result.success(true);

    }catch (Exception e){
      Toast.makeText(getApplicationContext(),"Error"+e,Toast.LENGTH_SHORT).show();
    }
  }

  // @Override
  // protected void onActivityResult(int requestCode, int resultCode, Intent data) {
  //   // Check which request we're responding to
  //   if (requestCode == 200) {
  //     // Make sure the request was successful
  //     if (resultCode == RESULT_OK) {
  //       // The user picked a contact.
  //       // The Intent's data Uri identifies which contact was selected.
  //       Toast.makeText(getApplicationContext(),"Hey",Toast.LENGTH_SHORT).show();
  //       // Do something with the contact here (bigger example below)
  //     }
  //   }
  // }



  @Override
  public void onPaymentSuccess(String s) {
    Toast.makeText(getApplicationContext(),"Success",Toast.LENGTH_SHORT).show();
//    result.success(s);
  }

  @Override
  public void onPaymentError(int i, String s) {
    Toast.makeText(getApplicationContext(),"Failure"+i+s,Toast.LENGTH_SHORT).show();

  }
}