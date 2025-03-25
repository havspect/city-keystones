<?php

use App\Http\Controllers\CollectionController;
use App\Http\Controllers\KeystoneController;
use App\Models\Keystone;
use Illuminate\Http\Request;
use App\Http\Controllers\CityController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use App\Models\User;
use Illuminate\Support\Facades\Hash;


Route::get('/user', UserController::class)->middleware('auth:sanctum');


// Route::post('/tokens/create', function (Request $request) {
//     $request->validate([
//         'token_name' => 'required',
//     ]);

//     $token = $request->user()->createToken($request->token_name);

//     return ['token' => $token->plainTextToken];
// });

// Mobile login
Route::post('/login', function (Request $request) {

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
    return $user->createToken($request->token_name)->plainTextToken;
});

Route::post('/register', function (Request $request) {
    $request->validate([
        'email'=> 'required|email',
        'password'=> 'required',
        'name' => 'required',
        'token_name' => 'required'
    ]);

    $user = User::where('email', $request->email)->first();

    if ($user) {
        throw ValidationException::withMessages([
            'email'=> ['The provided email already exists'],
            ]);
    }

    $user = User::create([
        'name'=> $request->name,
        'email'=> $request->email,
        'password'=> Hash::make($request->password),
    ]);

    return $user->createToken($request->token_name)->plainTextToken;
});

Route::apiResource('collections', controller: CollectionController::class)->middleware('auth:sanctum');
Route::apiResource('keystones', controller: KeystoneController::class)->middleware('auth:sanctum');
Route::apiResource('cities', controller: CityController::class)->middleware('auth:sanctum');