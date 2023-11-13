<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CurrencyPairs extends Model
{
    use HasFactory;

    protected $table = 'currency_pairs';
    protected $fillable = ['source_currency_id', 'target_currency_id', 'rate', 'hits'];

    public function sourceCurrency() {
        return $this->belongsTo(Currency::class, 'source_currency_id');
    }

    public function targetCurrency() {
        return $this->belongsTo(Currency::class, 'target_currency_id');
    }
}
