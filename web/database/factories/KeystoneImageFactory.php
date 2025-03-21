<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Keystone;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\KeystoneImage>
 */
class KeystoneImageFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'image_url' => fake()->imageUrl(640, 480),
            'caption' => fake()->text(),
            'display_order' => fake()->numberBetween(1, 10),
            'keystone_id' => Keystone::factory(), // Add this line
        ];
    }
}
