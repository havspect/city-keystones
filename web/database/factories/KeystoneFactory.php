<?php

namespace Database\Factories;

use App\Models\City;
use App\Models\Keystone;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Keystone>
 */
class KeystoneFactory extends Factory
{
    /**
     * The current password being used by the factory.
     */
    protected static ?string $password;

    protected $model = Keystone::class;
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(20),
            'description' => fake()->text(),
            'latitude' => fake()->latitude(),
            'longitude' => fake()->longitude(),
            'hero_image_url' => fake()->imageUrl(640, 320),
            'address' => fake()->address(),
            'visit_duration_minutes' => fake()->numberBetween(30, 180),
            'city_id' => City::factory(),
        ];
    }
}
