package com.example.i_watt_app

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("bf6967bc-3e1d-4d4b-9012-62607ca3a4af")
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
    }

)
