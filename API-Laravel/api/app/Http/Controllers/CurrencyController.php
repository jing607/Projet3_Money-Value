<?php

namespace App\Http\Controllers;

use App\Models\Currency;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CurrencyController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $currencies = Currency::all();

        return response()->json($currencies, 200);
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
        $request->validate([
            'code' => 'required|max:3|unique:currency,code',
            'full_name' => 'required|max:30',
            'symbol' => 'required|max:5',
            'flag' => 'required|max:255',
        ]);

        $currency = new Currency();
        $currency->code = $request->input('code');
        $currency->full_name = $request->input('full_name');
        $currency->symbol = $request->input('symbol');
        $currency->flag = $request->input('flag');
        $currency->save();

        return response()->json(['message' => 'Devise ajoutée avec succès'], 201);
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
    public function update(Request $request, int $currency)
    {
        $validator = Validator::make($request->all(), [
            'code' => 'required|max:3|unique:currency,code,' . $currency,
            'full_name' => 'required|max:30',
            'symbol' => 'required|max:5',
            'flag' => 'required|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422); // 422 Unprocessable Entity
        }

        try {
            $currency = Currency::findOrFail($currency);

            $currency->code = $request->input('code');
            $currency->full_name = $request->input('full_name');
            $currency->symbol = $request->input('symbol');
            $currency->flag = $request->input('flag');

            $currency->save();

            return response()->json(['message' => 'Devise mise à jour avec succès'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Erreur lors de la mise à jour de la devise', 'error' => $e->getMessage()], 500); // 500 Internal Server Error
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $currency)
    {
        $selCurrency = Currency::find($currency);

        if (!$selCurrency) {
            return response()->json(['message' => 'Devises non trouvée'], 404);
        }

        $selCurrency->delete();

        return response()->json(['message' => 'Devises supprimée avec succès'], 200);
    }
}
