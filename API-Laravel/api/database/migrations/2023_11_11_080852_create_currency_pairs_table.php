<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('currency_pairs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('source_currency_id');
            $table->unsignedBigInteger('target_currency_id');
            $table->double('rate');
            $table->integer('hits');
            $table->timestamps();

            $table->foreign('source_currency_id')->references('id')->on('currency')->constrained()->onDelete('cascade');
            $table->foreign('target_currency_id')->references('id')->on('currency')->constrained()->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('currency_pairs');
    }
};
