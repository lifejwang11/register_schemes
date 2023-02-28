package com.wgg.registerschemes;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Color;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.blankj.utilcode.util.ActivityUtils;
import com.blankj.utilcode.util.AppUtils;
import com.blankj.utilcode.util.UriUtils;
import com.example.register_schemes.R;
import com.taobao.weex.dom.CSSShorthand;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RegisterActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String type="WX";
        Intent intent = getIntent();
        System.out.println("Action:"+intent.getAction());
        Uri uri = null;
        if (intent.getAction().equals(Intent.ACTION_SEND)){
            Bundle extras =intent.getExtras();
            if (extras != null){
                System.out.println("WX");
                uri = extras.getParcelable(Intent.EXTRA_STREAM);
            }else{
                uri = intent.getData();
                System.out.println("QQ");
            }
        }else if (intent.getAction().equals(Intent.ACTION_VIEW)){
            type = "QQ";
            uri = intent.getData();
            System.out.println("QQ");
        }
        Map map =new HashMap<String,String>();
        String fileName=uri.toString().split("/")[uri.toString().split("/").length-1];
        File file = UriUtils.uri2File(uri);
        if(file.exists()){
            System.out.println("成功获取文件"+"路径为"+file.getPath()+"name:"+ com.blankj.utilcode.util.FileUtils.getFileName(file));
            if(type.equals("QQ")){
                if(com.blankj.utilcode.util.FileUtils.isFileExists(file.getParent()+"/"+fileName)){
                    com.blankj.utilcode.util.FileUtils.delete(new File(file.getParent()+"/"+fileName));
                }
                boolean flag = com.blankj.utilcode.util.FileUtils.rename(file,fileName);
                System.out.println("flag"+flag);
                if(flag){
                    map.put("filePath",file.getParent() + File.separator + fileName);
                }else{
                    map.put("filePath",file.getPath());
                }
            }else{
                map.put("filePath",file.getPath());
            }
        }else{
            map.put("not","文件不存在");
        }
        map.put("fileName",fileName);
        com.wgg.registerschemes.FileUtils.fileMap = map;
        FrameLayout rootView = new FrameLayout(this);
        setContentView(rootView);
        openActivity(AppUtils.getAppPackageName());
        ActivityUtils.finishActivity(this);
    }

    public void openActivity(String appName) {
        // 获取包管理器
        PackageManager manager = getPackageManager();
        // 指定入口,启动类型,包名
        Intent intent = new Intent(Intent.ACTION_MAIN);//入口Main
        intent.addCategory(Intent.CATEGORY_LAUNCHER);// 启动LAUNCHER,跟MainActivity里面的配置类似
        intent.setPackage(appName);//包名
        //查询要启动的Activity
        List<ResolveInfo> apps = manager.queryIntentActivities(intent, 0);
        if (apps.size() > 0) {//如果包名存在
            ResolveInfo ri = apps.get(0);
            // //获取包名
            String packageName = ri.activityInfo.packageName;
            //获取app启动类型
            String className = ri.activityInfo.name;
            //组装包名和类名
            ComponentName cn = new ComponentName(packageName, className);
            //设置给Intent
            intent.setComponent(cn);
            //根据包名类型打开Activity
            startActivity(intent);
        } else {
            System.out.println("找不到");
//            Toast.makeText(this, "找不到包名;" + appName, Toast.LENGTH_SHORT).show();
        }
    }
}