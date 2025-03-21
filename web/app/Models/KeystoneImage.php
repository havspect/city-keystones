<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KeystoneImage extends Model
{
    /** @use HasFactory<\Database\Factories\KeystoneImageFactory> */
    use HasFactory;

    protected $table = 'keystone_image';

    protected $fillable = [
        'image_url',
        'caption',
        'display_order',
    ];

    public function keystone()
    {
        return $this->belongsTo(Keystone::class);
    }

    protected $casts = [
        'display_order' => 'integer',
    ];

    public function uniqueIds()
    {
        return ['keystone_id', 'image_url'];
    }
}
