package com.wgg.registerschemes;

import com.alibaba.fastjson.JSONObject;
import com.taobao.weex.WXSDKEngine;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;

import java.util.HashMap;
import java.util.Map;

public class RegisterSchemeModule extends WXSDKEngine.DestroyableModule {

    @JSMethod(uiThread = true)
    public void render(JSONObject options, JSCallback jsCallback){
        FileUtils.fileMap.put("result","Success");
        System.out.println(43241431);
        jsCallback.invoke(FileUtils.fileMap);
        System.out.println(FileUtils.fileMap.get("fileName"));
    }

    @JSMethod(uiThread = true)
    public void removeObj(JSONObject options, JSCallback jsCallback){
        FileUtils.fileMap = new HashMap<>();
        Map map = new HashMap<>();
        map.put("result","Success");
        jsCallback.invoke(map);
    }


    @Override
    public void destroy() {

    }





}
