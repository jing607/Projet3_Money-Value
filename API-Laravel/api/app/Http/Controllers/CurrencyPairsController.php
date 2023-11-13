<?php

namespace App\Http\Controllers;

use App\Models\Currency;
use App\Models\CurrencyPairs;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CurrencyPairsController extends Controller
{
    /**
     * Display a partial listing of the resource.
     * Does not display hits
     */
    public function index()
    {
        if(Auth::check()){
            $currencyPairs = CurrencyPairs::with(['sourceCurrency', 'targetCurrency'])->get();
        } else {
            $currencyPairs = CurrencyPairs::with(['sourceCurrency', 'targetCurrency'])
            ->select('id', 'source_currency_id', 'target_currency_id', 'rate')
            ->get();
        }

        return response()->json($currencyPairs, 200);
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $sourceCurrency = Currency::where('id', $request->input('source_currency'))->firstOrFail();
            $targetCurrency = Currency::where('id', $request->input('target_currency'))->firstOrFail();
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json(['message' => 'Devise source ou cible non trouvée'], 404);
        }

        $request->validate([
            'source_currency' => 'required|exists:currency,id',
            'target_currency' => 'required|exists:currency,id|different:source_currency|unique:currency_pairs,source_currency_id,NULL,id,target_currency_id,' . $sourceCurrency->id,
            'rate' => 'required|numeric',
        ]);

        CurrencyPairs::firstOrCreate([
            'source_currency_id' => $sourceCurrency->id,
            'target_currency_id' => $targetCurrency->id,
        ], [
            'rate' => $request->input('rate'),
            'hits' => 0,
        ]);

        return response()->json(['message' => 'Paire de devises ajoutée avec succès'], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, int $currency_pair)
    {
        $request->validate([
            'rate' => 'required|numeric',
        ]);

        try {
            // Find the currency pair by ID
            $currencyPair = CurrencyPairs::findOrFail($currency_pair);

            // Update the rate
            $currencyPair->update([
                'rate' => (float) $request->input('rate'),
            ]);

            return response()->json(['message' => 'Paire de devises mise à jour avec succès'], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json(['message' => 'Paire de devises non trouvée'], 404);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Erreur lors de la mise à jour de la paire de devises', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $currency_pair)
    {
        try {
            // Find the currency pair by ID
            $currencyPair = CurrencyPairs::findOrFail($currency_pair);

            // Delete the currency pair
            $currencyPair->delete();

            return response()->json(['message' => 'Paire de devises supprimée avec succès'], 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json(['message' => 'Paire de devises non trouvée'], 404);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Erreur lors de la suppression de la paire de devises', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $source_currency_code
     * @param  int  $target_currency_code
     * @param  float  amount
     * @return \Illuminate\Http\Response
     */
    public function convertCurrency($source_currency_code, $target_currency_code, $amount)
    {
        $sourceCurrency = Currency::where('code', $source_currency_code)->first();
        $targetCurrency = Currency::where('code', $target_currency_code)->first();

        if (!$sourceCurrency || !$targetCurrency) {
            return response()->json(['message' => 'Devise source ou cible non trouvée'], 404);
        }

        $currencyPair = CurrencyPairs::where('source_currency_id', $sourceCurrency->id)
            ->where('target_currency_id', $targetCurrency->id)
            ->first();

        if (!$currencyPair) {
            return response()->json(['message' => 'Paire de devises non trouvée pour la conversion'], 404);
        }

        $conversionResult = $amount * $currencyPair->rate;

        return response()->json(['converted_amount' => $conversionResult], 200);
    }
}
