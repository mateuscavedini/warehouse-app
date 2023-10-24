require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    mateus = User.create!(name: 'Mateus', email: 'mateus@email.com', password: 'password')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '47176140000189', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
    first_order = Order.create!(user: mateus, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    third_other = Order.create!(user: mateus, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as mateus
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).to have_content third_other.code
    expect(page).not_to have_content second_order.code
  end
end