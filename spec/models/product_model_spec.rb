require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false quando nome é vazio' do
        supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        product_model = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        expect(product_model).not_to be_valid
      end

      it 'false quando peso é vazio' do
        supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        product_model = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        expect(product_model).not_to be_valid
      end

      it 'false quando largura é vazio' do
        supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        expect(product_model).not_to be_valid
      end

      it 'false quando altura é vazio' do
        supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        expect(product_model).not_to be_valid
      end

      it 'false quando profundidade é vazio' do
        supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '', sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        expect(product_model).not_to be_valid
      end

      it 'false quando SKU é vazio' do
        supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        product_model = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: '', supplier: supplier)

        expect(product_model).not_to be_valid
      end
    end
  end
end
