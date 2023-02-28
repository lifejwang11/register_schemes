package com.wgg.registerschemes;

import android.app.Application;

import com.taobao.weex.WXSDKEngine;
import com.taobao.weex.common.WXException;

import io.dcloud.weex.AppHookProxy;

public class RegisterSchemesAppProxy implements AppHookProxy {
    @Override
    public void onCreate(Application application) {
        try {
            WXSDKEngine.registerModule("RegisterShemes",RegisterSchemeModule.class);
        } catch (WXException e) {
            e.printStackTrace();
        }

    }





}
