<?php

namespace Database\Seeders;

use App\Models\CurrencyPairs;
use Illuminate\Database\Seeder;

class CurrencyPairSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        CurrencyPairs::create([
            'source_currency_id' => 1, // Remplacez par l'ID de la devise source souhaitée
            'target_currency_id' => 2, // Remplacez par l'ID de la devise cible souhaitée
            'rate' => 1.12,
            'hits' => 0,
        ]);
    }
}
