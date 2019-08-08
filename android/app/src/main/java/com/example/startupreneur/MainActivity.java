package com.example.startupreneur;


import android.app.Activity;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.view.WindowManager.LayoutParams;
import android.widget.Toast;
import com.razorpay.Checkout;
import com.razorpay.PaymentResultListener;
import org.json.JSONObject;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements PaymentResultListener {

  private static final String CHANNEL = "pay";
  ProgressDialog dialog;
  boolean val = false;
  Result result;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    getWindow().addFlags(LayoutParams.FLAG_SECURE);

    Checkout.preload(getApplicationContext());
    dialog = new ProgressDialog(this);
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler((methodCall, result) -> {
      if(methodCall.method.equals("payment")){
        startPayment(result);
        Toast.makeText(getApplicationContext(),"Flutter toast",Toast.LENGTH_SHORT).show();
      }else{
        result.notImplemented();
      }
    });
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