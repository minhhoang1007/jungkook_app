package com.example.jungkook_app;

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
import android.widget.Toast;

import androidx.core.content.FileProvider;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class MainActivity extends FlutterActivity {
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
    });
  }

  class WallpaperAsy extends AsyncTask<Bitmap, Void, Void> {
    WallpaperManager mWallpaperManager;
    String option;

    public WallpaperAsy(WallpaperManager wallpaperManager, String option) {
      mWallpaperManager = wallpaperManager;
      this.option = option;
    }

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
}
