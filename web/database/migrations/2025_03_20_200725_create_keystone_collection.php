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
        Schema::create('collection_keystone', function (Blueprint $table) {
            $table->foreignId('collection_id')->constrained();
            $table->foreignId('keystone_id')->constrained();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('collection_keystone', function (Blueprint $table) {
            $table->dropForeign(['collection_id']);
            $table->dropForeign(['keystone_id']);
        });

        Schema::dropIfExists('collection_keystone');
    }
};
