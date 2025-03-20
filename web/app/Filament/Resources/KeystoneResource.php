<?php

namespace App\Filament\Resources;

use App\Filament\Resources\KeystoneResource\Pages;
use App\Filament\Resources\KeystoneResource\RelationManagers;
use App\Models\Keystone;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class KeystoneResource extends Resource
{
    protected static ?string $model = Keystone::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('title'),
                Forms\Components\TextInput::make('description'),
                Forms\Components\FileUpload::make('hero_image_url')
                    ->image()
                    ->disk('public'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
        ->columns([
                Tables\Columns\TextColumn::make('id'),
                Tables\Columns\TextColumn::make('title'),
                Tables\Columns\TextColumn::make('hero_image_url'),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListKeystones::route('/'),
            'create' => Pages\CreateKeystone::route('/create'),
            'edit' => Pages\EditKeystone::route('/{record}/edit'),
        ];
    }
}
