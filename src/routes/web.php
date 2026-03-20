<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json([
        'service' => 'test-k8s-api',
        'status' => 'ok',
    ]);
});
