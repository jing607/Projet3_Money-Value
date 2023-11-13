<?php

namespace Database\Seeders;

use App\Models\Currency;
use Illuminate\Database\Seeder;

class CurrencySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Currency::create([
            'code' => 'USD',
            'full_name' => 'United States Dollar',
            'symbol' => '$',
            'flag' => 'us_flag.png',
        ]);

        Currency::create([
            'code' => 'EUR',
            'full_name' => 'Euro',
            'symbol' => '€',
            'flag' => 'eu_flag.png',
        ]);
    }
}
