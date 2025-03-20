<?php

use App\Http\Controllers\CollectionController;
use App\Models\Keystone;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use App\Models\User;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


// Route::post('/tokens/create', function (Request $request) {
//     $request->validate([
//         'token_name' => 'required',
//     ]);

//     $token = $request->user()->createToken($request->token_name);

//     return ['token' => $token->plainTextToken];
// });

// Mobile login
Route::post('/mobile/token', function (Request $request) {

    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'token_name' => 'required',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }
    return $user->createToken($request->device_name)->plainTextToken;
});

Route::apiResource('collections', controller: CollectionController::class)->middleware('auth:sanctum');
Route::apiResource('keystones', controller: Keystone::class)->middleware('auth:sanctum');