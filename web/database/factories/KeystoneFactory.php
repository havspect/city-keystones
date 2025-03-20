<?php

namespace Database\Factories;

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
            'title' => fake()->name(),
            'description' => fake()->text(),
            'latitude' => fake()->latitude(),
            'longitude' => fake()->longitude(),
            'hero_image_url' => fake()->imageUrl(640, 320),
        ];
    }
}
