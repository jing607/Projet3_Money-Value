<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Laravel\Fortify\Http\Controllers\AuthenticatedSessionController as FortifyAuthenticatedSessionController;

class CustomLoginController extends FortifyAuthenticatedSessionController
{
    public function store(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            // Authentication passed...
            return response()->json(['message' => 'Login successful', 'token' => $this->guard()->user()->createToken('your-token-name')->plainTextToken]);
        }

        return response()->json(['message' => 'fail']);
    }

}
