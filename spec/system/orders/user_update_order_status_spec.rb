require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    mateus = User.create!(name: 'Mateus', email: 'mateus@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Games', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
    order = Order.create!(user: mateus, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as mateus
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 5
    expect(StockProduct.where(product_model: product, warehouse: warehouse).count).to eq 5
  end

  it 'e pedido foi cancelado' do
    mateus = User.create!(name: 'Mateus', email: 'mateus@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Games', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
    order = Order.create!(user: mateus, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    login_as mateus
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status do Pedido: Cancelado'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 0
  end
end