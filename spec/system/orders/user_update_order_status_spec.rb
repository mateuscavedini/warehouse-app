require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    mateus = User.create!(name: 'Mateus', email: 'mateus@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user: mateus, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as mateus
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'
    
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
  end

  it 'e pedido foi cancelado' do
    mateus = User.create!(name: 'Mateus', email: 'mateus@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    order = Order.create!(user: mateus, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as mateus
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    
    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Status do Pedido: Cancelado'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(page).not_to have_button 'Marcar como CANCELADO'
  end
end