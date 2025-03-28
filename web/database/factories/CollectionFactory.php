<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Collection>
 */
class CollectionFactory extends Factory
{
    /**
     * The current password being used by the factory.
     */
    protected static ?string $password;
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            "name" => fake()->text((20)),
            "description" => fake()->text(),
            "hero_image_url" => fake()->imageUrl(640),
            "duration_minutes" => fake()->numberBetween(30, 180),
            "is_featured" => fake()->boolean(),
        ];
    }
}
