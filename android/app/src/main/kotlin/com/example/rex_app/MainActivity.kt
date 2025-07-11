package com.rexmfb.mobile

import android.app.Activity
import android.content.ContentValues
import android.content.Intent
import android.os.Build
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.OutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.rexmfb.mobile"
    private val REQUEST_CODE = 100
    private val REQUEST_CODE_K11 = 524776
    private val REQUEST_CODE_PARAMETER = 135639
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

                    "startIntentParameter" -> {
                        val packageName = call.argument<String>("packageName")
                        val extraData = call.argument<String>("requestData")

                        if (packageName == null) {
                            result.error("INVALID_ARGUMENTS", "Package name must be provided", null)
                            return@setMethodCallHandler
                        }

                        val intent = Intent(packageName)
                        intent.putExtra("requestData", extraData)
                        pendingResult = result
                        startActivityForResult(intent, REQUEST_CODE_PARAMETER)
                    }

                    "startIntentK11" -> {
                        val packageName = call.argument<String>("packageName")
                        val requestData = call.argument<String>("requestData")

                        if (packageName == null) {
                            result.error("INVALID_ARGUMENTS", "Package name must be provided", null)
                            return@setMethodCallHandler
                        }

                        val pm = this.packageManager
                        val intent = pm.getLaunchIntentForPackage(packageName)
                        if (intent == null) {
                            result.error(
                                "NO_LAUNCH_INTENT",
                                "Cannot find launch intent for package $packageName",
                                null
                            )
                            return@setMethodCallHandler
                        }

                        if (requestData != null) {
                            intent.putExtra("requestData", requestData)
                        }
                        pendingResult = result
                        startActivityForResult(intent, REQUEST_CODE_K11)
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

                    "saveImageToGallery" -> {
                        val bytes = call.argument<ByteArray>("imageBytes")
                        val name = call.argument<String>("name")
                        val mimeType = call.argument<String>("mimeType") ?: "image/png"
                        val relativePath = call.argument<String>("relativePath") ?: "Pictures"
                        try {
                            val savedPath =
                                saveImageToMediaStore(bytes!!, name!!, mimeType, relativePath)
                            result.success(savedPath)
                        } catch (e: Exception) {
                            result.error("SAVE_FAILED", e.message, null)
                        }
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
        } else if (requestCode == REQUEST_CODE_K11 && resultCode == Activity.RESULT_OK) {
            val returnedData = data?.getStringExtra("resultKey") ?: "No result"
            val status = data?.getStringExtra("status")
            val dataResponse = data?.getStringExtra("data")
            pendingResult?.success(dataResponse)
            pendingResult = null
        } else if (requestCode == REQUEST_CODE_PARAMETER && resultCode == Activity.RESULT_OK) {
            val returnedData = data?.getStringExtra("resultKey") ?: "No result"
            val status = data?.getStringExtra("status")
            val dataResponse = data?.getStringExtra("data")
            pendingResult?.success(dataResponse)
            pendingResult = null
        }
    }

    private fun saveImageToMediaStore(
        bytes: ByteArray,
        name: String,
        mimeType: String,
        relativePath: String
    ): String {
        val resolver = contentResolver
        val contentValues = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, name)
            put(MediaStore.MediaColumns.MIME_TYPE, mimeType)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.MediaColumns.RELATIVE_PATH, relativePath)
                put(MediaStore.MediaColumns.IS_PENDING, 1)
            }
        }

        val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues)
            ?: throw Exception("Failed to create new MediaStore record.")

        resolver.openOutputStream(uri)?.use { stream: OutputStream ->
            stream.write(bytes)
            stream.flush()
        } ?: throw Exception("Failed to get output stream.")

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            contentValues.clear()
            contentValues.put(MediaStore.MediaColumns.IS_PENDING, 0)
            resolver.update(uri, contentValues, null, null)
        }
        return uri.toString()
    }
}
