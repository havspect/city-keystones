<?php

namespace App\Filament\Resources\KeystoneResource\Pages;

use App\Filament\Resources\KeystoneResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditKeystone extends EditRecord
{
    protected static string $resource = KeystoneResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
