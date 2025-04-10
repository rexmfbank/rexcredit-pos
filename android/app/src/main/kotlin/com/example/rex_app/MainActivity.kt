package com.rexmfb.mobile

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.rexmfb.mobile"
    private val REQUEST_CODE = 100
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startIntent" -> {
                        val packageName = call.argument<String>("packageName")
                        //val action = call.argument<String>("action")
                        val extraData = call.argument<String>("extraData")

                        if (packageName == null) {
                            result.error("INVALID_ARGUMENTS", "Package name must be provided", null)
                            return@setMethodCallHandler
                        }

                        val intent = Intent(packageName)
                        if (extraData != null) {
                            intent.putExtra("requestData", extraData)
                        }
                        pendingResult = result
                        startActivityForResult(intent, REQUEST_CODE)
                    }

                    "startIntentPrinter" -> {
                        val packageName = call.argument<String>("packageName")
                        //val action = call.argument<String>("action")
                        val extraData = call.argument<String>("extraData")

                        if (packageName == null) {
                            result.error("INVALID_ARGUMENTS", "Package name must be provided", null)
                            return@setMethodCallHandler
                        }

                        val intent = Intent(packageName)
                        if (extraData != null) {
                            intent.putExtra("jsonData", extraData)
                        }
                        pendingResult = result
                        startActivityForResult(intent, REQUEST_CODE)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            val returnedData = data?.getStringExtra("resultKey") ?: "No result"
            val status = data?.getStringExtra("status")
            val dataResponse = data?.getStringExtra("data")
            pendingResult?.success(dataResponse)
            pendingResult = null
        }
    }
}
