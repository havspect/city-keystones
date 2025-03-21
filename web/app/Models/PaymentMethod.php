<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentMethod extends Model
{
    /** @use HasFactory<\Database\Factories\PaymentMethodFactory> */
    use HasFactory;

    protected $table = 'payment_methods';

    protected $fillable = [
        'method_type',
        'provider',
        'account_number',
        'expiry_date',
        'is_default',
    ];

    protected $casts = [
        'is_default' => 'boolean',
        'expiry_date' => 'datetime',
    ];

    protected $attributes = [
        'is_default' => true,
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function transactions()
    {
        return $this->hasMany(Transaction::class);
    }
}
