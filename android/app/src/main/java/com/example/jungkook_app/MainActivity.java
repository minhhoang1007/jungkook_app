package com.example.jungkook_app;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Environment;
import androidx.core.content.FileProvider;

import com.example.jungkook_app.utils.SharedPrefsUtils;
import com.example.ratedialog.RatingDialog;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class MainActivity extends FlutterActivity implements RatingDialog.RatingDialogInterFace {
    private static final String CHANNEL = "demo";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler((methodCall, result) -> {

            if (methodCall.method.equals("theme")) {
                String path = Environment.getExternalStorageDirectory().getPath()
                        + "/Android/data/com.example.theme_demo/files/myimage.png";
                String option = methodCall.argument("option");
                WallpaperManager wallpaperManager = WallpaperManager.getInstance(this);
                BitmapFactory.Options options = new BitmapFactory.Options();
                options.inSampleSize = 8;
                Bitmap bitmap = BitmapFactory.decodeFile(path);
                if (bitmap != null) {
                    new WallpaperAsy(wallpaperManager, option).execute(bitmap);
                }
            } else if (methodCall.method.equals("setwallpaper")) {
                String filePath = methodCall.argument("path");
                File file = new File(filePath);
                Uri photoURI = FileProvider.getUriForFile(getApplicationContext(), getApplicationContext().getPackageName() + ".provider", file);
                Intent intent = new Intent(Intent.ACTION_ATTACH_DATA);
                intent.addCategory(Intent.CATEGORY_DEFAULT);
                intent.setDataAndType(photoURI, "image/*");
                intent.putExtra("mimeType", "image/*");

                List<ResolveInfo> resInfoList = getPackageManager().queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY);
                for (ResolveInfo resolveInfo : resInfoList) {
                    grantUriPermission(getApplicationContext().getPackageName(), photoURI, Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
                }
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                setResult(RESULT_OK, intent);


                this.startActivity(Intent.createChooser(intent, "Set as:"));
            }
            else  if(methodCall.method.equals("rateAuto")){
                rateAuto();
            }
            else  if(methodCall.method.equals("rateManual")){
                rateManual();
            }
        });

    }

    @Override
    public void onDismiss() {

    }

    @Override
    public void onSubmit(float rating) {
        if (rating > 3) {
            rateApp(this);
            SharedPrefsUtils.getInstance(this).putInt("rate", 5);
        }
    }

    @Override
    public void onRatingChanged(float rating) {

    }

    class WallpaperAsy extends AsyncTask<Bitmap, Void, Void> {
    WallpaperManager mWallpaperManager;
    String option;

    public WallpaperAsy(WallpaperManager wallpaperManager, String option) {
      mWallpaperManager = wallpaperManager;
      this.option = option;
    }

    @SuppressLint("MissingPermission")
    @Override
    protected Void doInBackground(Bitmap... bitmaps) {
      try {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
          if (option.equals("home")) {
            mWallpaperManager.setBitmap(bitmaps[0], null, true, WallpaperManager.FLAG_SYSTEM);
          }
          if (option.equals("lock")) {
            mWallpaperManager.setBitmap(bitmaps[0], null, true, WallpaperManager.FLAG_LOCK);
          }
          if (option.equals("both")) {
            mWallpaperManager.setBitmap(bitmaps[0], null, true, WallpaperManager.FLAG_LOCK);
            mWallpaperManager.setBitmap(bitmaps[0], null, true, WallpaperManager.FLAG_SYSTEM);
          }
        } else
          mWallpaperManager.setBitmap(bitmaps[0]);
      } catch (IOException e) {
        e.printStackTrace();
      }
      return null;
    }
  }
    public static void rateApp(Context context) {
        Intent intent = new Intent(new Intent(Intent.ACTION_VIEW,
                Uri.parse("http://play.google.com/store/apps/details?id=" + context.getPackageName())));
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }
    public void rateAuto() {
        int rate = SharedPrefsUtils.getInstance(this).getInt("rate");
        if (rate < 1) {
            RatingDialog ratingDialog = new RatingDialog(this);
            ratingDialog.setRatingDialogListener(this);
            ratingDialog.showDialog();
            SharedPrefsUtils.getInstance(this).putInt("rate", 5);

        }
    }
    void rateManual() {
        RatingDialog ratingDialog = new RatingDialog(this);
        ratingDialog.setRatingDialogListener(this);
        ratingDialog.showDialog();
    }

}
