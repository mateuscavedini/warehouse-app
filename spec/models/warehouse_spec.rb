require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false quando nome é vazio' do
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

        expect(warehouse.valid?).to eq false
      end

      it 'false quando código é vazio' do
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'false quando endereço é vazio' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false quando cep é vazio' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio', area: 1000, description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false quando cidade é vazio' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: '', area: 1000, description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false quando área é vazio' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: '', description: 'Alguma descrição')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false quando descrição é vazio' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: '')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end

    context 'uniqueness' do
      it 'false quando código está em uso' do
        # Arrange
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida', cep: '35000-000', city: 'Niteroi', area: 1500, description: 'Outra descrição')

        # Act
        result = second_warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end

end
