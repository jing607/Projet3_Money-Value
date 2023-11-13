<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

//api/v1/currency-pairs/...
Route::group(
    [
        'prefix' => config('app.apiversion'),
    ],
    function() {
        // endpoint permettant de vérifier que l'api fonctionne: /api/v1
        Route::get('/', function () {
            return response()->json(['message' => 'L\'API est fonctionnelle'], 200);
        });

        // routes du CurrencyPairsController
        Route::get('currency-pairs', 'CurrencyPairsController@index')->name('public.currency-pairs');
        Route::get('currency-pairs/convert/{source_currency_code}/{target_currency_code}/{amount}', 'CurrencyPairsController@convertCurrency')->name('public.api.conversion');
    }
);
