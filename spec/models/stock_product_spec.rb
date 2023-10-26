require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Gera um número de série' do
    it 'ao criar um StrockProduct' do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Games', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
      other_warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', city: 'Rio de Janeiro', area: 1000, address: 'Endereço, 100', cep: '25000-000', description: 'Alguma descrição')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Games', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse: other_warehouse)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
