<?php

use Illuminate\Support\Facades\Route;
use App\Models\User;
use Illuminate\Validation\ValidationException;

Route::get('/', function () {
    return view('welcome');
});

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

Route::post('register', function (Request $request) {
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