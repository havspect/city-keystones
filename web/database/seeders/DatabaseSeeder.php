<?php

namespace Database\Seeders;

use App\Models\Country;
use App\Models\City;
use App\Models\Keystone;
use App\Models\KeystoneImage;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        Country::factory()->count(5)
            ->has(
                City::factory()->count(5)
                    ->has(
                        Keystone::factory()->count(5)
                            ->has(KeystoneImage::factory()->count(5))
                    )
            )
            ->create();
    }
}
