<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CityResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "hero_image_url" => $this->hero_image_url,
            "country" => CountryResource::make($this->country),
            "keystones" => KeystoneResource::collection($this->keystones),
        ];
    }
}
