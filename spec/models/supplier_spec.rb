require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false quando razão social é vazio' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        
        expect(supplier).not_to be_valid
      end

      it 'false quando nome fantasia é vazio' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        expect(supplier).not_to be_valid
      end

      it 'false quando cnpj é vazio' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        expect(supplier).not_to be_valid
      end

      it 'false quando endereço é vazio' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: '', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        expect(supplier).not_to be_valid
      end

      it 'false quando cidade é vazio' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: '', state: 'SP', email: 'contato@acme.com')

        expect(supplier).not_to be_valid
      end

      it 'false quando estado é vazio' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: '', email: 'contato@acme.com')

        expect(supplier).not_to be_valid
      end

      it 'false quando e-mail é vazio' do
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: '')

        expect(supplier).not_to be_valid
      end
    end
  end

  describe '#description' do
    it 'exibe razão social e cnpj' do
      supplier = Supplier.new(corporate_name: 'ACME LTDA', registration_number: '47176140000189')
  
      result = supplier.description
  
      expect(result).to eq 'ACME LTDA - 47176140000189'
    end
  end
end
