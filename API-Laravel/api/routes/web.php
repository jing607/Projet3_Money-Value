<?php

use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Http\Controllers\AuthenticatedSessionController;
use Laravel\Fortify\Http\Controllers\RegisteredUserController;
use Laravel\Fortify\Http\Controllers\PasswordResetLinkController;
use Illuminate\Http\Request;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

$verificationLimiter = config('fortify.limiters.verification', '6,1');
const AUTH_SANCTUM = 'auth:sanctum';
const GUEST = 'guest:';

Route::get('/', function () {
    return redirect('https://disney.com');
});



// /auth/...
Route::group(
    [
        'prefix' => 'auth',
        'as' => 'auth',
    ],
    function() {
        $limiter = config('fortify.limiters.login');
        Route::post('/login', [AuthenticatedSessionController::class, 'store'])
        ->middleware(array_filter([
            GUEST . config('fortify.guard'),
            $limiter ? 'throttle:' . $limiter : null,
        ]))
        ->name('user.login');

        Route::post('/register', [RegisteredUserController::class, 'store'])
        ->middleware(([GUEST . config('fortify.guard')]))
        ->name('user.register');

        Route::post('/logout', [AuthenticatedSessionController::class, 'destroy'])
        ->middleware([GUEST, config('fortify.guard')])
        ->name('user.logout');

        Route::post('/forgot-password', [PasswordResetLinkController::class, 'store'])
        ->middleware([GUEST, config('fortify.guard')])
        ->name('forgot.password');

        Route::middleware(AUTH_SANCTUM)->get('/user', function (Request $request) {
            return $request->user();
        })->name('get.me');

    },
);


//admin/currency/...
Route::group(
    [
        'prefix' => 'admin',
    ],
    function() {

        // routes du CurrencyController
        Route::resource('currency', 'CurrencyController', ['except' => ['create', 'show', 'edit']])->middleware(AUTH_SANCTUM);
        Route::resource('currency-pairs', 'CurrencyPairsController', ['except' => ['create', 'show', 'edit']])->middleware(AUTH_SANCTUM);
        Route::get('currency-pairs', 'CurrencyPairsController@index')->name('admin.currency-pairs');
    }
);
