require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
  it 'a partir da tela inicial' do
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90'
    expect(page).to have_content 'Dimensão: 45cm x 70cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'e volta para a tela inicial' do
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end