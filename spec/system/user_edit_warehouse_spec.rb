require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
    expect(page).to have_field('Código', with: 'GRU')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Área', with: '100000')
  end

  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão Internacional'
    fill_in 'Endereço', with: 'Avenida dos Galpões, 500'
    fill_in 'CEP', with: '16000-000'
    fill_in 'Área', with: '200000'
    click_on 'Enviar'

    expect(page).to have_content 'Galpão atualizado com sucesso!'
    expect(page).to have_content 'Galpão GRU'
    expect(page).to have_content 'Nome: Galpão Internacional'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Área: 200000 m²'
    expect(page).to have_content 'Endereço: Avenida dos Galpões, 500 CEP: 16000-000'
    expect(page).to have_content 'Galpão destinado para cargas internacionais'
  end

  it 'e mantém os campos obrigatórios' do
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Área', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão.'
  end
end